//import 'package:store/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/models/address.dart';
import 'package:store/models/cartItem.dart';
import 'package:store/models/user.dart';

import 'local_storage_service.dart';
@singleton
class ApiService{

  static const addressendpoint = 'http://10.0.2.2:2005';
  static const userendpoint = 'http://10.0.2.2:2003';
  static const endpoint = 'http://10.0.2.2:2004';
  static const cartendpoint = 'http://10.0.2.2:2007';
  
//  static const addressendpoint = 'http://localhost:2005';
//  static const userendpoint = 'http://localhost:2003';
//  static const endpoint = 'http://localhost:2004';
//  static const cartendpoint = 'http://localhost:2007';

  DialogService _dialogService = locator<DialogService>();
  Future<LocalStorageService> _localStorageService = LocalStorageService.getInstance();


  Future<ApiResponse> fetchCategories() async{
    try {
      Response response = await Dio().get('$endpoint/api/product/category');
      Map responseBody = response.data;
      print("api calling");
      return Future.delayed(Duration(seconds: 0)).then((e){

        return ApiResponse(response);
      });

    } catch (e) {
      print(e);
    }
  }

  Future<ApiResponse> fetchSubCategories(categoryName) async{
    try {
      Response response = await Dio().get('$endpoint/api/product/subcategory',
          queryParameters: {"categoryName": categoryName});

      Map responseBody = response.data;
      print("fetchSubCategories api calling" + responseBody.toString());
//      return Future.delayed(Duration(seconds: 2)).then((e){
//        return responseBody["result"];
//      });
      return ApiResponse(response);

    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkIfUserAlreadyExists({@required firebaseId}) async{
    Response response = await Dio().get('$userendpoint/api/user/$firebaseId',
        queryParameters: {"firebaseId": firebaseId},);

    Map responseBody = response.data;
    print("checkIfUserAlreadyExists api calling" + responseBody.toString());
    if(responseBody["result"]!=null){
      return true;
    }
    else{
      return false;
    }
//      return Future.delayed(Duration(seconds: 2)).then((e){
//        return responseBody["result"];
//      });

  }

  Future<User> createUser({@required firebaseId}) async{
    Response response = await Dio().post('$userendpoint/api/user',
      data: {"firebaseId": firebaseId},);

    Map responseBody = response.data;
    print("createUser api calling" + responseBody.toString());
//      return Future.delayed(Duration(seconds: 2)).then((e){
//        return responseBody["result"];
//      });

    return User.fromJson(responseBody["result"]);
  }

  Future<User> fetchUser({@required firebaseId}) async{

    Response response = await Dio().get('$userendpoint/api/user/$firebaseId');

    Map responseBody = response.data;
    print("fetchUser api calling" + responseBody.toString());
//      return Future.delayed(Duration(seconds: 2)).then((e){
//        return responseBody["result"];
//      });

    return User.fromJson(responseBody["result"]);
  }

  Future<ApiResponse> createNewAddress(address, userId) async{
    Dio dio = new Dio();
    dio.options.headers["user-id"] = userId.toString();
    Response response = await dio.post('$addressendpoint/api/address',data: address);
    return ApiResponse(response);
  }

  Future<List<Address>> fetchAllAddresses(userId) async{
    Dio dio = new Dio();
    dio.options.headers["user-id"] = userId.toString();
    Response response = await dio.get('$addressendpoint/api/address');
    Map responseBody = response.data;
    var address_array_response_object = responseBody["result"];

    // converting list of response objects to model objects respectively
    List<Address> addressObjectArray =    (address_array_response_object as List)
        .map((data) => new Address.fromJson(data))
        .toList();
    return Future.delayed(Duration(seconds: 3)).then((value) => addressObjectArray);
   return addressObjectArray;

//    return
  }

  Future<ApiResponse> setAddressAsDefault(userId,addressId) async{
    Dio dio = new Dio();
    dio.options.headers["user-id"] = userId.toString();
    Response response = await dio.put('$userendpoint/api/user',data: {"defaultAddress": addressId});
    print(ApiResponse(response));
    return ApiResponse(response);
  }

  Future<ApiResponse> deleteUserAddress(userId, addressId) async{
    BaseOptions options = new BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 10*1000, // 60 seconds
        receiveTimeout: 10*1000 // 60 seconds
    );

    Dio dio = new Dio(options);
    try{
    dio.options.headers["user-id"] = userId.toString();
    Response response = await dio.delete('$addressendpoint/api/address/$addressId');
    return ApiResponse(response);
    }on DioError catch(ex){
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
//        throw Exception("Connection  Timeout Exception");
        _dialogService.showDialog(title: "Error",buttonTitle: "OK",description: "Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    }
  }


  Future<ApiResponse> fetchDefaultAddressId(userId) async{
    BaseOptions options = new BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 10*1000, // 60 seconds
        receiveTimeout: 10*1000 // 60 seconds
    );
    Dio dio = new Dio(options);
    dio.options.headers["user-id"] = userId.toString();
    Response response = await dio.get('$userendpoint/api/user/$userId/defaultAddress');
    print("default address api" + ApiResponse(response).result.toString());
    return ApiResponse(response);
  }

  Future<ApiResponse> updateAddressDetails({@required addressId, @required updatedFields}) async{
    Dio dio = new Dio();
    dio.options.headers["user-id"] = "5f4b98d0e4e31f2514c045c8";
    Response response = await dio.put('$addressendpoint/api/address/$addressId',data: updatedFields);
    print("updateAddressDetails  api" + ApiResponse(response).result.toString());
    return ApiResponse(response);
  }
  Future<ApiResponse> addToCart(CartItem cartItem) async{
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.put('$cartendpoint/api/cart/addItem',data: cartItem);
      print("addToCart  api" + ApiResponse(response).toString());
      return Future.delayed(Duration(seconds: 5)).then((value) => ApiResponse(response));
//   return ApiResponse(response);
    });


  }

  Future<ApiResponse> fetchProducts({@required tagsArray,sortBy,sortOrder, page=1,limit=10}) async{
    Dio dio = new Dio();
//    dio.options.headers["user-id"] = "5f4b98d0e4e31f2514c045c8";
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.get('$endpoint/api/product/getByTag',queryParameters: {"tags" :tagsArray,"sortBy":sortBy,"sortOrder": sortOrder, "page": page, 'limit':limit});
      print("updateAddressDetails  api" + ApiResponse(response).result.toString());
      return ApiResponse(response);
    });


  }

  Future<ApiResponse> fetchUserCart() async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.get('$userendpoint/api/user/cart/cartItems');
      print("fetchUserCart  api" );

      return ApiResponse(response);
    });

  }



//  Future createUser(User userInfo) async {
//    print(json.encode(userInfo.toJson()));
//    var response = await client.post('$endpoint/api/user/create',headers: {
//      'Content-Type': 'application/json',
//      'User-Agent': 'Dart'
//    },body: json.encode(userInfo.toJson()));
//    return json.decode(response.body);
//  }

}