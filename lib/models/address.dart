// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.id,
    this.latitude,
    this.longitude,
    this.addressType,
    this.fullName,
    this.primaryAddress,
    this.secondaryAddress,
    this.mobileNumber,
    this.landmark,
    this.pincode,
    this.city,
  });

  String id;
  String latitude;
  String longitude;
  String addressType;
  String fullName;
  String primaryAddress;
  String secondaryAddress;
  String mobileNumber;
  String landmark;
  String pincode;
  String city;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["_id"] == null ? null : json["_id"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    addressType: json["addressType"] == null ? null : json["addressType"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    primaryAddress: json["primaryAddress"] == null ? null : json["primaryAddress"],
    secondaryAddress: json["secondaryAddress"] == null ? null : json["secondaryAddress"],
    mobileNumber: json["mobileNumber"] == null ? null : json["mobileNumber"],
    landmark: json["landmark"] == null ? null : json["landmark"],
    pincode: json["pincode"] == null ? null : json["pincode"],
    city: json["city"] == null ? null : json["city"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "addressType": addressType == null ? null : addressType,
    "fullName": fullName == null ? null : fullName,
    "primaryAddress": primaryAddress == null ? null : primaryAddress,
    "secondaryAddress": secondaryAddress == null ? null : secondaryAddress,
    "mobileNumber": mobileNumber == null ? null : mobileNumber,
    "landmark": landmark == null ? null : landmark,
    "pincode": pincode == null ? null : pincode,
    "city": city == null ? null : city,
  };
}

//{
//"_id":"asd"
//"latitude": "4.3833",
//"longitude": "2.4429798",
//"addressType": "fjnkjnf",
//"fullName": "adasdadd",
//"primaryAddress": "dadsa",
//"secondaryAddress": "12323",
//"mobileNumber": "9498397984",
//"landmark": "dasdas"
//"pincode": "34234",
//"city": "12323"
//}