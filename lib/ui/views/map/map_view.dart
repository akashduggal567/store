import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/ui/views/map/map_viewModel.dart';
import 'dart:math';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController _controller;
  Set<Circle> _circles = HashSet<Circle>();
  Set<Marker> _allMarkers = HashSet<Marker>();
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor sourceIcon;
  BitmapDescriptor homeMarkerIcon;
  var afterDragNewLat;
  var afterDrafNewLong;
  var _locationData;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCircle();
    _setMarkersIcons();
  }

  void _setMarkersIcons() async {
    sourceIcon = BitmapDescriptor.fromBytes(
        await _getBytesFromAsset('assets/images/shop_marker_bitmap.png', 100));
    homeMarkerIcon = BitmapDescriptor.fromBytes(
        await _getBytesFromAsset('assets/images/home_marker_bitmap.png', 100));
  }
  /// Return a image as bytes with the desidered width
  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    final ByteData data = await rootBundle.load(path);
    final Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    final FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void setCircle() {
    _circles.add(Circle(
        circleId: CircleId("0"),
        center: LatLng(30.8950813, 75.9081479),
        radius: 2000,
        strokeWidth: 2,
        fillColor: Colors.blue[100].withOpacity(0.3)));
//    _circles.add(Circle(
//        circleId: CircleId("1"),
//        center: LatLng(30.8950813, 75.9081479),
//        radius: 80,
//        strokeWidth: 2,
//        fillColor: Colors.blue[100].withOpacity(0.3)));
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.navigate_next,),
                mini: false,
                backgroundColor: Constants.tealColor,
                onPressed: (){
                    var lang = afterDragNewLat!=null?afterDragNewLat: _locationData!=null ?_locationData.latitude : null;
                    var long = afterDrafNewLong!=null? afterDrafNewLong: _locationData!=null ? _locationData.longitude : null ;
                    model.navigateToEditAddressView(lang:lang ,long:long);
                },
              ),
              body: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  GoogleMap(
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    markers: Set.of(_allMarkers),
                    circles: _circles,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(30.8950813, 75.9081479),
                      zoom: 13.9,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                      print("created");
                      setState(() {
                        _allMarkers.add(Marker(
                            markerId: MarkerId("0"),
                            draggable: false,
                            infoWindow: InfoWindow(
                              title: "Duggal General Store",
                              onTap: () {
                                print("marker tapped");
                              },
                            ),
                            position: LatLng(30.8950813, 75.9081479),
                            zIndex: 2,
                            flat: true,
                            anchor: Offset(0.5, 0.5),
                            icon: sourceIcon));
                      });

                    },
                  ),
                  Container(
                    width: 180,
                    margin: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: Constants.tealColor,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(Icons.my_location,color: Constants.offWhiteColor,),
                            Text("Current Location",style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      onPressed: ()async {
                        getCurrentLocation();
                        _locationData = await Location().getLocation();
                        print(_locationData);
                        setState(() {
                          _allMarkers = HashSet<Marker>();
                          _allMarkers.add(Marker(
                              markerId: MarkerId("0"),
                              draggable: false,
                              infoWindow: InfoWindow(
                                title: "Duggal General Store",
                                onTap: () {
                                  print("marker tapped");
                                },
                              ),
                              position: LatLng(30.8950813, 75.9081479),
                              zIndex: 2,
                              flat: true,
                              anchor: Offset(0.5, 0.5),
                              icon: sourceIcon));
                          _allMarkers.add(Marker(
                            markerId: MarkerId(afterDrafNewLong != null ? afterDragNewLat.toString()+afterDrafNewLong.toString() : _locationData.latitude.toString()+_locationData.longitude.toString()),
                            draggable: true,
                            icon: homeMarkerIcon,
                            onDragEnd: ((value) {
                              setState(() {
                                afterDragNewLat = value.latitude;
                                afterDrafNewLong = value.longitude;
                              });
                              model
                                  .validateLocation(value.latitude, value.longitude)
                                  .then((isValidLocation) {
                                if (isValidLocation) {
                                  print("value" + value.toString());
                                  _controller.animateCamera(
                                      CameraUpdate.newCameraPosition(CameraPosition(
                                        target: LatLng(value.latitude, value.longitude),
                                        zoom: 16.0,
//                                    bearing: 45.0,
//                                    tilt: 45.0
                                      )));
                                } else {
                                  print("invalid return");
                                }
                              });
                              print(value.latitude);
                              print(value.longitude);
                            }),
                            position: LatLng(
                                _locationData.latitude, _locationData.longitude),
                          ));
                        });
                        print(_allMarkers);
                        _controller.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                              target:
                              LatLng(_locationData.latitude, _locationData.longitude),
                              zoom: 17.0,
//                                    bearing: 45.0,
//                                    tilt: 45.0
                            )));

                        afterDragNewLat=null;
                        afterDrafNewLong=null;
                        },
                    ),
                  )
                ],
              ),
            ),
        viewModelBuilder: () => MapViewModel());
  }

  void getCurrentLocation() async {
    var location = await Location().getLocation();
    var distance = await getDistanceFromLatLonInKm(
        30.8950813, 75.9081479, 30.9081994, 75.8907956841681);
    print("location" + distance.toString());
  }

  String getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in km
    return double.parse((d).toStringAsFixed(1)).toString();
  }

  deg2rad(deg) {
    return deg * (pi / 180);
  }
}
