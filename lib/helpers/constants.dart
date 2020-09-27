import 'package:flutter/material.dart';

class Constants{
 static const Color darkBlackColor = Color(0xff222831);
 static const Color lightBlackColor = Color(0xff393E46);
 static const Color tealColor = Color(0xff00ADB5);
 static const Color offWhiteColor = Color(0xffEEEEEE);
 static const Color lightTealColor =Color(0xff8DD4D6);
 static const Color lightDarkTealColor =Color(0xff8AFBFF);

 static const String DEVICE_TOKEN='device-token';
 static const List<Map> SORT_OPTIONS = [
  {'title': 'Price - High to Low', "sortBy": "sale_price", "sortOrder": 'DESC'},
  {'title': 'Price - Low to High',  "sortBy": "sale_price", "sortOrder": 'ASC'},
  {'title': 'Discount', "sortBy": "discount", "sortOrder": 'DESC'},
 ];

}