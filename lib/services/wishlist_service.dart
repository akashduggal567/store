import 'package:injectable/injectable.dart';
import 'package:observable_ish/list/list.dart';
import 'package:stacked/stacked.dart';
import 'package:store/app/locator.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/models/detailed_cart_item.dart';
import 'package:store/models/product.dart';
import 'package:store/services/api.dart';
import 'package:store/services/cart_service.dart';

@lazySingleton
class WishListService with ReactiveServiceMixin {

  CartService _cartService = locator<CartService>();

  WishListService() {
    listenToReactiveValues([_wishListItemsList]);
  }

  final _wishListItemsList = RxList<Product>();
  get wishListItemsList => _wishListItemsList;

  ApiService _apiService = locator<ApiService>();

  Future addToWishList(String productId, index) async {
    var isAlreadyPresent = wishListItemsList
                .where((object) => object.toJson()["_id"] == productId)
                .length > 0
        ? true
        : false;

    if (!isAlreadyPresent) {
      ApiResponse response = await _apiService.addToWishlist(productId);
      if (response.status == "success") {
        _wishListItemsList.clear();
        await _cartService.removeCartItem(index, Product(id: productId));
        ApiResponse response = await _apiService.fetchUserWishlist();
        if (response.status == "success") {
          var wishlistItems =
              response.result.map((e) => Product.fromJson(e)).toList();
          wishlistItems.forEach((item) {
            wishListItemsList.add(item);
            notifyListeners();
          });
        }
      }
    }
  }

  void fetchWishListItems() async {
    _wishListItemsList.clear();
    ApiResponse response = await _apiService.fetchUserWishlist();
    if (response.status == "success") {
      var wishlistItems =
          response.result.map((e) => Product.fromJson(e)).toList();
      wishlistItems.forEach((item) {
        wishListItemsList.add(item);
      });
      notifyListeners();
      print(wishListItemsList);
    }
  }
}
