import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/data/products_parser.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/helpers/constants.dart';
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

  String _sortBy;
  String _sortOrder;

  Future fetchProducts(tagsArray, sortBy,sortOrder) async {
    setBusy(true);
    ApiResponse response;
    _tagsArray = tagsArray;
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
    if(sortBy==null){
      response = await _apiService.fetchProducts(tagsArray: tagsArray,page: 1,limit: 10);
    }else{
      response = await _apiService.fetchProducts(tagsArray: tagsArray,sortBy: sortBy, sortOrder: sortOrder, page: 1,limit: 10);
    }
    if(response.status == "success"){
      var s = response.result[0]['docs'].map((e) => Product.fromJson(e)).toList().cast<Product>();

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
    print("PageToRequest" + pageToRequest.toString());
    print("Condition");
    print("Current Page before" + _currentPage.toString());
    print(requestMoreData && pageToRequest > _currentPage);
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
    ApiResponse response = await _apiService.fetchProducts(tagsArray: tagsArray,sortBy: _sortBy,sortOrder: _sortOrder, page: _currentPage+1, limit: ItemRequestThreshold);
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

  void openSortBottomSheet() async{
    await Get.bottomSheet(Container(
      height: 160,
      color: Constants.darkBlackColor,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getSortChildren()),
    ));
  }

  getSortChildren() {
    List<Widget> children = [Container(child: Text("Sort By"),)];
    Constants.SORT_OPTIONS.forEach((sortOption) {
      children.add(Expanded(
          child: Container(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){
                  print(sortOption['value']);
                  _productsList = [];  notifyListeners();
                  _sortBy = sortOption['sortBy'];
                  _sortOrder = sortOption['sortOrder'];
                  _currentPage = 0;
                  fetchProducts(_tagsArray, _sortBy,_sortOrder);
//              _apiService.fetchProducts(tagsArray:_tagsArray, sortBy: sortOption['sortBy'], sortOrder:sortOption['sortOrder'] );
                  Get.back();
                  notifyListeners();
                },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 8),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(sortOption['title'], style: TextStyle(color: Constants.offWhiteColor),),
        ),
      )),
            ),
          )));
    });

    return children;
  }
}
