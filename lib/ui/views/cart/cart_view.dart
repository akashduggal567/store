import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'cart_viewModel.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
        builder: (context, model, child)=>Scaffold(
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Color(0xff00ADB5)),
            backgroundColor: Colors.black,
            title: Text("Cart"),
          ),
          backgroundColor: Colors.black,
          body: model.cartItemsList.length == 0
              ? Center(
            child: Text(
              "YOUR CART IS EMPTY",
              style: TextStyle(color: Constants.offWhiteColor),
            ),
          )
              : Container(
            margin: EdgeInsets.only(top: 4),
            child: Container(
              child: ListView(shrinkWrap: true, children: <Widget>[
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.cartItemsList.length,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          _cartItem(model),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                  child: Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Product Details",
                          style: TextStyle(
                              color: Constants.offWhiteColor, fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
//                      margin:
//                      const EdgeInsets.only(left: 4),
                        width: double.infinity,
//              color: Colors.blueAccent,
                        color: Constants.darkBlackColor,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
//                            height: 60,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
//                                    color: Constants.lightBlackColor,
                                            child: Text("TOTAL ITEMS",
                                                style: TextStyle(
                                                    color: Constants
                                                        .offWhiteColor,
                                                    fontWeight:
                                                    FontWeight.w400)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
//                                    color: Constants.lightBlackColor,
                                            child: Text(
                                              model.cartItemsList.length.toString(),
                                              style: TextStyle(
                                                  color: Constants
                                                      .offWhiteColor,
                                                  fontWeight:
                                                  FontWeight.w300),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
//                            height: 60,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
//                                    color: Constants.lightBlackColor,
                                            child: Text("Total Amount",
                                                style: TextStyle(
                                                    color: Constants
                                                        .offWhiteColor,
                                                    fontWeight:
                                                    FontWeight.w400)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
//                                    color: Constants.lightBlackColor,
                                            child: Text(
                                              "200",
                                              style: TextStyle(
                                                  color: Constants
                                                      .offWhiteColor,
                                                  fontWeight:
                                                  FontWeight.w300),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
//                            height: 60,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
//                                    color: Constants.lightBlackColor,
                                            child: Text("Coupon Discount",
                                                style: TextStyle(
                                                    color: Constants
                                                        .offWhiteColor,
                                                    fontWeight:
                                                    FontWeight.w400)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
//                                    color: Constants.lightBlackColor,
                                            child: Text(
                                              "- 30",
                                              style: TextStyle(
                                                  color:
                                                  Constants.tealColor,
                                                  fontWeight:
                                                  FontWeight.w300),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
//                            height: 60,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
//                                    color: Constants.lightBlackColor,
                                            child: Text("Discount",
                                                style: TextStyle(
                                                    color: Constants
                                                        .offWhiteColor,
                                                    fontWeight:
                                                    FontWeight.w400)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
//                                    color: Constants.lightBlackColor,
                                            child: Text(
                                              "- 50",
                                              style: TextStyle(
                                                  color:
                                                  Constants.tealColor,
                                                  fontWeight:
                                                  FontWeight.w300),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
//                            height: 60,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
//                                    color: Constants.lightBlackColor,
                                            child: Text("Delivery Charge",
                                                style: TextStyle(
                                                    color: Constants
                                                        .offWhiteColor,
                                                    fontWeight:
                                                    FontWeight.w400)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
//                                    color: Constants.lightBlackColor,
                                            child: Text(
                                              "30",
                                              style: TextStyle(
                                                  color: Constants
                                                      .offWhiteColor,
                                                  fontWeight:
                                                  FontWeight.w300),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Constants.darkBlackColor,
                      border: Border.all(
                          width: 0, color: Constants.offWhiteColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
//                            height: 60,
                      margin: EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
//                                    color: Constants.lightBlackColor,
                              child: Text("TOTAL",
                                  style: TextStyle(
                                      color: Constants.offWhiteColor,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ),
                          Expanded(
                            child: Container(
//                                    color: Constants.lightBlackColor,
                              child: Text(
                                "₹ 250",
                                style: TextStyle(
                                    color: Constants.offWhiteColor,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Constants.lightBlackColor,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: TextFormField(
                            style:
                            TextStyle(color: Constants.offWhiteColor),
                            autofocus: false,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                                hoverColor: Colors.black,
                                icon: Icon(
                                  Icons.tag_faces,
                                  color: Colors.white70,
                                ),
                                hintText: 'Apply Coupon',
                                hintStyle: TextStyle(color: Colors.white60)
//                    labelText: 'Name *',
                            ),
                            onSaved: (String value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                            },
                            validator: (String value) {
                              return value.contains('@')
                                  ? 'Do not use the @ char.'
                                  : null;
                            },
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "APPLY",
                            style: TextStyle(color: Constants.tealColor),
                          ),
                        )
//                    Text("APPLY")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
//                            height: 60,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
//                                    color: Constants.lightBlackColor,
                            child: Text("Items You Wish To Buy!",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Constants.offWhiteColor,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
//              color: Constants.darkBlackColor,
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.yellow,
                          height: 40,
                          width: 150,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: Color(0xff222831),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      colorFilter: new ColorFilter
                                                          .mode(
                                                          Color(0xffEEEEEE)
                                                              .withOpacity(
                                                              0.9),
                                                          BlendMode
                                                              .dstATop),
                                                      image: AssetImage(
                                                          "assets/images/shopping.png"))),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
//                           color: Colors.blueAccent,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(4.0),
                                                      child: Container(
                                                        margin:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 4),
//                                      color: Colors.blueAccent,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "Biotique",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15,
                                                                  color: Color(
                                                                      0xffEEEEEE)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Text(
                                                        "10% OFF",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xffEEEEEE)),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.yellow,
                          height: 40,
                          width: 150,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: Color(0xff222831),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      colorFilter: new ColorFilter
                                                          .mode(
                                                          Color(0xffEEEEEE)
                                                              .withOpacity(
                                                              0.9),
                                                          BlendMode
                                                              .dstATop),
                                                      image: AssetImage(
                                                          "assets/images/shopping.png"))),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
//                           color: Colors.blueAccent,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(4.0),
                                                      child: Container(
                                                        margin:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 4),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "Biotique",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15,
                                                                  color: Color(
                                                                      0xffEEEEEE)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Text(
                                                        "10% OFF",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xffEEEEEE)),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.yellow,
                          height: 40,
                          width: 150,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: Color(0xff222831),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      colorFilter: new ColorFilter
                                                          .mode(
                                                          Color(0xffEEEEEE)
                                                              .withOpacity(
                                                              0.9),
                                                          BlendMode
                                                              .dstATop),
                                                      image: AssetImage(
                                                          "assets/images/shopping.png"))),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
//                           color: Colors.blueAccent,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(4.0),
                                                      child: Container(
                                                        margin:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 4),
//                                      color: Colors.blueAccent,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "Biotique",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15,
                                                                  color: Color(
                                                                      0xffEEEEEE)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Text(
                                                        "10% OFF",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xffEEEEEE)),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.yellow,
                          height: 40,
                          width: 150,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: Color(0xff222831),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      colorFilter: new ColorFilter
                                                          .mode(
                                                          Color(0xffEEEEEE)
                                                              .withOpacity(
                                                              0.9),
                                                          BlendMode
                                                              .dstATop),
                                                      image: AssetImage(
                                                          "assets/images/shopping.png"))),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
//                           color: Colors.blueAccent,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(4.0),
                                                      child: Container(
                                                        margin:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 4),
//                                      color: Colors.blueAccent,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "Biotique",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15,
                                                                  color: Color(
                                                                      0xffEEEEEE)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Text(
                                                        "10% OFF",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xffEEEEEE)),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.yellow,
                          height: 40,
                          width: 150,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: Color(0xff222831),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      colorFilter: new ColorFilter
                                                          .mode(
                                                          Color(0xffEEEEEE)
                                                              .withOpacity(
                                                              0.9),
                                                          BlendMode
                                                              .dstATop),
                                                      image: AssetImage(
                                                          "assets/images/shopping.png"))),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(4.0),
                                                      child: Container(
                                                        margin:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 4),
//                                      color: Colors.blueAccent,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "Biotique",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15,
                                                                  color: Color(
                                                                      0xffEEEEEE)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Text(
                                                        "10% OFF",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xffEEEEEE)),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.yellow,
                          height: 40,
                          width: 150,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: Color(0xff222831),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      colorFilter: new ColorFilter
                                                          .mode(
                                                          Color(0xffEEEEEE)
                                                              .withOpacity(
                                                              0.9),
                                                          BlendMode
                                                              .dstATop),
                                                      image: AssetImage(
                                                          "assets/images/shopping.png"))),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(4.0),
                                                      child: Container(
                                                        margin:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 4),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "Biotique",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15,
                                                                  color: Color(
                                                                      0xffEEEEEE)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Text(
                                                        "10% OFF",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xffEEEEEE)),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.yellow,
                          height: 40,
                          width: 150,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: Color(0xff222831),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      colorFilter: new ColorFilter
                                                          .mode(
                                                          Color(0xffEEEEEE)
                                                              .withOpacity(
                                                              0.9),
                                                          BlendMode
                                                              .dstATop),
                                                      image: AssetImage(
                                                          "assets/images/shopping.png"))),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(4.0),
                                                      child: Container(
                                                        margin:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 4),
