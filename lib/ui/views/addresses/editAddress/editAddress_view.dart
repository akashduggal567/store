import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/models/address.dart';

import 'editAddress_viewModel.dart';

class EditAddressView extends StatefulWidget {
  double langitude;
  double longitude;
  EditAddressView({
    this.langitude,this.longitude
  });
  @override
  _EditAddressViewState createState() => _EditAddressViewState();
}

class _EditAddressViewState extends State<EditAddressView> {
  final _formKey = GlobalKey<FormState>();

  bool _autovalidate = false;

  List<String> cityOptions = <String>[
    'Ludhiana',
  ];

  List<String> addressTypeOptions = <String>['Home', 'Office'];
  TextEditingController langitudeController = new TextEditingController();

  TextEditingController longitudeController = new TextEditingController();

  TextEditingController fullNameController = new TextEditingController();

  TextEditingController mobileNumberController = new TextEditingController();

  TextEditingController pinCodeController = new TextEditingController();

  TextEditingController mainAddressController = new TextEditingController();

  TextEditingController streetAddressController = new TextEditingController();

  TextEditingController landmarkController = new TextEditingController();

  String defaultDropdownCityValue = 'Ludhiana';

  String defaultDropdownAddressTypeValue = 'Home';

  String dropdownLocationValue = 'Ludhiana';

  final _langitudeFocusNode = new FocusNode();
  final _longitudeFocusNode = new FocusNode();
  final _fullNameFocusNode = new FocusNode();
  final _mobileNumberFocusNode = new FocusNode();
  final _pinCodeFocusNode = new FocusNode();

