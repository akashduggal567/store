import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/models/user.dart';
//import 'package:store/models/user.dart';
import 'package:store/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';

class OtpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authService = locator<AuthenticationService>();

//  void navigateToUserRegisterScreen() async {
//    await _navigationService.navigateTo(Routes.userRegisterViewRoute);
//  }

  Future<void> verifyOtp(
      {@required verificationId, @required userInputOtp}) async {
    var result = await _authService.loginWithPhone(
        verificationId: verificationId, userInputOtp: userInputOtp);
    print(result.additionalUserInfo.isNewUser);
    if(!result.additionalUserInfo.isNewUser){
      FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
      User user = new User(
          mobileNumber: firebaseUser.phoneNumber,
          firebaseId: firebaseUser.uid);
      print(user.toJson());
      print("phoneNumber " + firebaseUser.phoneNumber);
      await _navigationService.navigateTo(Routes.dashboardViewRoute,);
//          arguments: UserRegisterViewArguments(user: user));
    }
//    else{
//      await _navigationService.navigateTo(Routes.dashboardRoute,arguments: DashboardArguments(
//        user: new User(),
//      ));
//    }
//    if(result.additionInfoUserInfo.isNewUser)

//    if (result is bool) {
//      if (result) {
//        print("RESULT," + result.toString());
//        FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
//        User user = new User(
//            mobileNumber: firebaseUser.phoneNumber,
//            firebaseId: firebaseUser.uid);
//        print(user.toJson());
//        print("phoneNumber " + firebaseUser.phoneNumber);
//        await _navigationService.navigateTo(Routes.userRegisterViewRoute,
//            arguments: UserRegisterViewArguments(user: user));
////        await _navigationService.clearStackAndShow(Routes.dashboardRoute,arguments: DashboardArguments(
////          user: user
////        ));
//      }
//    }
  }
}
