import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';

import 'login_viewModel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _allowExit = false;
  String verificationId;
  String smsCode;
  AuthCredential credential;
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;



  bool isMessageSent = false;
  final FocusNode myFocusNodeEmailLogin = FocusNode();
  TextEditingController phoneNumberController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        builder: (context, model, child)=>Scaffold(
          appBar: AppBar(
            title: Text("Login"),
          ),
          resizeToAvoidBottomPadding: false,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.black,
                    child: Image.asset(
                      "assets/images/login_page_illustration.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              autovalidate: _autovalidate,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 10.0,
                                    right: 10.0),
                                child: Theme(
                                  data: ThemeData(
                                      primaryColor: Constants.tealColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
//                                        maxLength: 10,
                                      focusNode: myFocusNodeEmailLogin,
                                      controller: phoneNumberController,
                                      keyboardType: TextInputType.phone,
                                      validator: (String value) {
                                        if(value.isEmpty){
                                          return 'Please enter mobile Number';
                                        }
                                        else{
                                          return null;
                                        }
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      style: TextStyle(
                                          color: Constants.offWhiteColor),
                                      maxLines: 1,
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.phone_android,
                                          color: Constants.offWhiteColor,
                                          size: 22.0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.offWhiteColor,
                                              width: 0.5),
                                        ),
                                        counterText: '',
                                        border: OutlineInputBorder(),
                                        labelText: 'Mobile Number',
                                        labelStyle: TextStyle(
                                            color: Constants.offWhiteColor),
                                        hintStyle: TextStyle(
                                            color: Constants.offWhiteColor),
//                                        errorText: model.isPhoneInvalid
//                                            ? "Invalid phone number"
//                                            : null,

                                      ),
                                    onChanged: (value) {
                                      model.validatePhone(value);
                                    },
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
//
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(top: 10),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "We will send you a One Time SMS Message.",
                                    style: TextStyle(
                                        color: Constants.offWhiteColor
                                            .withOpacity(0.7)),
                                  ),
                                  Text(
                                    "Carrier Charges may apply.",
                                    style: TextStyle(
                                        color: Constants.offWhiteColor
                                            .withOpacity(0.7)),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding:
                              EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(22.0)),
                                minWidth: 200.0,
                                height: 35,
                                disabledColor:
                                Constants.tealColor.withOpacity(0.7),
                                color: Constants.tealColor,
                                child:

                                new Text('Login',
                                    style: new TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white)),
//                                onPressed: model.isPhoneValid
//                                    ? (){print("valid");}
//                                    : null,
                                onPressed: () async{
                                  if(_formKey.currentState.validate()){
                                    print("validated");
                                    model.isPhoneValid?
                                    model.sendOTP(phoneNumber: phoneNumberController.text.toString())

                                        :null;
                                  }
                                  else{
                                    setState(() {
                                      _autovalidate = true;
                                    });
                                  }
                                },

                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        viewModelBuilder: ()=> LoginViewModel());
  }
}


