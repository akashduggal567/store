import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/setup_snackbar_ui.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/models/cartItem.dart';
import 'package:store/models/detailed_cart_item.dart';
import 'package:store/models/product.dart';
import 'package:store/services/api.dart';

@lazySingleton
class CartService with ReactiveServiceMixin {
  CartService() {
    listenToReactiveValues([
      _cartItems,
      _totalAmount,
      _totalDiscountAmount,
      _totalAmountPayable,
      _totalItemCount
    ]);
  }

  SnackbarService _snackbarService = locator<SnackbarService>();
  ApiService _apiService = locator<ApiService>();

  final _cartItems = RxList<Product>();
  get cartItemsList => _cartItems;

  RxValue<double> _totalAmount = RxValue<double>(initial: 0);
  get totalAmount => _totalAmount;

  RxValue<int> _totalItemCount = RxValue<int>(initial: 0);
  get totalItemCount => _totalItemCount;

  RxValue<double> _totalDiscountAmount = RxValue<double>(initial: 0);
  get totalDiscountAmount => _totalDiscountAmount;

  RxValue<double> _totalAmountPayable = RxValue<double>(initial: 0);
  get totalAmountPayable => _totalAmountPayable;

  void calculateTotalAmount() {
    List<double> mrp = _cartItems.map((item) {
      return double.parse(item.retailPrice) * item.quantity;
    }).toList();
    double amountCalculated =
        mrp.fold(0, (previousValue, element) => previousValue + element);
    _totalAmount.setCast(amountCalculated);
    notifyListeners();
  }

  void calculateTotalDiscountAmount() {
    List<double> mrp = _cartItems.map((item) {
      return (double.parse(item.retailPrice) - double.parse(item.salePrice)) *
          item.quantity;
    }).toList();
    double discountAmountCalculated =
        mrp.fold(0, (previousValue, element) => previousValue + element);
    _totalDiscountAmount.setCast(discountAmountCalculated);
    notifyListeners();
  }

  void calculateAmountPayable() {
    List<double> mrp = _cartItems.map((item) {
      return double.parse(item.salePrice) * item.quantity;
    }).toList();
    double totalAmountPayableCalculated =
        mrp.fold(0, (previousValue, element) => previousValue + element);
    _totalAmountPayable.setCast(totalAmountPayableCalculated);
    notifyListeners();
  }

  void calcualteBillattributes() {
    calculateTotalAmount();
    calculateTotalDiscountAmount();
    calculateAmountPayable();
  }

  Future removeCartItem(int index, Product product) async{
    await _apiService
        .removeItemfromCart(
            CartItem(productId: product.id.toString(), quantity: 0))
        .then((value) {
      _cartItems.removeAt(index);
      notifyListeners();
      calcualteBillattributes();
      _totalCartItemsCount();
      notifyListeners();

    });
  }

  void addToCart(Product product) {
    List<Product> item =
    _cartItems.where((element) => element.id == product.id).toList();

    if(item.length>0){
      print("already present in cart");
      increaseCartItemCount(product);
    }else{
      _apiService
          .addToCart(CartItem(productId: product.id.toString(), quantity: 1))
          .then((value) => null);
      _cartItems.add(product);
      calcualteBillattributes();
    }

    List<int> mrp = _cartItems.map((item) {
      return item.quantity.toInt();
    }).toList();

    _totalItemCount = RxValue(initial: mrp.reduce((a, b) => a + b));
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.blackAndWhite,
      message: 'Added to cart successfully',
      title: product.title,
      duration: Duration(seconds: 3),
    );
  }

  Future<bool> increaseCartItemCount(Product productDetails) async {
    print('calledIncrease');
    List<Product> item =
        _cartItems.where((element) => element.id == productDetails.id).toList();
    item[0].quantity = item[0].quantity + 1;
    ApiResponse response = await _apiService.addToCart(CartItem(
        productId: productDetails.id.toString(),
        quantity: item[0].quantity));

    calcualteBillattributes();
    List<int> mrp = _cartItems.map((item) {
      return item.quantity.toInt();
    }).toList();

    _totalItemCount = RxValue(initial: mrp.reduce((a, b) => a + b));
    return response.status == "success";
  }

  Future<bool> decreaseCartItemCount(Product productDetails) async {
    List<Product> item =
        _cartItems.where((element) => element.id == productDetails.id).toList();
//    if (item[0].cartCount == 1) {
//      _apiService
//          .addToCart(CartItem(
//          productId: productDetails.id.toString(),
//          quantity: item[0].cartCount))
//          .then((value) => item[0].cartCount = 1);
////      return;
//    } else {
    print("before decrease cart count " + item[0].quantity.toString());
    item[0].quantity = item[0].quantity - 1;
    ApiResponse response = await _apiService.addToCart(CartItem(
        productId: productDetails.id.toString(),
        quantity: item[0].quantity));
    calcualteBillattributes();
    List<int> mrp = _cartItems.map((item) {
      return item.quantity.toInt();
    }).toList();
    print(mrp.runtimeType);
    _totalItemCount = RxValue(initial: mrp.reduce((a, b) => a + b));
    return response.status == "success";
  }

  Future fetchUserCart() async {


    ApiResponse response = await _apiService.fetchUserCart();

    if(response!=null){
      if(response.result.length>0){
        var fetchedCartItems = response.result.map((e) => DetailedCartItem.fromJson(e)).toList();
        _cartItems.clear();
        var serialized =
        await fetchedCartItems.map((e) =>  _cartItems.add(serializeForCart(e))).toList();
        calcualteBillattributes();

        List<int> mrp = _cartItems.map((item) {
          return item.quantity.toInt();
        }).toList();

        _totalItemCount = mrp.length == 0
            ? RxValue(initial: 0)
            : RxValue(initial: mrp.reduce((a, b) => a + b));
      }
    }
//   _totalItemCount = mrp.fold(RxValue(initial: 0), (previousValue, element) => previousValue+element);
  }

  void emptyCart() async {
    _cartItems.clear();
    _totalItemCount = RxValue<int>(initial: 0);
  }

  Product serializeForCart(DetailedCartItem element) {
    Map<String, dynamic> result = {
      ...element.productId.toJson(),
      'quantity': element.quantity
    };
    return Product.fromJson(result);
  }

  void _totalCartItemsCount(){
    List<int> mrp = _cartItems.map((item) {
      return item.quantity.toInt();
    }).toList();
    if(mrp.length>0){
      _totalItemCount = RxValue(initial: mrp.reduce((a, b) => a + b));
    }else{
      _totalItemCount = RxValue(initial: 0);
    }

    print("TOTAL CART ITEMS :"+ _totalItemCount.toString());
    notifyListeners();
  }
}
