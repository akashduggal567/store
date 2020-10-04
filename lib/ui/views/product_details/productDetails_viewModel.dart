import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/models/product.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/ui/views/product_details/image_view.dart';

class ProductDetailsViewModel extends BaseViewModel {
  static CartService _cartService = locator<CartService>();
  NavigationService _navigationService = locator<NavigationService>();
  String _cartCount = "";
  get cartCount => _cartCount;


  String getCartCount(){
    _cartCount = _cartService.cartItemsList.length.toString();
    print("cart Count on dashboard "+ _cartCount);
    notifyListeners();
//    return _cartService.cartItemsList.length.toString();
  }

  void addItemToCart(Product product) {
    _cartService.addToCart(product);
    _cartCount = _cartService.cartItemsList.length.toString();
    notifyListeners();
  }

  void navigateToCart() async{
    await _navigationService.navigateTo(Routes.cartViewRoute);
  }

  void navigateToFullScreenImageView({@required url, @required heroId}) async{
    await _navigationService.navigateWithTransition(ImageView(url: url,HEROID: heroId,), transition: "scale",duration: Duration(milliseconds: 500));
  }
}
