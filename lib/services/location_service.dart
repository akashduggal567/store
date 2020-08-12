import 'dart:async';

import 'package:location/location.dart';
import 'package:store/models/user_location.dart';

class LocationService{
  UserLocation _currentLocation;

  Location location = Location();

  StreamController<UserLocation> _locationController = StreamController<UserLocation>.broadcast();
  Stream<UserLocation> get locationStream => _locationController.stream;
  LocationService(){
    location.requestPermission().then((granted) {
      if(granted != null){
         print(granted.toString());
      }
    });
    _getLocation();
  }


  UserLocation get getLocation => _currentLocation;

  Future<UserLocation> _getLocation() async{
    try{
      var user_location = await location.getLocation();
      _currentLocation = UserLocation(
        latitude:  user_location.latitude,
        longitude: user_location.longitude
      );
    }catch(e){
      print("error : "+e.toString());
    }
    print("location"+ _currentLocation.toString());
    return _currentLocation;
  }


}