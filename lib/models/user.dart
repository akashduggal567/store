// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.firebaseId,
    this.mobileNumber,

  });

  String firebaseId;
  String mobileNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
    firebaseId: json["firebase_id"] == null ? null : json["firebase_id"],
    mobileNumber: json["mobileNumber"] == null ? null : json["mobileNumber"],

  );

  Map<String, dynamic> toJson() => {
    "firebase_id": firebaseId == null ? null : firebaseId,
    "mobileNumber": mobileNumber == null ? null : mobileNumber,

  };
}



//{
//"firebase_id" : "1",
//"firstName": "Akash",
//"lastName" : "Duggal",
//"gender" : "Male",
//"dateOfBirth" : "15/04/1998",
//"mobileNumber": "8570897777",
//"location": "Ludhiana",
//"djInterests" : ["dkn"],
//"languageInterests": ["fdk"]
//}