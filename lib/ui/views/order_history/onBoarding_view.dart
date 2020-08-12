import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:store/ui/views/onboarding/onBoarding_viewModel.dart';

class OrderHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
        builder: (context, model, child)=>Scaffold(
          body: Container(color: Colors.blue,),
        ),
        viewModelBuilder: ()=> OnBoardingViewModel());
  }
}

