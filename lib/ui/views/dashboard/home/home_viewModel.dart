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

  Future<List> _categories;
  get categories => _categories;

  void navigateToProductsListView() async{
    await _navigationService.replaceWith(Routes.productsListViewRoute);
  }

  Future<List> getCategories() async{
    return await _apiService.fetchCategories();
  }

  @override
  Future futureToRun() async{
    // TODO: implement futureToRun
   _categories =  _apiService.fetchCategories();
    return await _apiService.fetchCategories();
  }

}
