import 'package:store/app/locator.dart';
import 'package:store/app/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/app/locator.dart';
import 'splashScreen_viewmodel.dart';


class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3),() => {});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
            color: Colors.white,
            child: Center(child: Text("store"))),
      ),
      viewModelBuilder: () => SplashScreenViewModel(),
      onModelReady: (model) =>     Future.delayed(Duration(seconds: 3),() => {model.handleStartUpLogic()}),
    );
  }
}


//class SplashScreenView extends StatelessWidget {
//  final NavigationService _navigationService = locator<NavigationService>();
//
//  Future<void> navigate(){
//    return _navigationService.navigateTo(Routes.loginViewRoute);
//  }
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    Future.delayed(Duration(seconds: 5),() => { navigate()});
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return ViewModelBuilder<SplashScreenViewModel>.reactive(
//      builder: (context, model, child) => Scaffold(
//        body: Container(
//            color: Colors.white,
//            child: Center(child: model.logo)),
//      ),
//      viewModelBuilder: () => SplashScreenViewModel(),
//    );
//  }
//
//
//}
