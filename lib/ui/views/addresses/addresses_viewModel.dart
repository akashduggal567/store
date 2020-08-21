import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';

class AddressesViewModel extends BaseViewModel {
  var _selectedIndex = [0];
  get selectedIndex => _selectedIndex;
  NavigationService _navigationService = locator<NavigationService>();

  bool checkDefaultAddress() {
    return false;
  }

  void setSelectedIndex(index) {
    _selectedIndex.add(index);
    notifyListeners();
    print(_selectedIndex);
  }

  void navigateToMapView() async{
    await _navigationService.navigateTo(Routes.mapViewRoute);
  }

}
