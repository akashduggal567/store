//import 'package:store/app/locator.dart';
//import 'package:store/ui/views/dashboard/bookings/bookings_view.dart';
//import 'package:store/ui/views/filledstacks/future_example/future_example_view.dart';
//import 'package:store/ui/views/filledstacks/partial_builds/partial_builds_view.dart';
//import 'package:store/ui/views/filledstacks/reactive_example/reactive_example_view.dart';
//import 'package:store/ui/views/filledstacks/stream_example/stream_example_view.dart';
//import 'package:store/ui/views/splashscreen/splash_screen_view.dart';
//import 'package:store/ui/views/userRegister/djPref/dj_pref_view.dart';
//import 'package:store/ui/views/userRegister/languagePref/language_pref_view.dart';
//import 'package:store/ui/views/userRegister/user_register_view.dart';
//import 'package:flutter/material.dart';
//import 'package:store/ui/views/filledstacks/home/home_view.dart';
//import 'package:store/app/router.gr.dart';
//import 'package:stacked_services/stacked_services.dart';
//
//import 'managers/setup_custom_dialog_ui.dart';
//import 'models/user.dart';
//import 'ui/views/dashboard/dashboard_view..dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/ui/views/login/login_view.dart';
import 'package:store/ui/views/onboarding/onBoarding_view.dart';
import 'package:store/ui/views/splashScreen/splashScreen_view.dart';

import 'data/products_parser.dart';
import 'helpers/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
//      home: StreamExampleView(),
      theme: ThemeData(
          primaryColor: Colors.black,
          unselectedWidgetColor: Constants.tealColor,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
              color: Colors.black,
              actionsIconTheme: IconThemeData(color: Constants.tealColor),
              iconTheme: IconThemeData(color: Constants.tealColor))),
//      initialRoute: Routes.splashScreenViewRoute,
      home: SplashScreenView(),
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
