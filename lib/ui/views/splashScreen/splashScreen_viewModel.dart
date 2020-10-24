import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/models/user.dart';
import 'package:store/services/api.dart';
//import 'package:store/models/user.dart';
import 'package:store/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/services/connectivity_service.dart';
import 'package:store/services/push_notification_service.dart';
import 'package:store/ui/views/dashboard/dashboard_view.dart';

class SplashScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final PushNotificationService _pushNotificationService = locator<PushNotificationService>();
  final CartService _cartService = locator<CartService>();
  final ApiService _apiService = locator<ApiService>();


  String _title = "DJ Vicinity";
  String get title => _title;

  Image _logo = Image.asset('assets/images/DJ LOGO@2x.png') ;
  Image get logo  => _logo;

  void navigateToLoginScreen() async{
    await _navigationService.navigateTo(Routes.loginViewRoute);
  }

  Future handleStartUpLogic() async{
    await _pushNotificationService.initialise();
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if(hasLoggedInUser){
      FirebaseUser firebaseUser = await  FirebaseAuth.instance.currentUser();
      User user = new User(
          mobileNumber: firebaseUser.phoneNumber,
          firebaseId: firebaseUser.uid
      );

      await _apiService.updateUserDeviceToken(await _pushNotificationService.getDeviceToken());
      await _navigationService.replaceWith(Routes.dashboardViewRoute,);
    }
    else{
      _navigationService.replaceWith(Routes.loginViewRoute);
    }
  }
}
