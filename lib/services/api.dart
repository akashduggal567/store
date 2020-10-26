import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/setup_snackbar_ui.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/helpers/ApiResponseError.dart';
import 'package:store/models/address.dart';
import 'package:store/models/cartItem.dart';
import 'package:store/models/user.dart';

import 'local_storage_service.dart';

@singleton
class ApiService {
  static const userendpoint = 'http://10.0.2.2:2003';
  static const endpoint = 'http://10.0.2.2:2004';
  static const addressendpoint = 'http://10.0.2.2:2005';
  static const orderendpoint = 'http://10.0.2.2:2006';
  static const cartendpoint = 'http://10.0.2.2:2007';
  static const invoiceEndpoint = 'http://10.0.2.2:2008';
  static const wishlistendpoint = 'http://10.0.2.2:2011';

//  static const userendpoint = "http://0652ef8760d5.ngrok.io";
//  static const endpoint = 'http://c1c25072509a.ngrok.io';
//  static const addressendpoint = 'http://6ad01c2bed80.ngrok.io';
//  static const orderendpoint = 'http://c62f2575fbc8.ngrok.io';
//  static const cartendpoint = 'http://e4123429aed5.ngrok.io';
//  static const invoiceEndpoint = "http://612111b9e8c2.ngrok.io";
//  static const wishlistendpoint = 'http://3635cad79c41.ngrok.io';
//
//  static const userendpoint = 'http://localhost:2003';
//  static const endpoint = 'http://localhost:2004';
//  static const addressendpoint = 'http://localhost:2005';
//  static const orderendpoint = 'http://localhost:2006';
//  static const cartendpoint = 'http://localhost:2007';
//  static const invoiceEndpoint = 'http://localhost:2008';
//  static const wishlistendpoint = 'http://localhost:2009';

  static const BASEURL =
      "http://ec2-3-7-65-217.ap-south-1.compute.amazonaws.com";

  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  Future<LocalStorageService> _localStorageService =
      LocalStorageService.getInstance();

