import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocalNotificationService{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  LocalNotificationService(){
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings("@mipmap/ic_launcher");
    var ios = IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async{
    print("selected local notificaton");
  }

  showNotification({@required notification, data}) async {

    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High,importance: Importance.Max,
        styleInformation: BigTextStyleInformation('')
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, notification.title, notification.body, platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');

  }
}