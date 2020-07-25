import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:store/ui/views/dashboard/profie/profile_viewModel.dart';
import 'package:store/ui/views/onboarding/onBoarding_viewModel.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.nonReactive(
        builder: (context, model, child)=>Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                color: Colors.blueGrey,
                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.person, color: Color(0xff00ADB5),size: 60,),
                    ),
                    Text(
                      'Akash Duggal',
                      style: TextStyle(color: Color(0xffEEEEEE),fontSize: 22),
                    ),
                    Text(
                      'MIG 567, Jamalpur Colony, Chandigarh Road, Ludhiana',
                      style: TextStyle(color: Color(0xD9EEEEEE),
                          fontSize: 12),
                    ),
                    Text(
                      '+918570897778',
                      style: TextStyle(color: Color(0xD9EEEEEE),
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.blueGrey,
                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    MaterialButton(
                      onPressed: (){
//                        Router.navigator.pushNamed(
//                            Router.userLocationMapPage);
                      },
                      child: Text(
                        'Location',
                        style: TextStyle(color: Color(0xD9EEEEEE),
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
        viewModelBuilder: ()=> ProfileViewModel());
  }
}
