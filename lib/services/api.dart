//import 'package:store/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/models/address.dart';
import 'package:store/models/cartItem.dart';
import 'package:store/models/user.dart';

import 'local_storage_service.dart';
@singleton
class ApiService{


//  static const userendpoint = 'http://10.0.2.2:2003';
//  static const endpoint = 'http://10.0.2.2:2004';
//  static const addressendpoint = 'http://10.0.2.2:2005';
//  static const cartendpoint = 'http://10.0.2.2:2007';
//  static const invoiceendpoint = 'http://10.0.2.2:2008';
//  static const wishlistendpoint = 'http://10.0.2.2:2011';

    static const userendpoint = "http://c315570e5fb3.ngrok.io";
    static const endpoint = 'http://e6de52a30a72.ngrok.io';
    static const addressendpoint = 'http://fab6b8fac0b7.ngrok.io';
    static const cartendpoint = 'http://5e63297f11c4.ngrok.io';
    static const invoiceEndpoint = "http://0caeb56ab4be.ngrok.io";
    static const wishlistendpoint = 'http://3635cad79c41.ngrok.io';

//  static const addressendpoint = 'http://localhost:2005';
//  static const userendpoint = 'http://localhost:2003';
//  static const endpoint = 'http://localhost:2004';
//  static const cartendpoint = 'http://localhost:2007';
//  static const wishlistendpoint = 'http://localhost:2009';

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

  Future<bool> checkIfUserAlreadyExists({@required firebaseId, @required deviceToken}) async{
    Response response = await Dio().get('$userendpoint/api/user',
        queryParameters: {"firebaseId": firebaseId,"deviceToken": deviceToken},);

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

  Future<User> createUser({@required firebaseId, @required deviceToken}) async{
    Response response = await Dio().post('$userendpoint/api/user',
      data: {"firebaseId": firebaseId,"deviceToken": deviceToken},);

    Map responseBody = response.data;
    print("createUser api calling" + responseBody.toString());
//      return Future.delayed(Duration(seconds: 2)).then((e){
//        return responseBody["result"];
//      });

    return User.fromJson(responseBody["result"]);
  }

  Future<User> fetchUser({@required firebaseId, @required deviceToken}) async{

    Response response = await Dio().get('$userendpoint/api/user',
        queryParameters: {
          "firebaseId" : firebaseId,
          "deviceToken": deviceToken
        }
        );

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

  Future<List<Address>> fetchAllAddresses() async{
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.get('$addressendpoint/api/address');
      Map responseBody = response.data;
      var address_array_response_object = responseBody["result"];

      // converting list of response objects to model objects respectively
      List<Address> addressObjectArray = (address_array_response_object as List)
          .map((data) => new Address.fromJson(data))
          .toList();
      return Future.delayed(Duration(seconds: 3)).then((
          value) => addressObjectArray);
    });
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


  Future<ApiResponse> fetchDefaultAddressId() async{
    BaseOptions options = new BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 10*1000, // 60 seconds
        receiveTimeout: 10*1000 // 60 seconds
    );
    Dio dio = new Dio(options);
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.get(
          '$userendpoint/api/user/defaultAddress');
      print("default address api" + ApiResponse(response).result.toString());
      return ApiResponse(response);
    });
  }

  Future<ApiResponse> updateAddressDetails({@required addressId, @required updatedFields}) async{
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.toString();
      Response response = await dio.put('$addressendpoint/api/address/$addressId',data: updatedFields);
      print("updateAddressDetails  api" + ApiResponse(response).result.toString());
      return ApiResponse(response);
      });
  }

  Future<ApiResponse> addToCart(CartItem cartItem) async{
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.put('$cartendpoint/api/cart/addItem',data: cartItem);
      print("addToCart  api" + ApiResponse(response).toString());
      return Future.delayed(Duration(seconds: 0)).then((value) => ApiResponse(response));
//   return ApiResponse(response);
    });
  }

  Future<ApiResponse> addToWishlist(String productId) async{
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.put('$wishlistendpoint/api/wishlist/addItem',data: {'productId': productId} );
      print("addToWishlist  api" + ApiResponse(response).toString());
      return Future.delayed(Duration(seconds: 0)).then((value) => ApiResponse(response));
//   return ApiResponse(response);
    });
  }

  Future<ApiResponse> removeItemfromCart(CartItem cartItem) async{
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.delete('$cartendpoint/api/cart/removeItem',data: cartItem);
      print("removeItemfromCart  api : " + ApiResponse(response).toString());
      return Future.delayed(Duration(seconds: 0)).then((value) => ApiResponse(response));
//   return ApiResponse(response);
    });
  }

  Future<ApiResponse> removeItemFromWishlist(CartItem cartItem) async{
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.delete('$wishlistendpoint/api/wishlist/removeItem',data: cartItem);
      print("removeItemfromCart  api : " + ApiResponse(response).toString());
      return Future.delayed(Duration(seconds: 0)).then((value) => ApiResponse(response));
    });
  }


  Future<ApiResponse> fetchProducts({@required tagsArray,sortBy,sortOrder, page=1,limit=10}) async{
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.get('$endpoint/api/product/getByTag',queryParameters: {"tags" :tagsArray,"sortBy":sortBy,"sortOrder": sortOrder, "page": page, 'limit':limit});
      print("updateAddressDetails  api" + ApiResponse(response).result.toString());
      return Future.delayed(Duration(seconds: 2)).then((value) => ApiResponse(response));
    });


  }

  Future<ApiResponse> fetchUserCart() async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.get('$userendpoint/api/user/cart/cartItems');
      return ApiResponse(response);
    });

  }

  Future<ApiResponse> fetchUserWishlist() async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.get('$userendpoint/api/user/wishlist/wishlistItems');

      return ApiResponse(response);
    });

  }
  Future<ApiResponse> logout() async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.put('$userendpoint/api/user/logout');

      return ApiResponse(response);
    });

  }

  Future<ApiResponse>  createOrder({@required orderDetails}) async{
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.put('$invoiceEndpoint/api/invoice',data: orderDetails );

      return ApiResponse(response);
    });

  }











//  Future createUser(Info) async {
//    print(json.encode(userInfo.toJson()));
//    var response = await client.post('$endpoint/api/user/create',headers: {
//      'Content-Type': 'application/json',
//      'User-Agent': 'Dart'
//    },body: json.encode(userInfo.toJson()));
//    return json.decode(response.body);
//  }

}