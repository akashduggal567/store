import 'package:observable_ish/list/list.dart';
import 'package:stacked/stacked.dart';
import 'package:store/app/locator.dart';
import 'package:store/services/cart_service.dart';

class CartViewModel extends BaseViewModel {
  static CartService _cartService = locator<CartService>();

  List<String> _cartItems = _cartService.cartItemsList;
  get cartItemsList => _cartItems;

  void removeCartItem() {
    _cartService.removeCartItem();
    notifyListeners();
  }

  void addToCart(String s) {
    _cartService.addToCart(s);
    notifyListeners();
  }

}
