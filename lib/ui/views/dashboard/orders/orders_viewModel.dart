import 'dart:io';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/helpers/ApiResponse.dart';
import 'package:store/models/order.dart';
import 'package:store/services/api.dart';
import 'package:store/services/authentication_service.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/ui/widgets/pdf_view.dart';
import 'package:http/http.dart' as http;

class OrdersViewModel extends BaseViewModel {
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  static CartService _cartService = locator<CartService>();

  List _orders = [];
  get orders => _orders;

  fetchOrders() async{
    ApiResponse response =await _apiService.getOrders();
    if(response.status == "success"){
      _orders = response.result.map((e) => Order.fromJson(e)).toList();
      notifyListeners();
    }
  }


  void openPdfView({pdfUrl}) async{

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
    getFileFromUrl(pdfUrl).then((value) =>
        _navigationService.navigateWithTransition(PdfViewPage(path: value.path,fileUrl: pdfUrl,),transition: "rightToLeft")
    );
  }

}
