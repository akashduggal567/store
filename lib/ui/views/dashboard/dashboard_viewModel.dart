import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/services/authentication_service.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/services/location_service.dart';

class DashboardViewModel extends IndexTrackingViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();


  static CartService _cartService = locator<CartService>();
  String _cartCount = "";
  get cartCount => _cartCount;

  String getCartCount(){
    _cartCount = _cartService.cartItemsList.length.toString();
    print("cart Count on dashboard "+ _cartCount);
    notifyListeners();
//    return _cartService.cartItemsList.length.toString();

  }

  void naviagteToAddresses() async{
    await _navigationService.navigateTo(Routes.addressesViewRoute);
  }

  void signOutUser() async {
    await _authenticationService.logOut();
  }

  void navigateToCart() async{
    _navigationService.navigateTo(Routes.cartViewRoute);
  }

  void navigateToWishlist() async{
    _navigationService.navigateTo(Routes.wishListViewRoute);
  }



}
