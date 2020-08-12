import 'package:observable_ish/list/list.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/models/product.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/services/wishlist_service.dart';

class CartViewModel extends BaseViewModel {
  static CartService _cartService = locator<CartService>();
  WishListService _wishListService = locator<WishListService>();
  NavigationService _navigationService = locator<NavigationService>();

  List<Product> _cartItems = _cartService.cartItemsList;
  get cartItemsList => _cartItems;

  double _totalCartAmount = _cartService.totalAmount.value;
  get totalCartAmount => _totalCartAmount;

  double _totalDiscountAmount = _cartService.totalDiscountAmount.value;
  get totalDiscountAmount => _totalDiscountAmount;

  double _totalAmountPayable = _cartService.totalAmountPayable.value;
  get totalAmountPayable => _totalAmountPayable;



  void calcualteBillattributes(){
    _totalCartAmount = _cartService.totalAmount.value;
    _totalDiscountAmount = _cartService.totalDiscountAmount.value;
    _totalAmountPayable = _cartService.totalAmountPayable.value;
    notifyListeners();
  }

  void removeCartItem(index) {
    _cartService.removeCartItem(index);
    calcualteBillattributes();
    notifyListeners();
  }

  void addToWishList(String s){
    _wishListService.addToWishList(s);
  }

  void navigateToDashboard() async{
    await _navigationService.replaceWith(Routes.dashboardViewRoute);
  }

  void navigateToBuyOptionsView() async{
    await _navigationService.replaceWith(Routes.buyViewRoute);
  }

}
