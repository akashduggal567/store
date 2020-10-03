import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/helpers/debouncer.dart';
import 'package:store/models/product.dart';
import 'cart_viewModel.dart';

class CartView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
        builder: (context, model, child)=>WillPopScope(
          onWillPop: (){
            model.navigateToDashboard();
            return Future.value(false);
          },
          child: Scaffold(
            appBar: AppBar(
              iconTheme: new IconThemeData(color: Color(0xff00ADB5)),
              backgroundColor: Colors.black,
              title: Text("Cart"),
            ),
            backgroundColor: Colors.black,
            body: model.cartItemsList.length == 0
                ? Center(
              child:  Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
//                        flex: 6,
                            child: FadeIn(
                                duration: Duration(seconds: 1),
                                child: Container(
                                    child: SvgPicture.asset('assets/images/empty_cart_illustration.svg'))),    //https://www.vecteezy.com/editor/random
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FadeIn(
                          duration: Duration(seconds: 2),
                          child: Container(
                          margin: EdgeInsets.only(bottom: 100),
                            height: 40,
                            width: 200,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 0,
                              color: Constants.tealColor,
                              onPressed: () {
                                model.navigateToDashboard();
                              },
                              child: Text('Start Shopping',
                                  style:
                                  TextStyle(fontSize: 18, color: Color(0xffEEEEEE))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            )
                : LoadingOverlay(
            isLoading: model.isBusy,
                  child: Container(
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
                              _cartItem(model,index, model.cartItemsList[index]),
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
                                                  model.cartTotalItemCount.toString(),
                                                  style: TextStyle(
                                                      color: Constants
                                                          .offWhiteColor,
                                                      fontWeight:
                                                      FontWeight.w400),
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
                                                  "₹ " +  model.totalCartAmount.toString(),
                                                  style: TextStyle(
                                                      color: Constants
                                                          .offWhiteColor,
                                                      fontWeight:
                                                      FontWeight.w400),
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
                                                  "- 0",
                                                  style: TextStyle(
                                                      color:
                                                      Constants.tealColor,
                                                      fontWeight:
                                                      FontWeight.w400),
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
                                                  "- " + "₹ " + model.totalDiscountAmount.toString(),
                                                  style: TextStyle(
                                                      color:
                                                      Constants.tealColor,
                                                      fontWeight:
                                                      FontWeight.w400),
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
                                                  "FREE",
                                                  style: TextStyle(
                                                      color: Constants
                                                          .offWhiteColor,
                                                      fontWeight:
                                                      FontWeight.w400),
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
                                    "₹ " + model.totalAmountPayable.toString(),
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
                ),
            bottomNavigationBar: model.cartItemsList.length != 0 ? Container(
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
                          Text('₹ '+ model.totalDiscountAmount.toString(),
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
                         model.navigateToSelectAddressView();
                        },
                        child: Text('Select Address',
                            style:
                            TextStyle(fontSize: 18, color: Color(0xffEEEEEE))),
                      ),
                    ),
                  ),
                ],
              ),
            ) : null,
          ),
        ),
        viewModelBuilder: ()=> CartViewModel());
  }
}


Widget _cartItem(CartViewModel model,int index, Product productDetails) {
  final _debouncer = Debouncer(milliseconds: 500);
  return InkWell(
    onTap: (){
    },
    child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 130,
              color: Constants.darkBlackColor,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
//                            child: CachedNetworkImage(
////                                        fit: BoxFit.,
////                              imageUrl: productDetails.thumbnailUrl,
//                            ),
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
                                    flex: 4,
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
                                              "config brand",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xffEEEEEE)),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              productDetails.title,
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
                                                    productDetails.salePrice,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(
                                                            0xffEEEEEE)),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    productDetails.retailPrice,
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
                                                      productDetails.discount +" OFF",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.red[400],)
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
//                                          color: Colors.red,
                                          margin: const EdgeInsets.only(
                                              left: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceAround,
                                            children: <Widget>[
                                              InkWell(
                                                onTap: (){
//
                                                  _debouncer.run(() =>  model.increaseCartItemCount(productDetails));
                                                },
                                                child: Container(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Color(0xff00ADB5),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                model.cartItemsList[index].cartQuantity.toString(),
                                                style: TextStyle(
                                                    color:
                                                    Color(0xffEEEEEE)),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  _debouncer.run(() => model.decreaseCartItemCount(productDetails));

                                                },
                                                child: model.cartItemsList[index].cartQuantity == 1 ? Container() :Container(
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Color(0xff00ADB5),
                                                  ),
                                                ),
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
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                model.removeCartItem(index,model.cartItemsList[index]);
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
                              child: SizedBox.expand(
                                child: RaisedButton(
                                  color: Constants.darkBlackColor,
                                  onPressed: () {
                                    model.addToWishList(id: model.cartItemsList[index].id);
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
        )),
  );
}
