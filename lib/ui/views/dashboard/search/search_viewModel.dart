import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/models/product.dart';
import 'package:store/services/api.dart';
import 'package:store/services/cart_service.dart';

class SearchViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  ApiService _apiService = locator<ApiService>();
  static CartService _cartService = locator<CartService>();
//
  String _cartCount = _cartService.totalItemCount.value.toString();
  get cartCount => _cartCount;
//
  bool _isLoadingMore = false;
  get isLoadingMore => _isLoadingMore;

  int _totalProducts = 0;
  get totalProducts => _totalProducts;

  static const int ItemRequestThreshold = 3;
  get limit => ItemRequestThreshold;
  int _currentPage = 0;

  List<Product> _productsList = [];
  get productsList => _productsList;

  List _tagsArray = [];
  get tagsArray => _tagsArray;

  String _sortBy;
  String _sortOrder;


  int _itemBuildIndex = -1;
  get itemBuildIndex => _itemBuildIndex;

  String _searchQuery = "";

  set itemBuildIndex(int itemBuildIndex) {
    _itemBuildIndex = itemBuildIndex;
    notifyListeners();
  }


  Future fetchProducts(query, page, limit) async {
    setBusy(true);
    _currentPage = 0;
    _searchQuery=  query;
    _productsList = [];
    ApiResponse response = await _apiService.searchProduct(
          query: query, page: page, limit: limit);

    if (response.status == "success") {
      var s = response.result[0]['docs']
          .map((e) => Product.fromJson(e))
          .toList()
          .cast<Product>();

      _totalProducts = response.result[0]['totalDocs'];

      Future.delayed(Duration(seconds: 3)).then((value){
        _productsList = s;
        setBusy(false);
      });

    }
  }

  void navigateToProductDetailsView({@required productDetails}) async {
    await _navigationService.navigateTo(Routes.productDetailsView,
        arguments: ProductDetailsViewArguments(productDetails: productDetails));
  }

  void addItemToCart(Product product) {
//      print('addtocart' + product.toJson().toString());
    _cartService.addToCart(product);
    _cartCount = _cartService.totalItemCount.value.toString();
    notifyListeners();
  }

  void navigateToDashboard() async {
    await _navigationService.replaceWith(Routes.dashboardViewRoute);
  }

  void handleItemCreated(int index) {
    var itemPosition = index + 1;
    print(_currentPage);
    var requestMoreData =
        itemPosition % ItemRequestThreshold == 0 && itemPosition != 0;
    var pageToRequest = itemPosition ~/ ItemRequestThreshold;

    if (requestMoreData && pageToRequest > _currentPage) {
      _currentPage = pageToRequest;

      // TODO: Show loading indicator, Request more data and hide loading indicator
      fetchMoreProducts();
    }
  }

  void fetchMoreProducts() async {
//    setBusy(true);
    _isLoadingMore = true;
    notifyListeners();
    ApiResponse response = await _apiService.searchProduct(
        query: _searchQuery,
        page: _currentPage + 1,
        limit: ItemRequestThreshold);
    if (response.status == "success") {
      List<Product> s = response.result[0]['docs']
          .map((e) => Product.fromJson(e))
          .toList()
          .cast<Product>();

      s.forEach((element) {
        _productsList.add(element);
      });
      _isLoadingMore = false;
      notifyListeners();
    }
  }

//  void openSortBottomSheet() async {
//    await Get.bottomSheet(Container(
//      height: 160,
//      color: Constants.darkBlackColor,
//      child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: getSortChildren()),
//    ));
//  }
//
//  getSortChildren() {
//    List<Widget> children = [
//      Container(
//        width: double.infinity,
//        decoration: BoxDecoration(
//            border: Border(
//              top:  BorderSide(width: 0.1, color: Colors.white),
////            left:  BorderSide(width: 0.3, color: Colors.white),
////            right:  BorderSide(width: 0.3, color: Colors.white),
//              bottom: BorderSide(width: 0.04, color: Colors.white),
//            )
//        ),
////        margin: EdgeInsets.only(left: 4),
//        child: Padding(
//          padding: const EdgeInsets.all(4.0),
//          child: Center(child: Text("Sort By", style: TextStyle(color: Constants.offWhiteColor.withOpacity(0.8),fontSize: 18.0),)),
//        ),
//      )
//    ];
//    Constants.SORT_OPTIONS.forEach((sortOption) {
//      children.add(Expanded(
//          child: Container(
//            child: Material(
//              color: Colors.transparent,
//              child: InkWell(
//                  onTap: () {
//                    print(sortOption['value']);
//                    _productsList = [];
//                    notifyListeners();
//                    _sortBy = sortOption['sortBy'];
//                    _sortOrder = sortOption['sortOrder'];
//                    _currentPage = 0;
//                    fetchProducts(_tagsArray, _sortBy, _sortOrder);
////              _apiService.fetchProducts(tagsArray:_tagsArray, sortBy: sortOption['sortBy'], sortOrder:sortOption['sortOrder'] );
//                    Get.back();
//                    notifyListeners();
//                  },
//                  child: Container(
//                    width: double.infinity,
////                margin: EdgeInsets.only(left: 8),
//                    decoration: BoxDecoration(
//                      border: Border(
////                      top:  BorderSide(width: 0.1, color: Colors.white),
////            left:  BorderSide(width: 0.3, color: Colors.white),
////            right:  BorderSide(width: 0.3, color: Colors.white),
//                        bottom: BorderSide(width: 0.04, color: Colors.white),
//                      ),),
//                    child: Container(
//                      height: double.infinity,
////                  color: Colors.red,
//                      child: Padding(
//                        padding: const EdgeInsets.all(10.0),
//                        child: Text(
//                          sortOption['title'],
//                          style: TextStyle(color: Constants.offWhiteColor),
//                        ),
//                      ),
//                    ),
//                  )),
//            ),
//          )));
//    });
//
//    return children;
//  }









}
