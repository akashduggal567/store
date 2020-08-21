import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
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
        builder: (context, model, child)=> Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Color(0xff00ADB5)),
            title: Text("Addresses"),
            backgroundColor: Colors.black,
          ),
          bottomNavigationBar: myBottomNavBar(),
          backgroundColor: Colors.black,
          body: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                  EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: Container(
                    width: 190,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(22.0)),
                      height: 35,
                      disabledColor:
                      Constants.tealColor.withOpacity(0.7),
                      color: Constants.lightTealColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.add),
                          Text('Add new Address',
                              style: new TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                              )),
                        ],
                      ),
//                                onPressed: model.isPhoneValid
//                                    ? (){print("valid");}
//                                    : null,
                      onPressed: (){
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
                  child: Container(
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index){
                        return _buildAddressCard(model: model,index: index,);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        viewModelBuilder: ()=> AddressesViewModel());
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


class _buildAddressCard extends StatelessWidget{
  AddressesViewModel model;
  int index;
  _buildAddressCard({
    this.model,
    this.index
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
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
              InkWell(
                onTap: (){
                  model.selectedIndex.clear();
                  model.setSelectedIndex(index);
                },
                child: Container(
                  child: Theme(
                      data: ThemeData(
                          unselectedWidgetColor: Constants.offWhiteColor),
                      child: Container(
//                    color: Colors.red,
                        child: model.selectedIndex[0]== index? Text(
                          "Default",
                          style: TextStyle(
                              color: Constants.lightDarkTealColor),
                        ) : Text(
                          "Set it as Default",
                          style: TextStyle(
                              color: Constants.offWhiteColor),
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
      height: MediaQuery.of(context).size.height * 0.05,
      decoration:
      BoxDecoration(
          color: Constants.darkBlackColor,
          border: Border.all()),
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