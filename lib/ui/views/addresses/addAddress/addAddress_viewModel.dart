import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/models/address.dart';
import 'package:store/services/api.dart';
import 'package:store/services/local_storage_service.dart';

class AddAddressViewModel extends BaseViewModel {
  ApiService _apiService = locator<ApiService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();
  NavigationService _navigationService = locator<NavigationService>();

  void saveAddress(address) async{
//    print(address.toJson().toString());
    LocalStorageService.getInstance().then((value)async{
      if(_localStorageService.user!=null){
        var userId = _localStorageService.user.id;
        print("userId"+ userId);
       var response = await _apiService.createNewAddress(address, userId);
       if(response.status == "success"){
      _navigationService.popRepeated(1);
         await _navigationService.replaceWith(Routes.addressesViewRoute);
       }
      }
    });

  }

  void navigateToMap() async{
    await _navigationService.navigateTo(Routes.mapViewRoute);
  }





}
