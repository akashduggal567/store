import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'addresses_viewModel.dart';

class AddressesView extends StatefulWidget {
  @override
  _AddressesViewState createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddressesViewModel>.reactive(
        onModelReady: (model) => model.initialiseAllAddresses(),
        builder: (context, model, child) => Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                iconTheme: new IconThemeData(color: Color(0xff00ADB5)),
                title: Text("Addresses"),
                backgroundColor: Colors.black,
              ),
              backgroundColor: Colors.black,
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                      child: Container(
                        width: 190,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          height: 35,
                          disabledColor: Constants.tealColor.withOpacity(0.7),
                          color: Constants.lightTealColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.add),
                              Text('Add new Address',
                                  style: new TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
//                                onPressed: model.isPhoneValid
//                                    ? (){print("valid");}
//                                    : null,
                          onPressed: () {
//                        scaffoldKey.currentState.showBottomSheet(
//                                (context) => Container(
//                                  height: 100,
//                              color: Constants.lightBlackColor,
//                            ));
//                        print("pressed");
                            model.navigateToMapView();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: model.isBusy && model.addresses.length == 0
                          ? Center(
                              child: Text(
                              "Loading...",
                              style: TextStyle(color: Colors.white),
                            ))
                          : model.addresses.length == 0
                              ? Center(
                                  child: Text(
                                  "No addresses found",
                                  style:
                                      TextStyle(color: Constants.offWhiteColor),
                                ))
                              : Container(
                                  child: ListView.builder(
                                    itemCount: model.addresses.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _buildAddressCard(
                                        model: model,
                                        index: index,
                                      );
                                    },
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => AddressesViewModel());
  }
}

class openScrollableSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ExpandableBottomSheet(
      key: key,
      persistentContentHeight: 220,
    );
  }
}

class _buildAddressCard extends StatefulWidget {
  AddressesViewModel model;
  int index;
  _buildAddressCard({this.model, this.index});

  @override
  __buildAddressCardState createState() => __buildAddressCardState();
}

class __buildAddressCardState extends State<_buildAddressCard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print(widget.model.addresses[widget.index].id);
        },
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
                InkWell(
                  onTap: () {
                    widget.model.setAddressAsDefault(widget.model.addresses[widget.index].id, widget.index);
//
                  },
                  child: widget.model.isBusy && widget.model.selectedIndex[0] == widget.index ||
                          widget.model.addresses.length == 1 && widget.model.isBusy
                      ? Theme(
                          data: ThemeData(
                              cupertinoOverrideTheme: CupertinoThemeData(
                                  brightness: Brightness.dark)),
                          child: CupertinoActivityIndicator())
                      : Container(
                          child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor:
                                      Constants.offWhiteColor),
                              child: Container(
//                    color: Colors.red,
                                child: widget.model.selectedIndex.length == 0
                                    ? Text(
                                        "Set it as Default",
                                        style: TextStyle(
                                            color: Constants.offWhiteColor),
                                      )
                                    : widget.model.defaultIndex == widget.index
                                        ? Text(
                                            "Default",
                                            style: TextStyle(
                                                color: Constants
                                                    .lightDarkTealColor),
                                          )
                                        : Text(
                                          "Set it as Default",
                                          style: TextStyle(
                                              color: Constants
                                                  .offWhiteColor),
                                        ),
                              )),
                        ),
                ),
                Divider(
                  color: Constants.offWhiteColor,
                ),
                Expanded(
                  child: Container(
//                          color: Colors.pinkAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                              ),
                              Flexible(
                                child: Container(
//                                color: Colors.blue,
                                  height: 140,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.model.addresses[widget.index].addressType,
                                        style: TextStyle(
                                            color: Constants.offWhiteColor,
                                            fontSize: 20),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: <Widget>[
                                          Text(
                                            widget.model.addresses[widget.index].fullName,
                                            style: TextStyle(
                                                color: Constants.offWhiteColor,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          Text(
                                            "+91" +
                                                widget.model.addresses[widget.index]
                                                    .mobileNumber,
                                            style: TextStyle(
                                                color: Constants.offWhiteColor,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        widget.model.addresses[widget.index].primaryAddress +
                                            " " +
                                            widget.model.addresses[widget.index]
                                                .secondaryAddress,
                                        style: TextStyle(
                                            color: Constants.offWhiteColor),
                                      ),
                                      widget.model.addresses[widget.index].landmark == ''
                                          ? Text(
                                              "no landmark",
                                              style: TextStyle(
                                                  color:
                                                      Constants.offWhiteColor,
                                                  fontSize: 12),
                                            )
                                          : Text(
                                              "Landmark : " +
                                                  widget.model.addresses[widget.index]
                                                      .landmark,
                                              style: TextStyle(
                                                  color:
                                                      Constants.offWhiteColor,
                                                  fontSize: 14),
                                            ),
                                      Text(
                                        widget.model.addresses[widget.index].pincode +
                                            " , " +
                                            widget.model.addresses[widget.index].city,
                                        style: TextStyle(
                                            color: Constants.offWhiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 30,
//                          color: Colors.red,
                            height: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
//                                color: Colors.blue,
                                  child: InkWell(
                                    onTap: () {
                                      widget.model.deleteUserAddressById(
                                          widget.model.addresses[widget.index].id, widget.index);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Constants.offWhiteColor
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    widget.model.openEditAddressView(
                                        widget.model.addresses[widget.index]);
                                  },
                                  child: Icon(
                                    Icons.mode_edit,
                                    color: Constants.offWhiteColor
                                        .withOpacity(0.7),
                                  ),
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
    );
  }
}

class myBottomNavBar extends StatelessWidget {
  AddressesViewModel model;
  myBottomNavBar({
    this.model,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration:
          BoxDecoration(color: Constants.darkBlackColor, border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 30,
                    width: 40,
                    child: RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      onPressed: () {
//                        model.clearOrderCart();
                      },
                      child: Container(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 30,
                    width: 40,
                    child: RaisedButton(
                      color: Constants.tealColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      onPressed: () {
//                        model.navigateToPhoneLoginScreen();
                      },
                      child: Container(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
