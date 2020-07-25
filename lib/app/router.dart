import 'package:auto_route/auto_route_annotations.dart';
import 'package:store/ui/views/addresses/addresses_view.dart';
import 'package:store/ui/views/cart/cart_view.dart';
import 'package:store/ui/views/dashboard/dashboard_view.dart';
import 'package:store/ui/views/login/login_view.dart';
import 'package:store/ui/views/login/otp/otp_view.dart';
import 'package:store/ui/views/onboarding/onBoarding_view.dart';
import 'package:store/ui/views/product_details/productDetails_view.dart';
import 'package:store/ui/views/product_list/productsList_view.dart';
import 'package:store/ui/views/splashScreen/splashScreen_view.dart';


@MaterialAutoRouter()
class $Router {
  OnBoardingView onBoardingViewRoute;
  LoginView loginViewRoute;
  SplashScreenView splashScreenViewRoute;
  OtpView otpViewRoute;
  DashboardView dashboardViewRoute;
  AddressesView addressesViewRoute;
  ProductsListView productsListViewRoute;
  ProductDetailsView productDetailsView;
  CartView cartViewRoute;
}