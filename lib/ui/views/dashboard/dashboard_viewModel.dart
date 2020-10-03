import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/services/authentication_service.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/services/location_service.dart';
import 'package:store/ui/views/wishlist/wishlist_view.dart';

class DashboardViewModel extends IndexTrackingViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();


  static CartService _cartService = locator<CartService>();
  String _cartCount = _cartService.totalItemCount.value.toString();
  get cartCount => _cartCount;

  Future<String> getCartCount() async{
    await _cartService.fetchUserCart();
    _cartCount = _cartService.totalItemCount.value.toString();
    print("cart Count on dashboard "+ _cartService.totalItemCount.value.toString());
    notifyListeners();
//    return _cartService.cartItemsList.length.toString();

  }

  void naviagteToAddresses() async{

    await _navigationService.navigateTo(Routes.addressesViewRoute,);
  }

  void signOutUser() async {
    await _authenticationService.logOut();
  }

  void navigateToCart() async{
    _navigationService.navigateTo(Routes.cartViewRoute);
  }

  void navigateToWishlist() async{
    _navigationService.navigateWithTransition(WishListView(), transition: 'rightToLeft');
  }



}
