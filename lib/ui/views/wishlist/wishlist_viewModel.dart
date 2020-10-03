import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/models/product.dart';
import 'package:store/services/wishlist_service.dart';

class WishListViewModel extends BaseViewModel {
  static WishListService _wishListService = locator<WishListService>();
  NavigationService _navigationService = locator<NavigationService>();

  List<Product> _wishListItemsList = _wishListService.wishListItemsList;
  get wishListItemsList => _wishListItemsList;

  initialiseWishlist() async{
    print("init wishlist");
    await _wishListService.fetchWishListItems();
    notifyListeners();
  }

  void navigateToProductDetailsView({productDetails}) async{
    await _navigationService.navigateTo(Routes.productDetailsView,
        arguments: ProductDetailsViewArguments(productDetails: productDetails));
  }

}
