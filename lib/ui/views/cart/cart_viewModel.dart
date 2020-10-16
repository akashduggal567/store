import 'package:flutter/cupertino.dart';
import 'package:observable_ish/list/list.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/models/product.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/services/wishlist_service.dart';

class CartViewModel extends BaseViewModel {
  static CartService _cartService = locator<CartService>();
  WishListService _wishListService = locator<WishListService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  List<Product> _cartItems = _cartService.cartItemsList;
  get cartItemsList => _cartItems;

  double _totalCartAmount = _cartService.totalAmount.value;
  get totalCartAmount => _totalCartAmount;

  double _totalDiscountAmount = _cartService.totalDiscountAmount.value;
  get totalDiscountAmount => _totalDiscountAmount;

  double _totalAmountPayable = _cartService.totalAmountPayable.value;
  get totalAmountPayable => _totalAmountPayable;

  int _cartTotalItemCount = _cartService.totalItemCount.value;
  get cartTotalItemCount => _cartTotalItemCount;



  void calcualteBillattributes(){
    _totalCartAmount = _cartService.totalAmount.value;
    _totalDiscountAmount = _cartService.totalDiscountAmount.value;
    _totalAmountPayable = _cartService.totalAmountPayable.value;
    notifyListeners();
  }

  void removeCartItem(index , Product product) async{
   await _cartService.removeCartItem(index,product);
   _cartItems = _cartService.cartItemsList;
   notifyListeners();
   calcualteBillattributes();
   calculateTotalItemCount();

  }

  void addToWishList({@required id}){
    _wishListService.addToWishList(id);
  }

  void navigateToDashboard() async{
    await _navigationService.replaceWith(Routes.dashboardViewRoute);
  }

  void navigateToSelectAddressView() async{
    print(_cartService.cartItemsList[0].toJson());

//    await _navigationService.navigateTo(Routes.orderAddressViewRoute, arguments: OrderAddressViewArguments(totalAmountPayable: _totalAmountPayable));
  }

  void increaseCartItemCount(productDetails) async{
    setBusy(true);
    await _cartService.increaseCartItemCount(productDetails);
    setBusy(false);
    calcualteBillattributes();
    List mrp =  _cartItems.map((item){
      return item.quantity;
    }).toList();

    _cartTotalItemCount = _cartService.totalItemCount.value;
    notifyListeners();
  }

  void decreaseCartItemCount(Product productDetails) async {
    setBusy(true);
    bool response = await _cartService.decreaseCartItemCount(productDetails);
    setBusy(false);
    print("response after decreaseCartItemCount" + response.toString());
    if(response){
    calcualteBillattributes();
    List mrp =  _cartItems.map((item){
      return item.quantity;
    }).toList();
    _cartTotalItemCount = _cartService.totalItemCount.value;
    notifyListeners();
    }else{
      await _dialogService.showDialog(title: 'error', description: 'could not decrease cart count', buttonTitle: 'OK');
      List<Product> item =
      _cartItems.where((element) => element.id == productDetails.id).toList();
      int index = _cartItems.indexWhere((cartItem) => cartItem.id == item[0].id);
      print("item "+ index.toString());
      _cartItems[index].quantity = _cartItems[index].quantity+1;
      notifyListeners();
    }
  }

  void calculateTotalItemCount(){
    List mrp =  _cartItems.map((item){
      return item.quantity;
    }).toList();
    _cartTotalItemCount = mrp.fold(0, (previousValue, element) => previousValue+element);
    notifyListeners();
  }

}
