import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/data/products_parser.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/models/product.dart';
import 'package:store/services/api.dart';
import 'package:store/services/cart_service.dart';

class ProductsListViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  ApiService _apiService = locator<ApiService>();
  CartService _cartService = locator<CartService>();

  List<Product> _productsList = [];
  get productsList => _productsList;

  Future fetchProducts(tagsArray) async {
    setBusy(true);

//    Future.delayed(Duration(seconds: 3)).then((value){
//      loadDummyProducts().then((value){
//        print("value" + value["products"][0]["brand"].toString());
//        _productsList = value["products"].map<Product>((productJson){
//          return Product.fromJson(productJson);
//        }).toList();
//
//        setBusy(false);
//        notifyListeners();
//      });
//
//
//    }
  ApiResponse response = await _apiService.fetchProducts(tagsArray);
  if(response.status == "success"){
    var s = response.result.map((e) => Product.fromJson(e)).toList();
    print(s);
    _productsList = s;
    setBusy(false);
  }

  }

  void navigateToProductDetailsView({@required productDetails}) async{
    await _navigationService.navigateTo(Routes.productDetailsView,arguments: ProductDetailsViewArguments(productDetails: productDetails));
  }

  void addItemToCart(Product product) {
//      print('addtocart' + product.toJson().toString());
    _cartService.addToCart(product);
  }

  void navigateToDashboard() async{
    await _navigationService.replaceWith(Routes.dashboardViewRoute);
  }

}
