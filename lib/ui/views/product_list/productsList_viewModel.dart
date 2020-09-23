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

  bool _isLoadingMore = false;
  get isLoadingMore => _isLoadingMore;

  static const int ItemRequestThreshold = 10;
  int _currentPage = 0;

  List<Product> _productsList = [];
  get productsList => _productsList;

  List _tagsArray = [];
  get tagsArray => _tagsArray;

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
  ApiResponse response = await _apiService.fetchProducts(tagsArray: tagsArray,limit: ItemRequestThreshold);
  if(response.status == "success"){
    var s = response.result[0]['docs'].map((e) => Product.fromJson(e)).toList().cast<Product>();
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

  void handleItemCreated(int index) {
    var itemPosition = index + 1;
    var requestMoreData =
        itemPosition % ItemRequestThreshold == 0 && itemPosition != 0;
    var pageToRequest = itemPosition ~/ ItemRequestThreshold;
    print("REQUEST MORE DATA" + requestMoreData.toString());
    if (requestMoreData && pageToRequest > _currentPage) {
      _currentPage = pageToRequest;
      print("CURRENT PAGE --->" + _currentPage.toString() );

      // TODO: Show loading indicator, Request more data and hide loading indicator
      fetchMoreProducts(_tagsArray);
    }
  }

  updateTagsArray(List tagsArray) {
    _tagsArray = tagsArray;
    notifyListeners();
  }

  void fetchMoreProducts(List tagsArray) async{
//    setBusy(true);
    _isLoadingMore = true;
    notifyListeners();

    ApiResponse response = await _apiService.fetchProducts(tagsArray: tagsArray, page: _currentPage+1, limit: ItemRequestThreshold);
    if(response.status == "success"){
      List<Product> s = response.result[0]['docs'].map((e) => Product.fromJson(e)).toList().cast<Product>();
      print(s);
      s.forEach((element) {
        _productsList.add(element);
      });
      _isLoadingMore = false;
      notifyListeners();

    }

  }

}
