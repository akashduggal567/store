import 'dart:collection';
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/services/api.dart';

class MapViewModel extends BaseViewModel {
  Set<Marker> _allMarkers =  HashSet<Marker>();
  get allMarkers => _allMarkers;

  bool _isAddressCoordValid = false;
  get isAddressCoordValid => _isAddressCoordValid;

  DialogService _dialogService = locator<DialogService>();
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();

  void setMarker(){
    _allMarkers.add(
        Marker(
          markerId: MarkerId("1"),
          draggable: false,
          position: LatLng(30.9990820,75.9081479),

        )
    );
    notifyListeners();
  }

  Future<bool> validateLocation(lat,long) async {
    var distance = await getDistanceFromLatLonInKm(
        30.8950813, 75.9081479, lat, long);
    print("---------->" + distance.toString());
    distance <= 2.0000000000? print("valid Location") : _dialogService.showDialog(
    title: "Invalid Location",
    buttonTitle: "OK",
    description:  "We are sorry but the location selected is out of our delivery area."
        " \nPlease select different location. \n\nWe will expand shortly!",
    );
    _isAddressCoordValid = distance <= 2.0000000000;
    return _isAddressCoordValid;
  }

  double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in km
    print("distance  "+ d.toString());
    return double.parse((d).toStringAsFixed(10));
  }

  deg2rad(deg) {
    return deg * (pi / 180);
  }

  void navigateToEditAddressView({lang,long}) async{
    if(lang==null || long==null){
      _dialogService.showDialog(
        title: "Location Error",
        buttonTitle: "OK",
        description:  "Please select a location for delivery",
      );
    }else if(isAddressCoordValid ){
      await _navigationService.replaceWith(Routes.addAddressViewRoute,
          arguments: AddAddressViewArguments(langitude: lang ,longitude: long)
      );
    }

  }

  void setAddressAsInvalid() {
    _isAddressCoordValid = false;
    notifyListeners();
  }

}