  final _mainAddressFocusNode = new FocusNode();
  final _streetAddressFocusNode = new FocusNode();
  final _landmarkFocusNode = new FocusNode();
  final _productTitleFocusNode = new FocusNode();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    langitudeController = new TextEditingController(text: widget.langitude.toString());
    longitudeController = new TextEditingController(text: widget.longitude.toString());
  }

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<EditAddressViewModel>.nonReactive(
        builder: (context, model, child) => WillPopScope(
          child: Scaffold(
                appBar: AppBar(
                  title: Text("Edit Address"),
                ),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: _formKey,
                                autovalidate: _autovalidate,
                                child: ListView(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(bottom: 20, top: 10,right: 5),
                                            child: IgnorePointer(
                                              ignoring: true,
                                              child: TextFormField(
                                                controller: langitudeController,
                                                focusNode: _langitudeFocusNode,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  WhitelistingTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Please enter Langitude';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                style: TextStyle(
                                                    color: Constants.offWhiteColor),
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.orange,
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2.0),
                                                  ),
                                                  counterText: '',
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Langitude',
                                                  labelStyle:
                                                      TextStyle(color: Colors.white),
                                                  hintStyle:
                                                      TextStyle(color: Colors.white),
                                                ),
                                                textInputAction: TextInputAction.next,
                                                onFieldSubmitted: (value) {
                                                  if (value.isNotEmpty) {
                                                    this.setState(() {
                                                      langitudeController.text =
                                                          value.trim();
                                                    });
                                                    FocusScope.of(context).requestFocus(
                                                        _productTitleFocusNode);
                                                  }
                                                },
                                                onChanged: (value) {
//            model.validatePhone(value);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin:
                                            EdgeInsets.only(bottom: 20, top: 10,left: 5),
                                            child: IgnorePointer(
                                              ignoring: true,
                                              child: TextFormField(
                                                controller: longitudeController,
                                                focusNode: _longitudeFocusNode,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  WhitelistingTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Please enter Longitude';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                style: TextStyle(
                                                    color: Constants.offWhiteColor),
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.orange,
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2.0),
                                                  ),
                                                  counterText: '',
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Longitude',
                                                  labelStyle:
                                                  TextStyle(color: Colors.white),
                                                  hintStyle:
                                                  TextStyle(color: Colors.white),
                                                ),
                                                textInputAction: TextInputAction.next,
                                                onFieldSubmitted: (value) {
                                                  if (value.isNotEmpty) {
                                                    this.setState(() {
                                                      longitudeController.text =
                                                          value.trim();
                                                    });
                                                    FocusScope.of(context).requestFocus(
                                                        _productTitleFocusNode);
                                                  }
                                                },
                                                onChanged: (value) {
//            model.validatePhone(value);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        width: double.infinity,
                                        child: DropdownButtonFormField<String>(
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "Please select atleast one address type";
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: defaultDropdownAddressTypeValue,
                                          icon: Icon(Icons.arrow_downward),
                                          iconSize: 24,
                                          elevation: 16,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.orange,
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 2.0),
                                            ),
                                            counterText: '',
                                            border: OutlineInputBorder(),
                                            labelText: 'Address Type',
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16),
                                          iconEnabledColor: Colors.black,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              defaultDropdownAddressTypeValue =
                                                  newValue;
                                            });
                                          },
                                          selectedItemBuilder:
                                              (BuildContext context) {
                                            return addressTypeOptions
                                                .map((String value) {
                                              return Text(
                                                defaultDropdownAddressTypeValue,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              );
                                            }).toList();
                                          },
                                          items: addressTypeOptions
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                        )),
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 20, top: 10),
                                      child: IgnorePointer(
                                        ignoring: false,
                                        child: TextFormField(
                                          controller: fullNameController,
                                          focusNode: _fullNameFocusNode,
                                          keyboardType: TextInputType.number,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return 'Please enter Full Name';
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: TextStyle(
                                              color: Constants.offWhiteColor),
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.orange,
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 2.0),
                                            ),
                                            counterText: '',
                                            border: OutlineInputBorder(),
                                            labelText: 'Full Name',
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onFieldSubmitted: (value) {
                                            if (value.isNotEmpty) {
                                              this.setState(() {
                                                fullNameController.text =
                                                    value.trim();
                                              });
                                              FocusScope.of(context).requestFocus(
                                                  _productTitleFocusNode);
                                            }
                                          },
                                          onChanged: (value) {
//            model.validatePhone(value);
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 20, top: 10),
                                      child: IgnorePointer(
                                        ignoring: false,
                                        child: TextFormField(
                                          controller: mainAddressController,
                                          focusNode: _mainAddressFocusNode,
                                          maxLines: 3,
                                          minLines: 1,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return 'Please enter your address';
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: TextStyle(
                                              color: Constants.offWhiteColor),
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.orange,
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 2.0),
                                            ),
                                            counterText: '',
                                            border: OutlineInputBorder(),
                                            labelText:
                                                'Flat, House no., Building, Company, Apartment',
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onFieldSubmitted: (value) {
                                            if (value.isNotEmpty) {
                                              this.setState(() {
                                                mainAddressController.text =
                                                    value.trim();
                                              });
                                            }
                                          },
                                          onChanged: (value) {
//            model.validatePhone(value);
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 20, top: 10),
                                      child: IgnorePointer(
                                        ignoring: false,
                                        child: TextFormField(
                                          controller: streetAddressController,
                                          focusNode: _streetAddressFocusNode,
                                          maxLines: 3,
                                          minLines: 1,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return 'Please enter your street address';
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: TextStyle(
                                              color: Constants.offWhiteColor),
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.orange,
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 2.0),
                                            ),
                                            counterText: '',
                                            border: OutlineInputBorder(),
                                            labelText:
                                                'Area, Colony, Street, Sector, Village',
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onFieldSubmitted: (value) {
                                            if (value.isNotEmpty) {
                                              this.setState(() {
                                                streetAddressController.text =
                                                    value.trim();
                                              });
                                            }
                                          },
                                          onChanged: (value) {
//            model.validatePhone(value);
                                          },
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(bottom: 20, top: 10,right: 5),
                                            child: IgnorePointer(
                                              ignoring: false,
                                              child: TextFormField(
                                                controller: landmarkController,
                                                focusNode: _landmarkFocusNode,
                                                maxLines: 3,
                                                minLines: 1,
//                                              validator: (String value) {
//                                                if (value.isEmpty) {
//                                                  return 'Please enter your landmark';
//                                                } else {
//                                                  return null;
//                                                }
//                                              },
                                                style: TextStyle(
                                                    color: Constants.offWhiteColor),
                                                decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.orange,
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2.0),
                                                  ),
                                                  counterText: '',
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Landmark',
                                                  labelStyle:
                                                      TextStyle(color: Colors.white),
                                                  hintStyle:
                                                      TextStyle(color: Colors.white),
                                                ),
                                                textInputAction: TextInputAction.next,
                                                onFieldSubmitted: (value) {
                                                  if (value.isNotEmpty) {
                                                    this.setState(() {
                                                      landmarkController.text =
                                                          value.trim();
                                                    });
                                                  }
                                                },
                                                onChanged: (value) {
//            model.validatePhone(value);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin:
                                            EdgeInsets.only(bottom: 20, top: 10,left: 5),
                                            child: IgnorePointer(
                                              ignoring: false,
                                              child: TextFormField(
                                                controller: mobileNumberController,
                                                focusNode: _mobileNumberFocusNode,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  WhitelistingTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Please enter your Mobile Number';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                style: TextStyle(
                                                    color: Constants.offWhiteColor),
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.orange,
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2.0),
                                                  ),
                                                  counterText: '',
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Mobile Number',
                                                  labelStyle:
                                                  TextStyle(color: Colors.white),
                                                  hintStyle:
                                                  TextStyle(color: Colors.white),
                                                ),
                                                textInputAction: TextInputAction.next,
                                                onFieldSubmitted: (value) {
                                                  if (value.isNotEmpty) {
                                                    this.setState(() {
                                                      mobileNumberController.text =
                                                          value.trim();
                                                    });
                                                    FocusScope.of(context).requestFocus(
                                                        _productTitleFocusNode);
                                                  }
                                                },
                                                onChanged: (value) {
//            model.validatePhone(value);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                              margin: EdgeInsets.only(bottom: 20,right: 5),
                                              width: double.infinity,
                                              child: DropdownButtonFormField<String>(
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return "Please select atleast one category";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                value: defaultDropdownCityValue,
                                                isExpanded: true,
                                                icon: Icon(Icons.arrow_downward),
                                                iconSize: 24,
                                                elevation: 16,
                                                decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.orange,
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2.0),
                                                  ),
                                                  counterText: '',
                                                  border: OutlineInputBorder(),
                                                  labelText: 'City',
                                                  labelStyle:
                                                      TextStyle(color: Colors.white),
                                                  hintStyle:
                                                      TextStyle(color: Colors.white),
                                                ),
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 16),
                                                iconEnabledColor: Colors.black,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    defaultDropdownCityValue = newValue;
                                                  });
                                                },
                                                selectedItemBuilder:
                                                    (BuildContext context) {
                                                  return cityOptions
                                                      .map((String value) {
                                                    return Text(
                                                      defaultDropdownCityValue,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    );
                                                  }).toList();
                                                },
                                                items: cityOptions
                                                    .map<DropdownMenuItem<String>>(
                                                        (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  );
                                                }).toList(),
                                              )),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin:
                                            EdgeInsets.only(bottom: 20,left: 5),
                                            child: IgnorePointer(
                                              ignoring: false,
                                              child: TextFormField(
                                                controller: pinCodeController,
                                                focusNode: _pinCodeFocusNode,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  WhitelistingTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Please enter your Mobile Number';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                style: TextStyle(
                                                    color: Constants.offWhiteColor),
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                                  contentPadding: new EdgeInsets.symmetric(vertical: 22.0, horizontal: 10.0),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.orange,
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2.0),
                                                  ),
                                                  counterText: '',
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Pincode',
                                                  labelStyle:
                                                  TextStyle(color: Colors.white),
                                                  hintStyle:
                                                  TextStyle(color: Colors.white),
                                                ),
                                                textInputAction: TextInputAction.next,
                                                onFieldSubmitted: (value) {
                                                  if (value.isNotEmpty) {
                                                    this.setState(() {
                                                      pinCodeController.text =
                                                          value.trim();
                                                    });
                                                    FocusScope.of(context).requestFocus(
                                                        _productTitleFocusNode);
                                                  }
                                                },
                                                onChanged: (value) {
//            model.validatePhone(value);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        color: Colors.orange,
                                        height: 40,
                                        width: 40,
                                        child: RaisedButton(
                                          color: Colors.blue[900],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          onPressed: () async {
//                        model.navigateToPhoneLoginScreen();

                                            if (_formKey.currentState
                                                .validate()) {
                                              print('true validated');
                                              model.saveAddress(
                                                {
                                                  "latitude": langitudeController.text.trim(),
                                                  "longitude": longitudeController.text.trim(),
                                                  "fullName": fullNameController.text.trim(),
                                                  "addressType": defaultDropdownAddressTypeValue.trim(),
                                                  "primaryAddress": mainAddressController.text.trim(),
                                                  "secondaryAddress": streetAddressController.text.trim(),
                                                  "landmark": landmarkController.text.trim(),
                                                  "mobileNumber": mobileNumberController.text.trim(),
                                                  "city": defaultDropdownCityValue.trim(),
                                                  "pincode": pinCodeController.text.trim()
                                                }
                                              );

                                            } else {
                                              setState(() {
                                                _autovalidate = true;
                                              });
                                            }
                                          },
                                          child: Container(
                                            child: Text(
                                              "Save",
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
//          backgroundColor: Colors.black,
              ),
        ),
        viewModelBuilder: () => EditAddressViewModel());
  }


}
