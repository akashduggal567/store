import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class CartService with ReactiveServiceMixin{
  final _cartItems = RxList<String>();
  get cartItemsList => _cartItems;



  CartService() {
    //3
    listenToReactiveValues([_cartItems]);
  }
  void removeCartItem() {
    _cartItems.removeLast();
    print("Cart List: " + _cartItems.toString());
  }

  void addToCart(String s) {
    _cartItems.add("S");
    print("Cart List: " + _cartItems.toString());
  }

}