//                                      color: Colors.blueAccent,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <
                                                              Widget>[
                                                            Text(
                                                              "Biotique",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15,
                                                                  color: Color(
                                                                      0xffEEEEEE)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Text(
                                                        "10% OFF",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xffEEEEEE)),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                )
              ]),
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
                    margin: EdgeInsets.only(top: 8),
                    height: double.infinity,
                    width: 100,
                    child: Column(
                      children: <Widget>[
                        Text('You Saved',
                            style: TextStyle(
                                fontSize: 16,
//                          fontWeight: FontWeight.w400,
                                color: Color(0xffEEEEEE))),
                        Text('₹ 80',
                            style: TextStyle(
                                fontSize: 16,
//                          fontWeight: FontWeight.w400,
                                color: Color(0xffEEEEEE))),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
//                margin: EdgeInsets.all(4),
                    height: double.infinity,
                    width: 100,
                    child: RaisedButton(
                      elevation: 0,
                      color: Constants.tealColor,
                      onPressed: () {
//                        Router.navigator.pushNamed(
//                          Router.buyPage,
//                        );
                      },
                      child: Text('Proceed To Buy',
                          style:
                          TextStyle(fontSize: 18, color: Color(0xffEEEEEE))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        viewModelBuilder: ()=> CartViewModel());
  }
}


Widget _cartItem(CartViewModel model) {
  return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 140,
            decoration: BoxDecoration(
                color: Constants.darkBlackColor,
                border: Border.all(width: 0, color: Constants.offWhiteColor)),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
//                              color: Color(0xff222831),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              colorFilter: new ColorFilter.mode(
                                                  Color(0xffEEEEEE)
                                                      .withOpacity(0.9),
                                                  BlendMode.dstATop),
                                              image: AssetImage(
                                                  "assets/images/shopping.png"))),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
