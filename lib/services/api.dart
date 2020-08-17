//import 'package:store/models/user.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
@lazySingleton
class ApiService{

  static const endpoint = 'http://10.0.2.2:2004';

  var client = new http.Client();

  Future<List> fetchCategories() async{
    try {
      Response response = await Dio().get('$endpoint/api/product/category');
      Map responseBody = response.data;
      print(responseBody["result"]);
      return Future.delayed(Duration(seconds: 5)).then((e){
        return responseBody["result"];
      });

    } catch (e) {
      print(e);
    }
  }
//
//  Future createUser(User userInfo) async {
//    print(json.encode(userInfo.toJson()));
//    var response = await client.post('$endpoint/api/user/create',headers: {
//      'Content-Type': 'application/json',
//      'User-Agent': 'Dart'
//    },body: json.encode(userInfo.toJson()));
//    return json.decode(response.body);
//  }

}