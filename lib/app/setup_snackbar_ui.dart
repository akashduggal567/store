import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/helpers/constants.dart';

import 'locator.dart';

/// The type of snackbar to show
enum SnackbarType { blackAndWhite, greenAndRed }

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: Colors.red,
    textColor: Colors.white,
    mainButtonTextColor: Colors.black,
  ));

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.blackAndWhite,
    config: SnackbarConfig(
      icon: Icon(Icons.add_shopping_cart, color: Colors.white,),
//      backgroundColor: Colors.black,
      backgroundGradient:  LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Constants.darkBlackColor,  Colors.black]),
      textColor: Constants.offWhiteColor,
      borderRadius: 14,
      shouldIconPulse: false,
      borderWidth: 0.5,
      borderColor: Constants.offWhiteColor,
//      borderColor: Constants.offWhiteColor,
      margin: EdgeInsets.all(12.0)
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.greenAndRed,
    config: SnackbarConfig(
      backgroundColor: Colors.white,
      titleColor: Colors.green,
      messageColor: Colors.red,
      borderRadius: 1,
    ),
  );
}