//                           color: Colors.blueAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                margin:
                                                const EdgeInsets.only(left: 4),
//                                      color: Colors.blueAccent,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Biotique",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color(0xffEEEEEE)),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      "Bhringraj Hair Oil",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          color: Color(0xffEEEEEE)
                                                              .withOpacity(0.7)),
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .baseline,
                                                        textBaseline:
                                                        TextBaseline.alphabetic,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                            "Rs 140",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xffEEEEEE)),
                                                          ),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            "Rs 140",
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                                color: Color(
                                                                    0xffEEEEEE)
                                                                    .withOpacity(
                                                                    0.7)),
                                                          ),
                                                          SizedBox(
                                                            width: 14,
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              "10% OFF",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0xffEEEEEE)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.baseline,
                                                    textBaseline:
                                                    TextBaseline.alphabetic,
                                                    children: <Widget>[
                                                      Text(
                                                        "Size",
                                                        style: TextStyle(
                                                            color: Constants
                                                                .offWhiteColor),
                                                      ),
                                                      DropdownButton<String>(
                                                        hint: Text(
                                                          "100ml",
                                                          style: TextStyle(
                                                            color: Colors.white70,
                                                          ),
                                                        ),
                                                        items: <String>[
                                                          '100ml',
                                                          '200ml',
                                                          '250ml',
                                                        ].map((String value) {
                                                          return new DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: new Text(
                                                              value,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (_) {},
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.add,
                                                        color: Color(0xff00ADB5),
                                                      ),
                                                      Text(
                                                        "0",
                                                        style: TextStyle(
                                                            color:
                                                            Color(0xffEEEEEE)),
                                                      ),
                                                      Icon(
                                                        Icons.remove,
                                                        color: Color(0xff00ADB5),
                                                      ),
                                                    ],
                                                  ),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              model.removeCartItem();
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 4,
                              ),
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0, color: Colors.redAccent)),
                              child: Center(
                                child: Text('Remove',
                                    style: TextStyle(
                                        fontSize: 14,
//                          fontWeight: FontWeight.w400,
                                        color: Color(0xffEEEEEE))),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 4),
                            height: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: Constants.tealColor)),
                            child: Center(
                              child: RaisedButton(
                                color: Constants.darkBlackColor,
                                onPressed: () {
                                  model.addToCart("2");
                                },
                                child: Text('Add to Wishlist',
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffEEEEEE))),
                              ),
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
          SizedBox(height: 10),
        ],
      ));
}
