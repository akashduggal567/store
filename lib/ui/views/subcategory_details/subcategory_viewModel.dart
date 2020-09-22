import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/models/category.dart';
import 'package:store/models/subcategory.dart';
import 'package:store/services/api.dart';

class SubCategoryViewModel extends BaseViewModel {
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();

  List _subCategories = [];
  get subCategories => _subCategories;

  void fetchSubcategories(categoryName) async{
//    _subCategories = await  _apiService.fetchSubCategories(categoryName);
    notifyListeners();
  }

  initialiseCategory(Category category) async{
    print(category.toJson());
    setBusy(true);
//    _subCategories = await  _apiService.fetchSubCategories(category.name);
    ApiResponse response = await  _apiService.fetchSubCategories(category.name);
    if(response.status == 'success'){
      _subCategories = await response.result.map((e) => SubCategory.fromJson(e)).toList();
    }
    print(subCategories);
    setBusy(false);
    notifyListeners();
  }

  void navigateToProductListView(tagsArray) async{
   await _navigationService.navigateTo(Routes.productsListViewRoute,arguments: ProductsListViewArguments(tagsArray: tagsArray) );
  }

}
