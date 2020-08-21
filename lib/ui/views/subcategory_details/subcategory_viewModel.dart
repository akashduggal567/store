import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:store/app/locator.dart';
import 'package:store/services/api.dart';

class SubCategoryViewModel extends BaseViewModel {
  ApiService _apiService = locator<ApiService>();
  List _subCategories = [];
  get subCategories => _subCategories;

  void fetchSubcategories(categoryName) async{
    _subCategories = await  _apiService.fetchSubCategories(categoryName);
    notifyListeners();
  }

  initialiseCategory(categoryName) async{
    setBusy(true);
    _subCategories = await  _apiService.fetchSubCategories(categoryName);
    print(subCategories);
    setBusy(false);
    notifyListeners();
  }

}
