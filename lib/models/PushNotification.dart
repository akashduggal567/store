// To parse this JSON data, do
//
//     final pushNotification = pushNotificationFromJson(jsonString);

import 'dart:convert';

PushNotification pushNotificationFromJson(String str) => PushNotification.fromJson(json.decode(str));

String pushNotificationToJson(PushNotification data) => json.encode(data.toJson());

class PushNotification {
  PushNotification({
    this.notification,
    this.data,
  });

  Notification notification;
  Data data;

  factory PushNotification.fromJson(Map<String, dynamic> json) => PushNotification(
    notification: json["notification"] == null ? null : Notification.fromJson(json["notification"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "notification": notification == null ? null : notification.toJson(),
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Notification {
  Notification({
    this.title,
    this.body,
  });

  String title;
  String body;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    title: json["title"] == null ? null : json["title"],
    body: json["body"] == null ? null : json["body"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "body": body == null ? null : body,
  };
}
