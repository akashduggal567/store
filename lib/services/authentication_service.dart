import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/services/cart_service.dart';

@lazySingleton
class AuthenticationService {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CartService _cartService = locator<CartService>();


  Future<dynamic> sendCodeForAuth({
    @required phoneNumber,
  }) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
//      verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
//      verificationId = verId;
      print(phoneNumber);
      print("Signed In" + verId);
      _navigationService.navigateTo(Routes.otpViewRoute,
          arguments:
              OtpViewArguments(phoneNumber: phoneNumber, verificationId: verId));
    };
    print(smsCodeSent);
    final PhoneVerificationCompleted phoneVerificationCompleted =
        (AuthCredential credential) {
      print("Success v Successssssss");
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNumber,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 30),
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: veriFailed);
  }

  Future<AuthResult> loginWithPhone({
    @required verificationId,
    @required userInputOtp,
  }) async {
    try {
      AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: userInputOtp,
      );
      var authResult =
          await _firebaseAuth.signInWithCredential(credential).catchError((e) {
        print(e);
      });

      return authResult ;
    } catch (e) {}
  }

  Future signUpWithPhone() {}

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    return user != null;
  }

  Future logOut() {
    _firebaseAuth.signOut().then((value) async{
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          await _cartService.emptyCart();
        _navigationService.navigateTo(Routes.loginViewRoute);
    });

  }



}
