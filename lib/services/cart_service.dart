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
      return double.parse(item.retailPrice) * item.cartQuantity;
    }).toList();
    double amountCalculated =
        mrp.fold(0, (previousValue, element) => previousValue + element);
    _totalAmount.setCast(amountCalculated);
    notifyListeners();
  }

  void calculateTotalDiscountAmount() {
    List<double> mrp = _cartItems.map((item) {
      return (double.parse(item.retailPrice) - double.parse(item.salePrice)) *
          item.cartQuantity;
    }).toList();
    double discountAmountCalculated =
        mrp.fold(0, (previousValue, element) => previousValue + element);
    _totalDiscountAmount.setCast(discountAmountCalculated);
    notifyListeners();
  }

  void calculateAmountPayable() {
    List<double> mrp = _cartItems.map((item) {
      return double.parse(item.salePrice) * item.cartQuantity;
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

  void removeCartItem(int index, Product product) async{
    return await _apiService
        .removeItemfromCart(
            CartItem(productId: product.id.toString(), cartQuantity: 0))
        .then((value) {
      _cartItems.removeAt(index);
      notifyListeners();
      print(_cartItems);
      calcualteBillattributes();
      notifyListeners();
    });
  }

  void addToCart(Product product) {
    _apiService
        .addToCart(CartItem(productId: product.id.toString(), cartQuantity: 1))
        .then((value) => null);
    _cartItems.add(product);
    calcualteBillattributes();
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
    item[0].cartQuantity = item[0].cartQuantity + 1;
    ApiResponse response = await _apiService.addToCart(CartItem(
        productId: productDetails.id.toString(),
        cartQuantity: item[0].cartQuantity));

    calcualteBillattributes();
    List<int> mrp = _cartItems.map((item) {
      return item.cartQuantity.toInt();
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
//          cartQuantity: item[0].cartCount))
//          .then((value) => item[0].cartCount = 1);
////      return;
//    } else {
    print("before decrease cart count " + item[0].cartQuantity.toString());
    item[0].cartQuantity = item[0].cartQuantity - 1;
    ApiResponse response = await _apiService.addToCart(CartItem(
        productId: productDetails.id.toString(),
        cartQuantity: item[0].cartQuantity));
    calcualteBillattributes();
    List<int> mrp = _cartItems.map((item) {
      return item.cartQuantity.toInt();
    }).toList();
    print(mrp.runtimeType);
    _totalItemCount = RxValue(initial: mrp.reduce((a, b) => a + b));
    return response.status == "success";
  }

  void fetchUserCart() async {
    ApiResponse response = await _apiService.fetchUserCart();
    var a = response.result.map((e) => DetailedCartItem.fromJson(e)).toList();
    void serialized =
        a.map((e) => _cartItems.add(serializeForCart(e))).toList();
    calcualteBillattributes();
    List<int> mrp = _cartItems.map((item) {
      return item.cartQuantity.toInt();
    }).toList();
    print(mrp);
    _totalItemCount = mrp.length == 0
        ? RxValue(initial: 0)
        : RxValue(initial: mrp.reduce((a, b) => a + b));
//   _totalItemCount = mrp.fold(RxValue(initial: 0), (previousValue, element) => previousValue+element);
  }

  void emptyCart() async {
    _cartItems.clear();
    _totalItemCount = RxValue<int>(initial: 0);
  }

  Product serializeForCart(DetailedCartItem element) {
    print(element.cartQuantity);
    Map<String, dynamic> result = {
      ...element.productId.toJson(),
      'cart_quantity': element.cartQuantity
    };
    return Product.fromJson(result);
  }


//  }
}
