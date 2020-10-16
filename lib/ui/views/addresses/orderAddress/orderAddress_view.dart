import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/ui/views/addresses/orderAddress/orderAddress_viewModel.dart';

class OrderAddressView extends StatelessWidget {
  double totalAmountPayable;

  OrderAddressView({
    this.totalAmountPayable
  });
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderAddressViewModel>.reactive(
      onModelReady:  (model) => model.initialise(),
        builder: (context,model,child)=> Scaffold(
          appBar: AppBar(
            title: Text("Select Address"),
          ),
          body: model.isBusy? CupertinoActivityIndicator():  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Default Address",style: TextStyle(color: Colors.white),),
                _buildDefaultAddressCard(model),
                Text("Other Addresses",style: TextStyle(color: Colors.white),),
                _buildOtherAddressCard(model),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 56,
            color: Constants.lightBlackColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
//                margin: EdgeInsets.all(4),
                    height: double.infinity,
                    width: 100,
                    child: RaisedButton(
                      elevation: 0,
                      color: Constants.tealColor,
                      onPressed: () {
                        model.navigateToPaymentOptionView(totalAmountPayable);
                      },
                      child: Text('Proceed to Pay',
                          style:
                          TextStyle(fontSize: 18, color: Color(0xffEEEEEE))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        viewModelBuilder: () => OrderAddressViewModel());
  }
}



Widget _buildDefaultAddressCard(OrderAddressViewModel model){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      color: Constants.darkBlackColor,
      child: Container(
        height: 180,
        child: Container(
//                          color: Colors.pinkAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
//                                color: Colors.blue,
//                        height: 140,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
//                                color: Colors.red,
                              child: Checkbox(
                                tristate: true,
                                value: model.selectedAddressMap[model.defaultAddress.id] ?? false,
                                onChanged: (val){
                                  model.updateSelectedAddress(model.defaultAddress.id);
                                },
                              ),
                            ),
                            Container(
//                                color: Colors.yellow,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    model.defaultAddress.addressType,
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
                                        model.defaultAddress.fullName,
                                        style: TextStyle(
                                            color: Constants.offWhiteColor,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 18,
                                      ),
                                      Text(
                                        "+91" +
                                            model.defaultAddress
                                                .mobileNumber,
                                        style: TextStyle(
                                            color: Constants.offWhiteColor,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    model.defaultAddress.primaryAddress +
                                        " " +
                                        model.defaultAddress
                                            .secondaryAddress,
                                    style: TextStyle(
                                        color: Constants.offWhiteColor),
                                  ),
                                 model.defaultAddress.landmark == ''
                                      ? Text(
                                    "no landmark",
                                    style: TextStyle(
                                        color:
                                        Constants.offWhiteColor,
                                        fontSize: 12),
                                  )
                                      : Text(
                                    "Landmark : " +
                                        model.defaultAddress
                                            .landmark,
                                    style: TextStyle(
                                        color:
                                        Constants.offWhiteColor,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    model.defaultAddress.pincode +
                                        " , " +
                                        model.defaultAddress.city,
                                    style: TextStyle(
                                        color: Constants.offWhiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
Widget _buildOtherAddressCard(OrderAddressViewModel model){
  return Flexible(
    child: Container(
      child: ListView.builder(
        itemCount: model.otherAddresses.length,
        itemBuilder: (BuildContext context , int index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Constants.darkBlackColor,
              child: Container(
                height: 180,
                child: Container(
//                          color: Colors.pinkAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Container(
//                                color: Colors.blue,
//                        height: 140,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
//                                color: Colors.red,
                                      child: Checkbox(
                                        value: model.selectedAddressMap[model.otherAddresses[index].id],
                                        onChanged: (val){

                                          model.updateSelectedAddress(model.otherAddresses[index].id);
                                        },
                                      ),
                                    ),
                                    Container(
//                                color: Colors.yellow,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            model.otherAddresses[index].addressType,
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
                                            model.otherAddresses[index].fullName,
                                            style: TextStyle(
                                                color: Constants.offWhiteColor,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          Text(
                                            "+91" +
                                                model.otherAddresses[index]
                                                    .mobileNumber,
                                            style: TextStyle(
                                                color: Constants.offWhiteColor,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        model.otherAddresses[index].primaryAddress +
                                            " "+
                                            model.otherAddresses[index].secondaryAddress
                                            ,
                                        style: TextStyle(
                                            color: Constants.offWhiteColor),
                                      ),
                                      model.otherAddresses[index].landmark == ''
                                          ? Text(
                                        "no landmark",
                                        style: TextStyle(
                                            color:
                                            Constants.offWhiteColor,
                                            fontSize: 12),
                                      )
                                          : Text(
                                        "Landmark : " +
                                            model.otherAddresses[index]
                                                .landmark,
                                        style: TextStyle(
                                            color:
                                            Constants.offWhiteColor,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        model.otherAddresses[index].pincode +
                                            " , " +
                                            model.otherAddresses[index].city,
                                        style: TextStyle(
                                            color: Constants.offWhiteColor),
                                      ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    ),
  );
}