import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/models/product.dart';

@lazySingleton
class CartService with ReactiveServiceMixin {
  CartService() {
    listenToReactiveValues([_cartItems, _totalAmount, _totalDiscountAmount, _totalAmountPayable]);
  }

  SnackbarService _snackbarService = locator<SnackbarService>();
  final _cartItems = RxList<Product>();
  get cartItemsList => _cartItems;

  RxValue<double> _totalAmount = RxValue<double>(initial: 0);
  get totalAmount => _totalAmount;

  RxValue<double> _totalDiscountAmount = RxValue<double>(initial: 0);
  get totalDiscountAmount => _totalDiscountAmount;

  RxValue<double> _totalAmountPayable = RxValue<double>(initial: 0);
  get totalAmountPayable => _totalAmountPayable;



  void calculateTotalAmount(){
   List<double> mrp =  _cartItems.map((item){
      return double.parse(item.mrp);
    }).toList();
   double amountCalculated = mrp.fold(0, (previousValue, element) => previousValue+element);
   _totalAmount.setCast(amountCalculated);
   notifyListeners();
   print(_totalAmount.value);
  }

  void calculateTotalDiscountAmount() {
    List<double> mrp =  _cartItems.map((item){
      return double.parse(item.mrp) - double.parse(item.retailPrice);
    }).toList();
    double discountAmountCalculated = mrp.fold(0, (previousValue, element) => previousValue+element);
    _totalDiscountAmount.setCast(discountAmountCalculated);
    notifyListeners();
    print(_totalDiscountAmount.value);
  }
  void calculateAmountPayable() {
    List<double> mrp =  _cartItems.map((item){
      return double.parse(item.retailPrice);
    }).toList();
    double totalAmountPayableCalculated = mrp.fold(0, (previousValue, element) => previousValue+element);
    _totalAmountPayable.setCast(totalAmountPayableCalculated);
    notifyListeners();
    print(_totalAmountPayable.value);
  }


  void calcualteBillattributes(){
    calculateTotalAmount();
    calculateTotalDiscountAmount();
    calculateAmountPayable();
  }

  void removeCartItem(int index) {
    _cartItems.removeAt(index);
    calcualteBillattributes();
    print("Cart List: " + _cartItems.toString());
  }

  void addToCart(Product product) {
    _cartItems.add(product);
    calcualteBillattributes();
    _snackbarService.showCustomSnackBar(
        message: "Added to cart successfully",
        barBlur: 0,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(8),
        backgroundColor: Colors.black,
        borderColor: Colors.white);
    print("Cart List: " + _cartItems.toString());
  }


}
