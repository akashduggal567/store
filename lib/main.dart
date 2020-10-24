import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:store/services/connectivity_service.dart';
import 'package:store/ui/views/splashScreen/splashScreen_view.dart';
import 'app/setup_snackbar_ui.dart';
import 'helpers/constants.dart';
import 'helpers/enums/connectivity_status.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await setupSnackbarUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
//  MultiProvider(
//  providers: [
//  StreamProvider<ConnectivityStatus>.value(
//  value: ConnectivityService().connectionStatusController.stream,
//  ),
//  ],
//  ConnectivityService _connectivityService = locator<ConnectivityService>();
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

  @override
  void dispose() {
    print('I have been disposed in main!!');
//    locator<ConnectivityService>().connectionStatusController?.close();
//    super.dispose();
  }

}


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}