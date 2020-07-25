import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/services/authentication_service.dart';

class LoginViewModel extends BaseViewModel {

  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authService = locator<AuthenticationService>();

  bool _isPhoneValid = false;
  get isPhoneValid => _isPhoneValid;

  void validatePhone(String value) {
    print(value.length);
    if(value.length==10){
      _isPhoneValid = true;
      notifyListeners();
    }
    else{
      _isPhoneValid = false;
      notifyListeners();
    }
  }


    Future<void> sendOTP({@required phoneNumber}) async {
      await _authService.sendCodeForAuth(phoneNumber: phoneNumber);
    }


}
