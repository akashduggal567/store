import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/app/setup_snackbar_ui.dart';
import 'package:store/helpers/enums/connectivity_status.dart';
import 'package:store/services/authentication_service.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/services/connectivity_service.dart';
import 'package:store/services/location_service.dart';
import 'package:store/ui/views/wishlist/wishlist_view.dart';

class DashboardViewModel extends IndexTrackingViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  Stream<ConnectivityStatus> _connectivityService =
      locator<ConnectivityService>().connectionStatusController.stream;


  static CartService _cartService = locator<CartService>();
  String _cartCount = _cartService.totalItemCount.value.toString();
  get cartCount => _cartCount;


  ConnectivityStatus _connectivityStatus;
  get connectivityStatus => _connectivityStatus;

  Future<String> getCartCount() async {


    await _cartService.fetchUserCart();
    _cartCount = _cartService.totalItemCount.value.toString();
    print("cart Count on dashboard " +
        _cartService.totalItemCount.value.toString());
    notifyListeners();


    _connectivityService.listen((event) {
      print("EVENT IN DASHBOARD = " + event.toString());
      _connectivityStatus = event;
      notifyListeners();
    });

  }


  showInternetDialog() {
      int counter = 0 ;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _navigationService.replaceWith(Routes.offlineViewRoute);
      });

//     _snackbarService.showCustomSnackBar(variant: SnackbarType.blackAndWhite, message: (counter+1).toString(), title: "Internet", duration: Duration(seconds: 4));
  }

  @override
  void dispose() {
    print('I have been disposed!!');
//    locator<ConnectivityService>().disposeSubscription();
    super.dispose();
  }

  void naviagteToAddresses() async {
    await _navigationService.navigateTo(
      Routes.addressesViewRoute,
    );
  }

  void signOutUser() async {
    await _authenticationService.logOut();
  }

  void navigateToCart() async {
    _navigationService.navigateTo(Routes.cartViewRoute);
  }

  void navigateToWishlist() async {
    _navigationService.navigateWithTransition(WishListView(),
        transition: 'rightToLeft');
  }
}
