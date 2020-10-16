import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/models/address.dart';
import 'package:store/services/api.dart';
import 'package:store/services/local_storage_service.dart';

class OrderAddressViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  ApiService _apiService = locator<ApiService>();
  DialogService _dialogService = locator<DialogService>();
  LocalStorageService _localStorageService = locator<LocalStorageService>();

  List<Address> _otherAddresses;
  get otherAddresses => _otherAddresses;

  List<Address> _allAddresses;
  get allAddresses => _allAddresses;


  Address _defaultAddress = Address();
  get defaultAddress => _defaultAddress;

  String _defaultAddressId;
  get defaultAddressId => _defaultAddressId;

  Map _selectedAddressMap = {};
  get selectedAddressMap => _selectedAddressMap;

  String selectedAddresId  = "";

  initialise(){
    LocalStorageService.getInstance().then((value) async{
      setBusy(true);
      _defaultAddressId = _localStorageService.defaultAddressId;
      selectedAddresId = _defaultAddressId;
      _allAddresses = _localStorageService.userAddresses.map((e) => Address.fromJson(e)).toList();
      _otherAddresses = _allAddresses.where((address) => address.id!= _defaultAddressId).toList();
      _defaultAddress = _allAddresses.where((address) => address.id == _defaultAddressId).toList()[0];
      _allAddresses.asMap().forEach((index, value) => _allAddresses[index].id != _defaultAddressId ? _selectedAddressMap[_allAddresses[index].id]=false : _selectedAddressMap[_allAddresses[index].id]=true);
      Future.delayed(Duration(seconds: 1)).then((value) => setBusy(false));
      print("Selected AddressId :"+ selectedAddresId);
    });

  }

  void updateSelectedAddress(addressId) {
    _allAddresses.asMap().forEach((index, value) => _allAddresses[index].id != _defaultAddressId ? _selectedAddressMap[_allAddresses[index].id]=false : _selectedAddressMap[_allAddresses[index].id]=true);
    _selectedAddressMap.forEach((address,value) => address == addressId ? _selectedAddressMap[address] = true :  _selectedAddressMap[address] = false );
    notifyListeners();
    selectedAddresId = _selectedAddressMap.keys.where((element) => _selectedAddressMap[element]==true).toList().removeLast();
    print("Selected AddressId :"+ selectedAddresId);
  }

  void navigateToPaymentOptionView(totalAmountPayable) async{
    await _navigationService.navigateTo(Routes.buyViewRoute, arguments: BuyViewArguments(totalAmountPayable: totalAmountPayable, orderDetails: {"addressId": selectedAddresId }));
  }

}