  Dio client;
  ApiService() {
    if (client == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 10 * 1000, // 60 seconds
          receiveTimeout: 60 * 1000 // 60 seconds
          );
      client = Dio(options);
      client.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));

      client.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
        var pref = await _localStorageService;
        options.headers.addAll({"user-id": pref.user.id});
        return options;
      }, onResponse: (Response response) async {
        return response;
      }, onError: (DioError e) async {
        switch (e.type) {
          case DioErrorType.RESPONSE:
            {
              ApiResponseError responseError =
                  ApiResponseError.fromJson(e.response.data);
              _dialogService.showDialog(
                  title: responseError.exception.error.code.toString() +
                      " " +
                      responseError.exception.error.description,
                  description: responseError.exception.error.message);
            }
            break;

          case DioErrorType.CONNECT_TIMEOUT:
            {
              _snackbarService.showCustomSnackBar(
                  variant: SnackbarType.greenAndRed,
                  title: "Connection Timed Out \n" + e.request.path,
                  message:
                      "Sorry, may be due to slow internet connection timed out. Please try again later",
                  duration: Duration(seconds: 8));
            }
            break;
          case DioErrorType.RECEIVE_TIMEOUT:
            {
              _snackbarService.showSnackbar(
                  title: "RECEIVE Timed Out",
                  message:
                      "Sorry, may be due to slow internet RECEIVE timed out. Please try again later",
                  duration: Duration(seconds: 8));
            }
            break;
          case DioErrorType.SEND_TIMEOUT:
            {
              _snackbarService.showSnackbar(
                  title: "SEND Timed Out",
                  message:
                      "Sorry, may be due to slow internet SEND timed out. Please try again later",
                  duration: Duration(seconds: 8));
            }
            break;
          case DioErrorType.DEFAULT:
            {
              //statements;
            }
            break;
          case DioErrorType.CANCEL:
            {
              //statements;
              _snackbarService.showSnackbar(
                  title: "Request to the server was cancelled",
                  message: e.request.path,
                  duration: Duration(seconds: 8));
            }
            break;

          default:
            {
              //statements;
            }
            break;
        }
//        return e; //continue
      }));
    }
  }


  // ***************** START OF PRODUCT ENDPOINTS **************************

  Future<ApiResponse> fetchCategories() async {
    try {
      Response response = await Dio().get('$BASEURL/api/product/category');
      return Future.delayed(Duration(seconds: 0)).then((e) {
        return ApiResponse(response);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<ApiResponse> fetchSubCategories(categoryName) async {
    try {
      Response response = await Dio().get('$BASEURL/api/product/subcategory',
          queryParameters: {"categoryName": categoryName});

      return ApiResponse(response);
    } catch (e) {
      print(e);
    }
  }

  Future<ApiResponse> fetchProducts(
      {@required tagsArray, sortBy, sortOrder, page = 1, limit = 10}) async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response =
      await dio.get('$BASEURL/api/product/getByTag', queryParameters: {
        "tags": tagsArray,
        "sortBy": sortBy,
        "sortOrder": sortOrder,
        "page": page,
        'limit': limit
      });
      print("updateAddressDetails  api" +
          ApiResponse(response).result.toString());
      return Future.delayed(Duration(seconds: 2))
          .then((value) => ApiResponse(response));
    });
  }

  Future<ApiResponse> searchProduct({@required query, page, limit}) {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.get('$BASEURL/api/product/search',
          queryParameters: {
            "querystring": query,
            "page": page,
            "limit": limit
          });
      print("Called searchProduct api");
      return ApiResponse(response);
    });
  }

  // ***************** END OF PRODUCT ENDPOINTS **************************

  // ***************** START OF USER ENDPOINTS **************************

  Future<bool> checkIfUserAlreadyExists(
      {@required firebaseId, @required deviceToken}) async {
    Response response = await Dio().get(
      '$BASEURL/api/user',
      queryParameters: {"firebaseId": firebaseId, "deviceToken": deviceToken},
    );

    Map responseBody = response.data;

    if (responseBody["result"] != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> createUser({@required firebaseId, @required deviceToken}) async {
    Response response = await Dio().post(
      '$BASEURL/api/user',
      data: {"firebaseId": firebaseId, "deviceToken": deviceToken},
    );

    Map responseBody = response.data;

    return User.fromJson(responseBody["result"]);
  }

  Future<User> fetchUser({@required firebaseId, @required deviceToken}) async {
    Response response = await Dio().get('$BASEURL/api/user',
        queryParameters: {
          "firebaseId": firebaseId,
          "deviceToken": deviceToken
        });

    Map responseBody = response.data;
    return User.fromJson(responseBody["result"]);
  }


  Future<ApiResponse> setAddressAsDefault(userId, addressId) async {
    Dio dio = new Dio();
    dio.options.headers["user-id"] = userId.toString();
    Response response = await dio
        .put('$BASEURL/api/user', data: {"defaultAddress": addressId});
    print(ApiResponse(response));
    return ApiResponse(response);
  }

  Future<ApiResponse> fetchDefaultAddressId() async {
    BaseOptions options = new BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 10 * 1000, // 60 seconds
        receiveTimeout: 10 * 1000 // 60 seconds
    );
    Dio dio = new Dio(options);
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response =
      await dio.get('$BASEURL/api/user/defaultAddress');
      print("default address api" + ApiResponse(response).result.toString());
      return ApiResponse(response);
    });
  }

  Future<ApiResponse> fetchUserCart() async {
    return _localStorageService.then((value) async {
      Response response;
      try {
        response = await client.get('$BASEURL/api/user/cart/cartItems');
        return ApiResponse(response);
      } on DioError catch (e) {
        return null;
      }
    });
  }

  Future<ApiResponse> fetchUserWishlist() async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response =
      await dio.get('$BASEURL/api/user/wishlist/wishlistItems');

      return ApiResponse(response);
    });
  }

  Future<ApiResponse> logout() async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.put('$BASEURL/api/user/logout');

      return ApiResponse(response);
    });
  }

  Future<ApiResponse> updateUserDeviceToken(deviceToken) async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio
          .put('$BASEURL/api/user', data: {"deviceToken": deviceToken});

      return ApiResponse(response);
    });
  }

  // ***************** END OF USER ENDPOINTS **************************

  // ***************** START OF ADDRESS ENDPOINTS **************************

  Future<ApiResponse> createNewAddress(address, userId) async {
    Dio dio = new Dio();
    dio.options.headers["user-id"] = userId.toString();
    Response response =
        await dio.post('$BASEURL/api/address', data: address);
    return ApiResponse(response);
  }

  Future<List<Address>> fetchAllAddresses() async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.get('$BASEURL/api/address');
      Map responseBody = response.data;
      var address_array_response_object = responseBody["result"];

      // converting list of response objects to model objects respectively
      List<Address> addressObjectArray = (address_array_response_object as List)
          .map((data) => new Address.fromJson(data))
          .toList();
      return Future.delayed(Duration(seconds: 3))
          .then((value) => addressObjectArray);
    });
  }

  Future<ApiResponse> deleteUserAddress(userId, addressId) async {
    BaseOptions options = new BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 10 * 1000, // 60 seconds
        receiveTimeout: 10 * 1000 // 60 seconds
        );

    Dio dio = new Dio(options);
    try {
      dio.options.headers["user-id"] = userId.toString();
      Response response =
          await dio.delete('$BASEURL/api/address/$addressId');
      return ApiResponse(response);
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.CONNECT_TIMEOUT) {
//        throw Exception("Connection  Timeout Exception");
        _dialogService.showDialog(
            title: "Error",
            buttonTitle: "OK",
            description: "Connection  Timeout Exception");
      }
    }
  }


  Future<ApiResponse> updateAddressDetails(
      {@required addressId, @required updatedFields}) async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.toString();
      Response response = await dio
          .put('$BASEURL/api/address/$addressId', data: updatedFields);
      print("updateAddressDetails  api" +
          ApiResponse(response).result.toString());
      return ApiResponse(response);
    });
  }

  // ***************** END OF ADDRESS ENDPOINTS **************************

  // ***************** START OF CART ENDPOINTS **************************

  Future<ApiResponse> addToCart(CartItem cartItem) async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response =
          await dio.put('$BASEURL/api/cart/addItem', data: cartItem);
      print("addToCart  api" + ApiResponse(response).toString());
      return Future.delayed(Duration(seconds: 0))
          .then((value) => ApiResponse(response));

    });
  }

  Future<ApiResponse> removeItemfromCart(CartItem cartItem) async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response =
      await dio.delete('$BASEURL/api/cart/removeItem', data: cartItem);
      print("removeItemfromCart  api : " + ApiResponse(response).toString());
      return Future.delayed(Duration(seconds: 0))
          .then((value) => ApiResponse(response));

    });
  }

  // ***************** END OF CART ENDPOINTS *******************************
  // ***************** START OF WISHLIST ENDPOINTS **************************


  Future<ApiResponse> addToWishlist(String productId) async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.put(
          '$BASEURL/api/wishlist/addItem',
          data: {'productId': productId});
      print("addToWishlist  api" + ApiResponse(response).toString());
      return Future.delayed(Duration(seconds: 0))
          .then((value) => ApiResponse(response));
//   return ApiResponse(response);
    });
  }


  Future<ApiResponse> removeItemFromWishlist(CartItem cartItem) async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio
          .delete('$BASEURL/api/wishlist/removeItem', data: cartItem);
      print("removeItemfromCart  api : " + ApiResponse(response).toString());
      return Future.delayed(Duration(seconds: 0))
          .then((value) => ApiResponse(response));
    });
  }


  // ***************** END OF WISHLIST ENDPOINTS *******************************
  // ***************** START OF INVOICE ENDPOINTS **************************

  Future<ApiResponse> createOrder({@required orderDetails}) async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response =
          await dio.put('$BASEURL/api/invoice', data: orderDetails);

      return ApiResponse(response);
    });
  }

  // ***************** END OF INVOICE ENDPOINTS **************************
  // ***************** START OF ORDER ENDPOINTS **************************

  Future<ApiResponse> getOrders() async {
    Dio dio = new Dio();
    return _localStorageService.then((value) async {
      dio.options.headers["user-id"] = value.user.id;
      Response response = await dio.get(
        '$BASEURL/api/order',
      );
      print("Called getOrders api");
      return ApiResponse(response);
    });
  }

// ***************** END OF ORDER ENDPOINTS **************************


}
