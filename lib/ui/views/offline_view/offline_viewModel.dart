import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/helpers/enums/connectivity_status.dart';
import 'package:store/services/authentication_service.dart';
import 'package:store/services/connectivity_service.dart';

class OfflineViewModel extends BaseViewModel {

  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  Stream<ConnectivityStatus> _connectivityService =
      locator<ConnectivityService>().connectionStatusController.stream;


  ConnectivityStatus _connectivityStatus;
  get connectivityStatus => _connectivityStatus;

  StreamSubscription subscription;

  navigateToDashboard() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _navigationService.popRepeated(1);
    });
}

  init() {
    subscription =  _connectivityService.listen((event) {
      print("EVENT IN Offline Page");
      _connectivityStatus = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

}
