import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/setup_snackbar_ui.dart';
import 'package:store/helpers/enums/connectivity_status.dart';

@lazySingleton
class ConnectivityService {
  // Create our public controller
  StreamController<ConnectivityStatus> connectionStatusController = StreamController<ConnectivityStatus>.broadcast();
  SnackbarService _snackbarService = locator<SnackbarService>();

  ConnectivityService() {
    // Subscribe to the connectivity Chanaged Steam
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Use Connectivity() here to gather more info if you need t
      connectionStatusController.stream.drain();
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }


  void disposeSubscription(){
    connectionStatusController?.close();
  }
}