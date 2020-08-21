import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/services/api.dart';

@singleton
class HomeViewModel extends FutureViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  ApiService _apiService = locator<ApiService>();

  List _categories = [];
  get categories => _categories;

  void navigateToProductsListView() async{
    await _navigationService.replaceWith(Routes.productsListViewRoute);
  }

  Future<List> getCategories() async{
    print("get categories");
    return await _apiService.fetchCategories();
  }

  Future refreshCategories() async{
    setBusy(true);
    _categories = [];
    notifyListeners();
    print("Categores" + _categories.toString());
    _categories = await _apiService.fetchCategories();
    print("Categores" + _categories.toString());
    setBusy(false);
    notifyListeners();
    return _categories;
  }

  @override
  Future futureToRun() async{
    // TODO: implement futureToRun
   _categories = await _apiService.fetchCategories();
  }

  refreshHandler() {
    print("refreshing content");
  }

  void navigateToSubCategory(categoryTitle) async{
    await _navigationService.navigateTo(Routes.subCategoryView,
        arguments: SubCategoryViewArguments(categoryTitle: categoryTitle ));
  }

}
