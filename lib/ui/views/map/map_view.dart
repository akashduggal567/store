import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:store/ui/views/map/map_viewModel.dart';
import 'dart:math';


class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.nonReactive(
        builder: (context, model, child)=>Scaffold(
          appBar: AppBar(),
          floatingActionButton: FloatingActionButton(onPressed: (){
            getCurrentLocation();
          },),
          body: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(30.8950813,75.9081479),
              zoom: 14.456
            ),
            onMapCreated: (GoogleMapController controller){
                _controller = controller;
                print("created");
            },
          ),
        ),
        viewModelBuilder:() => MapViewModel());
  }

  void getCurrentLocation() async{
    var location =  await Location().getLocation();
    var distance =  await getDistanceFromLatLonInKm(30.8950813,75.9081479,30.9081994,75.8907956841681);
    print("location"+ distance.toString());
  }

  String getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2-lat1);  // deg2rad below
    var dLon = deg2rad(lon2-lon1);
    var a =
        sin(dLat/2) * sin(dLat/2) +
            cos(deg2rad(lat1)) * cos(deg2rad(lat2)) *
                sin(dLon/2) * sin(dLon/2)
    ;
    var c = 2 * atan2(sqrt(a), sqrt(1-a));
    var d = R * c; // Distance in km
    return double.parse((d).toStringAsFixed(1)).toString();
  }

  deg2rad(deg) {
    return deg * (pi/180);
  }
}
