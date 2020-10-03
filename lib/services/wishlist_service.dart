import 'package:injectable/injectable.dart';
import 'package:observable_ish/list/list.dart';
import 'package:stacked/stacked.dart';
import 'package:store/app/locator.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/models/detailed_cart_item.dart';
import 'package:store/models/product.dart';
import 'package:store/services/api.dart';

@lazySingleton
class WishListService with ReactiveServiceMixin{
  WishListService() {
    listenToReactiveValues([_wishListItemsList]);
  }

  final _wishListItemsList = RxList<Product>();
  get wishListItemsList => _wishListItemsList;

  ApiService _apiService = locator<ApiService>();



  void addToWishList(String productId) {
    _apiService.addToWishlist(productId);
//    _wishListItemsList.add("W");
    print("WishList: " + _wishListItemsList.toString());
  }

  void fetchWishListItems() async{
    _wishListItemsList.clear();
    ApiResponse response = await _apiService.fetchUserWishlist();
    if(response.status == "success"){
      var wishlistItems = response.result.map((e) => Product.fromJson(e)).toList();
      wishlistItems.forEach((item) { wishListItemsList.add(item);});
      notifyListeners();
      print(wishListItemsList);
    }

  }
}