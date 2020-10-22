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
    return ViewModelBuilder<OrdersViewModel>.reactive(
        onModelReady: (model) => model.fetchOrders(),
        builder: (context, model, child) => Container(
              color: Colors.black,
              child: ListView.builder(
                itemCount: model.orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildOrderHistoryCard(model: model, index: index);
                },
              ),
            ),
        viewModelBuilder: () => OrdersViewModel());
  }
}

Widget _buildOrderHistoryCard({OrdersViewModel model, int index}) {
  String _index;
  return Padding(
    padding:
        const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
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
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
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
                                    "Order Number : " +
                                        model.orders[index].orderNumber
                                            .toString(),
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
                                            color: Color(0xffEEEEEE),
                                            fontSize: 11),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Total Amount : ₹ 500 ",
                                        style: TextStyle(
                                            color: Color(0xffEEEEEE),
                                            fontSize: 11),
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
                        border: Border.all(
                            width: 1.0, color: Constants.lightBlackColor)),
                    child: RaisedButton(
                      disabledColor: Colors.transparent,
                      color: Constants.darkBlackColor,
                      splashColor: Constants.lightBlackColor,
                      elevation: 0,
                      onPressed: () {
                        model.openPdfView(
                            pdfUrl: model.orders[index].invoiceUrl);
                      },
                      child: Text('View Invoice',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xffEEEEEE))),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0, color: Constants.lightBlackColor)),
                    child: RaisedButton(
                      disabledColor: Colors.transparent,
                      color: Constants.darkBlackColor,
                      splashColor: Constants.lightBlackColor,
                      elevation: 0,
                      onPressed: () {
                        print("clicked");
                      },
                      child: Text('Order Details',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xffEEEEEE))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          model.orders[index].status == Constants.ORDER_STATUS_DELIEVERED
              ? Container()
              : Container(
                  decoration: BoxDecoration(
                    color: Constants.darkBlackColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                  ),
                  child: ExpansionTile(
                      title: Text(
                        'Track Order',
                        style: TextStyle(color: Constants.offWhiteColor),
                      ),
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Constants.lightBlackColor.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8)),
                          ),
                          child: Theme(
                            data: ThemeData(primaryColor: Constants.tealColor),
                            child: model.orders[index].status ==
                                    Constants.ORDER_STATUS_CANCELLED
                                ? Stepper(
                                    steps: [
                                      Step(
                                        isActive: model.orders[index].status ==
                                            Constants.ORDER_STATUS_CANCELLED,
                                        title: Text(
                                          "Order was Cancelled",
                                          style: TextStyle(
                                              color: Constants.offWhiteColor),
                                        ),
                                        content: Text("",
                                            style: TextStyle(
                                                color: Constants.offWhiteColor
                                                    .withOpacity(0.7))),
                                      ),
                                    ],
                                    currentStep: 0,
                                    controlsBuilder: (BuildContext context,
                                            {VoidCallback onStepContinue,
                                            VoidCallback onStepCancel}) =>
                                        Container(),
                                  )
                                : Stepper(
                                    steps: [
                                      Step(
                                        isActive: model.orders[index].status ==
                                            Constants.ORDER_STATUS_PLACED,
                                        title: Text(
                                          "Order Placed",
                                          style: TextStyle(
                                              color: Constants.offWhiteColor),
                                        ),
                                        content: Text(
                                            "The order has been placed!",
                                            style: TextStyle(
                                                color: Constants.offWhiteColor
                                                    .withOpacity(0.8))),
                                      ),
                                      Step(
                                        isActive: model.orders[index].status ==
                                            Constants.ORDER_STATUS_PACKED,
                                        title: Text("Packed",
                                            style: TextStyle(
                                                color:
                                                    Constants.offWhiteColor)),
                                        content: Text(
                                            "The order has been packed and ready to be delivered",
                                            style: TextStyle(
                                                color: Constants.offWhiteColor
                                                    .withOpacity(0.8))),
                                      ),
                                      Step(
                                        isActive: model.orders[index].status ==
                                            Constants.ORDER_STATUS_TRANSIT,
                                        title: Text("Out For Delivery",
                                            style: TextStyle(
                                                color:
                                                    Constants.offWhiteColor)),
                                        content: Text(
                                            "Our delivery partner will reach to you any minute soon.",
                                            style: TextStyle(
                                                color: Constants.offWhiteColor
                                                    .withOpacity(0.8))),
                                      ),
                                      Step(
                                        isActive: model.orders[index].status ==
                                            Constants.ORDER_STATUS_DELIEVERED,
                                        title: Text("Delivered",
                                            style: TextStyle(
                                                color:
                                                    Constants.offWhiteColor)),
                                        content: Text(
                                            "The order has been delivered successfully. Thanks for your purchase!",
                                            style: TextStyle(
                                                color: Constants.offWhiteColor
                                                    .withOpacity(0.8))),
                                      ),
                                    ],
                                    currentStep:
                                        selectStep(model.orders[index].status),
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

int selectStep(orderStatus) {
  switch (orderStatus) {
    case Constants.ORDER_STATUS_PLACED:
      {
        return 0;
      }
      break;

    case Constants.ORDER_STATUS_PACKED:
      {
        return 1;
      }
      break;

    case Constants.ORDER_STATUS_TRANSIT:
      {
        return 2;
      }
      break;

    case Constants.ORDER_STATUS_DELIEVERED:
      {
        return 3;
      }
      break;

    default:
      {
        return 0;
      }
      break;
  }
}
