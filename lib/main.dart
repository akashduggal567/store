import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/ui/views/login/login_view.dart';
import 'package:store/ui/views/onboarding/onBoarding_view.dart';
import 'package:store/ui/views/splashScreen/splashScreen_view.dart';

import 'data/products_parser.dart';
import 'helpers/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child){
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
//      home: StreamExampleView(),
      theme: ThemeData(
          primaryTextTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
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


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}