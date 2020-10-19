//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/setup_snackbar_ui.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/services/api.dart';
import 'package:store/services/local_storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:store/ui/widgets/pdf_view.dart';

class BuyViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  ApiService _apiService = locator<ApiService>();
  DialogService _dialogService = locator<DialogService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();


  var _uploading = false;
  get uploading => _uploading;


  Future<File> getFileFromUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  void codPayment(
      {@required orderDetails,
      @required totalAmount,
      @required paymentMode}) async {

    Map<String, dynamic> invoiceObject = {
      ...orderDetails,
      "totalAmount": totalAmount,
      "paymentMode": paymentMode
    };

    print(invoiceObject);

   ApiResponse response =  await _apiService.createOrder(orderDetails: invoiceObject);
   print(response.status+ response.result.toString());
   if(response.status == 'success'){
     var dialogResponse = await _dialogService.showConfirmationDialog(
        title: "Invoice",description: "Order was Placed Successfully. \n Press view to see your invoice for the order",confirmationTitle: "View", cancelTitle: "Cancel"
      );

     if(dialogResponse.confirmed){
       print("confirmed");
       getFileFromUrl(response.result[0]["invoiceUrl"]).then((value) =>
       _navigationService.navigateWithTransition(PdfViewPage(path: value.path,fileUrl: response.result[0]["invoiceUrl"],),transition: "rightToLeft")
       );

     }

   }else{
     _dialogService.showCustomDialog(
       variant: SnackbarType.greenAndRed,
         title: "Error",description: "Order was unable to be placed. Please try again",
     );
   }
  }
}
