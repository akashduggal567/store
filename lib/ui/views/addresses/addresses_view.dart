import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'addresses_viewModel.dart';

class AddressesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddressesViewModel>.nonReactive(
        builder: (context, model, child)=> Scaffold(
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Color(0xff00ADB5)),
            title: Text("Addresses"),
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.black,
          body: Container(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      height: 180,
                      color: Constants.darkBlackColor,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 4,
                          ),
                          Container(
//                        color: Colors.yellow,
                            child: Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Constants.offWhiteColor),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 30,
                                      height: 20,
                                      child: Checkbox(
                                          value: true,
                                          tristate: false,
                                          activeColor: Constants.tealColor,
                                          onChanged: (bool value) {}),
                                    ),
                                    Container(
                                      child: Text(
                                        "Set it as Default",
                                        style: TextStyle(
                                            color: Constants.offWhiteColor),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          Divider(
                            color: Constants.offWhiteColor,
                          ),
                          Expanded(
                            child: Container(
//                          color: Colors.pinkAccent,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Address Category",
                                            style: TextStyle(
                                                color: Constants.offWhiteColor,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            "Flat address ",
                                            style: TextStyle(
                                                color: Constants.offWhiteColor),
                                          ),
                                          Text(
                                            "Locality",
                                            style: TextStyle(
                                                color: Constants.offWhiteColor),
                                          ),
                                          Text(
                                            "City , State",
                                            style: TextStyle(
                                                color: Constants.offWhiteColor),
                                          ),
                                          Text(
                                            "Pincode, Country",
                                            style: TextStyle(
                                                color: Constants.offWhiteColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 30,
                                      height: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(
                                            Icons.delete,
                                            color: Constants.offWhiteColor
                                                .withOpacity(0.7),
                                          ),
                                          Icon(
                                            Icons.mode_edit,
                                            color: Constants.offWhiteColor
                                                .withOpacity(0.7),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          height: 150,
                          color: Constants.darkBlackColor,
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "HOME",
                                          style: TextStyle(
                                              color: Constants.offWhiteColor,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          "MIG-567, Backside Sethi Ice Cream",
                                          style: TextStyle(
                                              color: Constants.offWhiteColor
                                                  .withOpacity(0.7)),
                                        ),
                                        Text(
                                          "Jamalpur Colony, Chandigarh Road",
                                          style: TextStyle(
                                              color: Constants.offWhiteColor
                                                  .withOpacity(0.7)),
                                        ),
                                        Text(
                                          "Ludhiana , Punjab",
                                          style: TextStyle(
                                              color: Constants.offWhiteColor
                                                  .withOpacity(0.7)),
                                        ),
                                        Text(
                                          "141010, India",
                                          style: TextStyle(
                                              color: Constants.offWhiteColor
                                                  .withOpacity(0.7)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 30,
                                  height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(
                                        Icons.delete,
                                        color: Constants.offWhiteColor
                                            .withOpacity(0.8),
                                      ),
                                      Icon(
                                        Icons.mode_edit,
                                        color: Constants.offWhiteColor
                                            .withOpacity(0.8),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Constants.offWhiteColor),
                        child: Checkbox(
                            value: false,
                            tristate: false,
                            activeColor: Constants.tealColor,
                            onChanged: (bool value) {})),
                  ],
                ),
              ],
            ),
          ),
        ),
        viewModelBuilder: ()=> AddressesViewModel());
  }
}
