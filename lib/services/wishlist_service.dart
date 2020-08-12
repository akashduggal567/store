import 'package:injectable/injectable.dart';
import 'package:observable_ish/list/list.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class WishListService with ReactiveServiceMixin{
  final _wishListItemsList = RxList<String>();
  get wishListItemsList => _wishListItemsList;

  WishListService() {
    listenToReactiveValues([_wishListItemsList]);
  }


  void addToWishList(String s) {
    _wishListItemsList.add("W");
    print("WishList: " + _wishListItemsList.toString());
  }
}