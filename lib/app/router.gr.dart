// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:store/ui/views/onboarding/onBoarding_view.dart';
import 'package:store/ui/views/login/login_view.dart';
import 'package:store/ui/views/splashScreen/splashScreen_view.dart';
import 'package:store/ui/views/login/otp/otp_view.dart';
import 'package:store/ui/views/dashboard/dashboard_view.dart';
import 'package:store/ui/views/addresses/addresses_view.dart';
import 'package:store/ui/views/product_list/productsList_view.dart';
import 'package:store/ui/views/product_details/productDetails_view.dart';
import 'package:store/models/product.dart';
import 'package:store/ui/views/cart/cart_view.dart';
import 'package:store/ui/views/wishlist/wishlist_view.dart';
import 'package:store/ui/views/buy/buy_view.dart';
import 'package:store/ui/views/subcategory_details/subcategory_view.dart';
import 'package:store/ui/views/map/map_view.dart';
import 'package:store/ui/views/addresses/editAddress/editAddress_view.dart';

abstract class Routes {
  static const onBoardingViewRoute = '/on-boarding-view-route';
  static const loginViewRoute = '/login-view-route';
  static const splashScreenViewRoute = '/splash-screen-view-route';
  static const otpViewRoute = '/otp-view-route';
  static const dashboardViewRoute = '/dashboard-view-route';
  static const addressesViewRoute = '/addresses-view-route';
  static const productsListViewRoute = '/products-list-view-route';
  static const productDetailsView = '/product-details-view';
  static const cartViewRoute = '/cart-view-route';
  static const wishListViewRoute = '/wish-list-view-route';
  static const buyViewRoute = '/buy-view-route';
  static const subCategoryView = '/sub-category-view';
  static const mapViewRoute = '/map-view-route';
  static const editAddressViewRoute = '/edit-address-view-route';
  static const all = {
    onBoardingViewRoute,
    loginViewRoute,
    splashScreenViewRoute,
    otpViewRoute,
    dashboardViewRoute,
    addressesViewRoute,
    productsListViewRoute,
    productDetailsView,
    cartViewRoute,
    wishListViewRoute,
    buyViewRoute,
    subCategoryView,
    mapViewRoute,
    editAddressViewRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.onBoardingViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => OnBoardingView(),
          settings: settings,
        );
      case Routes.loginViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginView(),
          settings: settings,
        );
      case Routes.splashScreenViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SplashScreenView(),
          settings: settings,
        );
      case Routes.otpViewRoute:
        if (hasInvalidArgs<OtpViewArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<OtpViewArguments>(args);
        }
        final typedArgs = args as OtpViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => OtpView(
              phoneNumber: typedArgs.phoneNumber,
              verificationId: typedArgs.verificationId),
          settings: settings,
        );
      case Routes.dashboardViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => DashboardView(),
          settings: settings,
        );
      case Routes.addressesViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddressesView(),
          settings: settings,
        );
      case Routes.productsListViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ProductsListView(),
          settings: settings,
        );
      case Routes.productDetailsView:
        if (hasInvalidArgs<ProductDetailsViewArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<ProductDetailsViewArguments>(args);
        }
        final typedArgs = args as ProductDetailsViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              ProductDetailsView(productDetails: typedArgs.productDetails),
          settings: settings,
        );
      case Routes.cartViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CartView(),
          settings: settings,
        );
      case Routes.wishListViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => WishListView(),
          settings: settings,
        );
      case Routes.buyViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => BuyView(),
          settings: settings,
        );
      case Routes.subCategoryView:
        if (hasInvalidArgs<SubCategoryViewArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<SubCategoryViewArguments>(args);
        }
        final typedArgs = args as SubCategoryViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              SubCategoryView(categoryTitle: typedArgs.categoryTitle),
          settings: settings,
        );
      case Routes.mapViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MapView(),
          settings: settings,
        );
      case Routes.editAddressViewRoute:
        if (hasInvalidArgs<EditAddressViewArguments>(args)) {
          return misTypedArgsRoute<EditAddressViewArguments>(args);
        }
        final typedArgs =
            args as EditAddressViewArguments ?? EditAddressViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => EditAddressView(
              langitude: typedArgs.langitude, longitude: typedArgs.longitude),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//OtpView arguments holder class
class OtpViewArguments {
  final String phoneNumber;
  final String verificationId;
  OtpViewArguments({@required this.phoneNumber, @required this.verificationId});
}

//ProductDetailsView arguments holder class
class ProductDetailsViewArguments {
  final Product productDetails;
  ProductDetailsViewArguments({@required this.productDetails});
}

//SubCategoryView arguments holder class
class SubCategoryViewArguments {
  final String categoryTitle;
  SubCategoryViewArguments({@required this.categoryTitle});
}

//EditAddressView arguments holder class
class EditAddressViewArguments {
  final double langitude;
  final double longitude;
  EditAddressViewArguments({this.langitude, this.longitude});
}
