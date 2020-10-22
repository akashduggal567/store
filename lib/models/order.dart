// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.orderNumber,
    this.status,
    this.invoiceUrl,
  });

  int orderNumber;
  String status;
  String invoiceUrl;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderNumber: json["orderNumber"] == null ? null : json["orderNumber"],
    status: json["status"] == null ? null : json["status"],
    invoiceUrl: json["invoiceUrl"] == null ? null : json["invoiceUrl"],
  );

  Map<String, dynamic> toJson() => {
    "orderNumber": orderNumber == null ? null : orderNumber,
    "status": status == null ? null : status,
    "invoiceUrl": invoiceUrl == null ? null : invoiceUrl,
  };
}
