// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.firebaseId,
    this.mobileNumber,
  });

  String id;
  String firebaseId;
  String mobileNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] == null ? null : json["_id"],
    firebaseId: json["firebaseId"] == null ? null : json["firebaseId"],
    mobileNumber: json["mobileNumber"] == null ? null : json["mobileNumber"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "firebaseId": firebaseId == null ? null : firebaseId,
    "mobileNumber": mobileNumber == null ? null : mobileNumber,
  };
}

//{
//"_id": "adasdadd",
//"firebaseId": "dadsa",
//"mobileNumber": "12323"
//}