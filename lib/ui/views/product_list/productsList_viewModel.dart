import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/services/cart_service.dart';

class ProductsListViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  CartService _cartService = locator<CartService>();

  void navigateToProductDetailsView() async{
    await _navigationService.navigateTo(Routes.productDetailsView);
  }

  void addItemToCart(String s) {
    _cartService.addToCart(s);
  }

}
