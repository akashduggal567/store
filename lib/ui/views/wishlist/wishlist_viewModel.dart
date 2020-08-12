import 'package:stacked/stacked.dart';
import 'package:store/app/locator.dart';
import 'package:store/services/wishlist_service.dart';

class WishListViewModel extends BaseViewModel {
  static WishListService _wishListService = locator<WishListService>();

  List<String> _wishListItemsList = _wishListService.wishListItemsList;
  get wishListItemsList => _wishListItemsList;

}
