import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/models/category.dart';
import 'package:store/models/subcategory.dart';
import 'package:store/services/api.dart';
import 'package:store/ui/views/dashboard/dashboard_view.dart';

import '../product_list/productsList_view.dart';

class SubCategoryViewModel extends BaseViewModel {
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();

  List _subCategories = [];
  get subCategories => _subCategories;

  List _subChildCategories = [];
  get subChildCategories => _subChildCategories;


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
      _subChildCategories = _subCategories.where((element) => checkSubChildcategory(element) ? true: false).toList();
      List _subChildCategoriesIds = _subChildCategories.map((e) => e.id).toList();
      _subChildCategoriesIds.forEach((id) {
        _subCategories.removeWhere((element) => element.id == id);
      });
    }

    setBusy(false);
    notifyListeners();
  }

  void navigateToProductListView(tagsArray, categoryName, subchildCategoryName) async{
   await _navigationService.navigateWithTransition(ProductsListView(tagsArray:tagsArray,mainCategoryName:categoryName,childCategoryName:subchildCategoryName),transition: 'rightToLeft' );
  }

  bool checkSubChildcategory(SubCategory element) {
    List ids = _subCategories.map((e) => e.id).toList();
    bool flag = false;
    element.parentCategoryIds.forEach((tagId) {
      if(ids.contains(tagId)){
        flag =  true;
      }
    });
    return flag;
  }

  void navigateToDashboard() async{
    await _navigationService.replaceWithTransition(DashboardView(), transition: 'leftToRight');
  }

}
