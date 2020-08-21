import 'package:store/ui/views/login/login_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'otp_viewmodel.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

String userInputOtp;

class OtpView extends StatelessWidget {
  final String phoneNumber;
  final String verificationId;
  const OtpView({@required this.phoneNumber,@required this.verificationId});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpViewModel>.nonReactive(
        builder: (context,model,child)=>
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.black,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _OtpInputWidget(model,phoneNumber),
                      //handle params passing through widgets and implement nextbutton widget here
                     Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 4),
                      width: 90,
                      height: 40,
                      child: RaisedButton(
                        color: Color(0xffE7783E),
                        disabledColor: Colors.transparent,
                        splashColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
//                  side: BorderSide(color: Colors.grey)
                        ),
                        onPressed: (){
                          model.verifyOtp(verificationId: verificationId, userInputOtp: userInputOtp);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Next",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                    _resendSmsWidget(),
                  ],
                ),
              ),
            ),
          ),

        viewModelBuilder: ()=>OtpViewModel());
  }
}


Widget _OtpInputWidget(OtpViewModel model,phoneNumber){
  var textController = new TextEditingController();
  return Container(
    height: 300,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(margin:EdgeInsets.only(left: 20),child: Text("Enter your code", style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold),)),
        Center(
          child: Container(
//            color: Colors.blue,

            width: double.infinity,
            child: Center(
              child: Container(
                child: PinCodeTextField(
                  autofocus: true,
            controller: textController,
                  hideCharacter: false,
                  highlight: true,
                  highlightPinBoxColor: Colors.grey,
                  highlightColor: Colors.grey,
                  defaultBorderColor: Colors.black,
//            hasTextBorderColor: Colors.orange,
                  maxLength: 6,
                  pinBoxRadius: 16,
                  pinBoxHeight: 60,
                  pinBoxWidth: 50,
//            hasError: hasError,
//            maskCharacter: "😎",
                  onTextChanged: (text) {
//              setState(() {
//                hasError = false;
//              });
                  },
                  onDone: (text) {
//              print("DONE $text");
                    userInputOtp = textController.text;
              print("DONE CONTROLLER ${textController.text}");
                  },
                  wrapAlignment: WrapAlignment.spaceAround,
                  pinBoxDecoration:
                  ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                  pinTextStyle: TextStyle(fontSize: 30.0, color: Colors.white),
                  pinTextAnimatedSwitcherTransition:
                  ProvidedPinBoxTextAnimation.scalingTransition,
                          pinBoxColor: Colors.grey,
                  pinTextAnimatedSwitcherDuration:
                  Duration(milliseconds: 300),
//                    highlightAnimation: true,
//            highlightPinBoxColor: Colors.red,
                  highlightAnimationBeginColor: Colors.grey,
                  highlightAnimationEndColor: Colors.white12,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ),
        ),
        Center(child: Container(child: Text("We have sent a code to +91$phoneNumber", style: TextStyle(color: Colors.white),))),
      ],
    ),
  );
}

Widget _nextButtonWidget(OtpViewModel model,verificationId, userInputOtp){
  return  Center(
    child: Container(
      margin: EdgeInsets.only(bottom: 4),
      width: 90,
      height: 40,
      child: RaisedButton(
        color: Color(0xffE7783E),
        disabledColor: Colors.transparent,
        splashColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
//                  side: BorderSide(color: Colors.grey)
        ),
        onPressed: (){
          model.verifyOtp(verificationId: verificationId, userInputOtp: userInputOtp);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Next",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    ),
  );

}

Widget _resendSmsWidget(){
  return Center(
    child: Container(
      child: MaterialButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.message, color: Colors.white,),
            SizedBox(width: 20,),
            Text("Resend SMS", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
          ],
        ),
      ),
    ),
  );
}