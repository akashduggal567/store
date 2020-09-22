import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:store/app/locator.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/services/local_storage_service.dart';

import 'local_notification_service.dart';


Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print(notification);
  }

  // Or do other work.
}

@lazySingleton
class PushNotificationService{
  final FirebaseMessaging _fcm = FirebaseMessaging();
  LocalNotificationService _localNotificationService = locator<LocalNotificationService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  Future initialise() async{
    if(Platform.isIOS){
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _fcm.getToken().then((token){
      print("FireBAse token  " + token.toString());
//      LocalStorageService.getInstance().then((value){
//        if(_localStorageService.deviceToken!=null){
//          print("DEVICE TOKEN" + _localStorageService.deviceToken.toString());
//        }else{
//          _localStorageService.saveStringToDisk(Constants.DEVICE_TOKEN, token);
//        }
//      });


    });
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _localNotificationService.showNotification();
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
//      onBackgroundMessage: myBackgroundMessageHandler,
    );
  }

}