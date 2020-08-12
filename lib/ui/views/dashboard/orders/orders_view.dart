import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'orders_viewModel.dart';


class OrdersView extends StatefulWidget {
  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrdersViewModel>.nonReactive(
        builder: (context, model, child)=> Container(
          color: Colors.black,
          child: ListView(
            children: <Widget>[
              _buildOrderHistoryCard(),
              _buildOrderHistoryCard(),
            ],
          ),
        ),
        viewModelBuilder: ()=> OrdersViewModel());
  }
}

Widget _buildOrderHistoryCard() {
  String _index;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 140,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff222831),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        topRight: Radius.circular(3)),
                  ),
                  height: 38,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          "Delivered On ",
                          style:
                          TextStyle(color: Color(0xffEEEEEE), fontSize: 18),
                        ),
                        Text(
                          "13 March 2020",
                          style:
                          TextStyle(color: Color(0xffEEEEEE), fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff393E46),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
//                            color: Colors.grey,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Order Number : 142627",
                                        style: TextStyle(
                                            color: Color(0xffEEEEEE), fontSize: 11),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Total Items : 4 ",
                                            style: TextStyle(
                                                color: Color(0xffEEEEEE), fontSize: 11),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "Total Amount : ₹ 500 ",
                                            style: TextStyle(
                                                color: Color(0xffEEEEEE), fontSize: 11),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Bringraj Oil",
                                        style: TextStyle(
                                            color: Color(0xffEEEEEE), fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          Expanded(
                              child: Container(
//                        color: Colors.redAccent,
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 45,
                                  color: Color(0xD9EEEEEE),
                                ),
                              )),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        border:
                        Border.all(width: 1.0, color: Constants.lightBlackColor)),
                    child:  RaisedButton(
                      disabledColor: Colors.transparent,
                      color: Constants.darkBlackColor,
                      splashColor: Constants.lightBlackColor,
                      onPressed: (){
                        print("clicked");
                      },
                      child: Text('View Invoice',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffEEEEEE))),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        border:
                        Border.all(width: 1.0, color: Constants.lightBlackColor)),
                    child:  RaisedButton(
                      disabledColor: Colors.transparent,
                      color: Constants.darkBlackColor,
                      splashColor: Constants.lightBlackColor,
                      onPressed:(){
                        print("clicked");
                      },
                      child: Text('Order Details',
                          style: TextStyle(fontSize: 16, color: Color(0xffEEEEEE))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Constants.darkBlackColor,
            child: ExpansionTile(
                title: Text(
                  'Track Order',
                  style: TextStyle(color: Constants.offWhiteColor),
                ),
                children: <Widget>[
                  Container(
                    color: Constants.lightBlackColor,
                    child: Theme(
                      data: ThemeData(primaryColor: Constants.tealColor),
                      child: Stepper(
                        steps: [
                          Step(
                            title: Text(
                              "Order Placed",
                              style: TextStyle(color: Constants.offWhiteColor),
                            ),
                            content: Text("The order has been placed!",
                                style: TextStyle(
                                    color: Constants.offWhiteColor
                                        .withOpacity(0.7))),
                          ),
                          Step(
                            title: Text("Packed",
                                style: TextStyle(color: Constants.offWhiteColor)),
                            content: Text(
                                "The order has been packed and ready to be delivered",
                                style: TextStyle(
                                    color: Constants.offWhiteColor
                                        .withOpacity(0.7))),
                          ),
                          Step(
                            isActive: true,
                            title: Text("Out For Delivery",
                                style: TextStyle(color: Constants.offWhiteColor)),
                            content: Text(
                                "Our delivery partner will reach to you any minute soon.",
                                style: TextStyle(
                                    color: Constants.offWhiteColor
                                        .withOpacity(0.7))),
                          ),
                          Step(
                            title: Text("Delivered",
                                style: TextStyle(color: Constants.offWhiteColor)),
                            content: Text(
                                "The order has been delivered successfully. Thanks for your purchase!",
                                style: TextStyle(
                                    color: Constants.offWhiteColor
                                        .withOpacity(0.7))),
                          ),
                        ],
                        currentStep: 2,
                        onStepTapped: (index) {
                          setState() {
                            _index = 2.toString();
                          }
                        },
                        controlsBuilder: (BuildContext context,
                            {VoidCallback onStepContinue,
                              VoidCallback onStepCancel}) =>
                            Container(),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    ),
  );
}

