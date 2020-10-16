import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/models/address.dart';
import 'package:store/services/api.dart';
import 'package:store/services/local_storage_service.dart';

class AddressesViewModel extends BaseViewModel {
  var _selectedIndex = [];
  get selectedIndex => _selectedIndex;

  var _DefaultIndex;
  get defaultIndex => _DefaultIndex;

  NavigationService _navigationService = locator<NavigationService>();
  ApiService _apiService = locator<ApiService>();
  DialogService _dialogService = locator<DialogService>();
  Future<LocalStorageService> _localStorageService =  LocalStorageService.getInstance();

  bool checkDefaultAddress() {
    return false;
  }

  void setSelectedIndex(index) {
    _selectedIndex.add(index);
    notifyListeners();
    print(_selectedIndex);
  }

  void setDefaultIndex(index) {
    _DefaultIndex = index;
    notifyListeners();
    print(_DefaultIndex);
  }

  void navigateToMapView() async {
    await _navigationService.navigateTo(Routes.mapViewRoute);
  }

  List<Address> _addresses = [];
  get addresses => _addresses;

  initialiseAllAddresses() async {
    setBusy(true);
    print("initialiseAllAddresses");
    _addresses =
        await _apiService.fetchAllAddresses();
    var defaultAddressId =
        await _apiService.fetchDefaultAddressId();
    print("defaultAddressId Respinse" + defaultAddressId.result.toString());

    //add validation of api response status
    if (defaultAddressId.result == null && _addresses.length!=0) {
      setAddressAsDefault(_addresses[0].id,0);
      setDefaultIndex(0);
    }
    else{
      _localStorageService.then((value){
        value.userAddresses = _addresses;
        value.defaultAddressId = Address.fromJson(defaultAddressId.result[0]).id;
        print("USER ADDRESSES IN LOCAL" + value.userAddresses.toString() );
      });

      _addresses.asMap().forEach((index, address) {
        if (address.id == Address.fromJson(defaultAddressId.result[0]).id) {   //converted to list response
          _selectedIndex.clear();
          _selectedIndex.add(index);
          setDefaultIndex(index);
          print(_selectedIndex);
          print(index);
          notifyListeners();
        }
      });
    }

    setBusy(false);
    notifyListeners();
  }

  void setAddressAsDefault(addressId, index) async {

    setBusy(true);
    selectedIndex.clear();
    setSelectedIndex(index);
    setDefaultIndex(index);
    _localStorageService.then((value) async{
      var defaultAddressResponse = await _apiService.setAddressAsDefault(
          value.user.id, addressId);
      if (defaultAddressResponse.status == "success") {
        Future.delayed(Duration(seconds: 3)).then((value) {
          setBusy(false);
        });
      }
    });

  }

  void deleteUserAddressById(addressId, index) async {
    print(addressId);
    //    setBusy(true);
    _localStorageService.then((value) async{
      var deleteAddressResponse = await _apiService.deleteUserAddress(
          value.user.id, addressId);
      if (deleteAddressResponse.status == "success") {
        _addresses.removeAt(index);
        if(index==_DefaultIndex){
          _DefaultIndex = -1;
        }
        if(index<defaultIndex){
          setDefaultIndex(_DefaultIndex-1);
        }
        if(defaultIndex==-1 && _addresses.length ==1){
          initialiseAllAddresses();
        }
        notifyListeners();
      }else{
        _dialogService.showDialog(
            title: "error",
            buttonTitle: "ok",
            description: deleteAddressResponse.result.toString()
        );
      }
    });

  }

  void openEditAddressView(Address address) async{
    await _navigationService.navigateTo(Routes.editAddressViewRoute,
        arguments: EditAddressViewArguments(address: address));
  }
}
