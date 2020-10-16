import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/services/api.dart';
import 'package:store/services/local_storage_service.dart';

class BuyViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  ApiService _apiService = locator<ApiService>();
  DialogService _dialogService = locator<DialogService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  void codPayment(
      {@required orderDetails,
      @required totalAmount,
      @required paymentMode}) async {

    Map<String, dynamic> invoiceObject = {
      ...orderDetails,
      "totalAmount": totalAmount,
      "paymentMode": paymentMode
    };

    await _apiService.createOrder(orderDetails: invoiceObject);
  }
}
