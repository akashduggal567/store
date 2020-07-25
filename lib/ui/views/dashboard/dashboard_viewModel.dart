import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/services/authentication_service.dart';

class DashboardViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  void naviagteToAddresses() async{
    await _navigationService.navigateTo(Routes.addressesViewRoute);
  }

  void signOutUser() async {
    await _authenticationService.logOut();
  }

  void navigateToCart() {
    _navigationService.navigateTo(Routes.cartViewRoute);
  }

}
