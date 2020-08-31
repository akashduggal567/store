import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/models/address.dart';
import 'package:store/services/api.dart';

class EditAddressViewModel extends BaseViewModel {
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();

  void compareAndUpdate(
      {@required Address prevAddressDetails,
      @required Address newAddressDetails}) async{

    Map<String,dynamic> prevAdd = prevAddressDetails.toJson();

    prevAdd.remove("_id");
    prevAdd.remove("latitude");
    prevAdd.remove("longitude");
    // This will remove the fields

    Map<String,String> differentFields = {};

    prevAdd.forEach((key, preValue) {
      newAddressDetails.toJson()[key] != preValue
          ? differentFields[key] = newAddressDetails.toJson()[key]
          : null;
    });

   ApiResponse response =  await _apiService.updateAddressDetails(addressId: prevAddressDetails.id, updatedFields: differentFields);
   if(response.status == "success"){
     await _navigationService.replaceWith(Routes.addressesViewRoute);
   }
  }
}
