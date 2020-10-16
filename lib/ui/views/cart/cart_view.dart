import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/helpers/debouncer.dart';
import 'package:store/models/product.dart';
import 'package:store/ui/views/wishlist/wishlist_viewModel.dart';
import 'cart_viewModel.dart';

class CartView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
//        onModelReady: (model)=>model.fetchWishListItems(),
        builder: (context, model, child)=>WillPopScope(
          onWillPop: (){
//            model.navigateToDashboard();
//            return Future.value(false);
            return Future.value(true);
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FadeIn(
                                    duration: Duration(seconds: 1),
                                    child: _cartItem(model,index, model.cartItemsList[index])
                                ),
                              ),
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
                      height: 270,
                      child:  model.wishListItemsList.length ==0 ? Center(
                        child: Text("No items in wishlist",style: TextStyle(color: Colors.white),),
                      ) : ListView.builder(
                          itemCount: model.wishListItemsList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext contex,int index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _wishlistItem(context, model, index)
                            );
                          })
                      ),
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
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
          color: Constants.lightBlackColor,width: 4
        ),
        borderRadius: BorderRadius.all(Radius.circular(20),)
    ),
    height: 150,
//              color: Constants.darkBlackColor,
    child: Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 0.7),
                      decoration: BoxDecoration(
                          border: Border.all(color: Constants.offWhiteColor,width: 0.1),
                          borderRadius: BorderRadius.only(topLeft:  Radius.circular(15),bottomLeft:  Radius.circular(15)),
                      ),
                  child: productDetails.images?.length != 0 ? CachedNetworkImage(
                              fit: BoxFit.fill,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft:  Radius.circular(15),bottomLeft:  Radius.circular(15)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    imageUrl: productDetails.images[0],
                    placeholder: (context, url) => CupertinoActivityIndicator(radius: 40,),
                    errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.white,),
                  ): Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: Center(child: SvgPicture.asset("assets/images/empty_photo_illustration.svg",fit: BoxFit.fitWidth,)),
                  )
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
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
                                                "\u20B9",
                                                style: TextStyle(color: Constants.offWhiteColor),
                                              ),
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
                                                "\u20B9",
                                                style: TextStyle(color: Constants.offWhiteColor, fontSize: 11),
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
                                                  productDetails.discount +"% OFF",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red[400],)
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
                                            model.cartItemsList[index].quantity.toString(),
                                            style: TextStyle(
                                                color:
                                                Color(0xffEEEEEE)),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              _debouncer.run(() => model.decreaseCartItemCount(productDetails));

                                            },
                                            child: model.cartItemsList[index].quantity == 1 ? Container() :Container(
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
                                      margin: EdgeInsets.only(left: 1,bottom: 0.5),
                                      decoration: BoxDecoration(
                                        color: Color(0xffCF6679).withOpacity(0.9),
                                      ),
                                      child: Center(
                                          child: Icon(Icons.delete, color: Colors.white.withOpacity(0.9),size: 16,)
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomRight:  Radius.circular(16)),
                                    ),
                                    child: SizedBox.expand(
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(bottomRight:  Radius.circular(16)),
                                        ),
                                        color: Constants.darkBlackColor,
                                        onPressed: () {
                                          model.addToWishList(id: model.cartItemsList[index].id,index: index);
                                        },
                                        child: Text('Add to Wishlist',
                                            style: TextStyle(
                                                fontSize: 12, color: Color(0xffEEEEEE))),
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
                ),
              ],
            ),
          ),
        ),

      ],
    ),
  );
}


Widget _wishlistItem(BuildContext context,CartViewModel model,int index) {
  return Stack(
    alignment: AlignmentDirectional.topEnd,  //https://stackoverflow.com/questions/56994946/flutter-stack-widget-not-sizing-correctly-when-used-in-a-listview
    children: <Widget>[
      Container(
        width: 180,
        color: Constants.darkBlackColor,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: InkWell(
                onTap: (){
                  model.navigateToProductDetailsView(
                      productDetails:
                      model.wishListItemsList[index]);
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Hero(
                          transitionOnUserGestures:
                          true,
                          tag: model
                              .wishListItemsList[
                          index]
                              .id,
                          child: Container(
                            margin:
                            EdgeInsets.only(top: 1),
                            child:model.wishListItemsList[index].images?.length == 0 ? Padding(
                              padding: const EdgeInsets.all(38.0),
                              child: Center(child: SvgPicture.asset("assets/images/empty_photo_illustration.svg")),
                            ): CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              imageUrl:  model
                                  .wishListItemsList[
                              index].images[0],
                              placeholder: (context, url) => CupertinoActivityIndicator(radius: 40,),
                              errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.white,),
                            )
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
//                           color: Colors.blueAccent,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceAround,
                            children: <
                                Widget>[
                              Expanded(
                                flex: 2,
                                child:
                                Padding(
                                  padding:
                                  const EdgeInsets.all(
                                      4.0),
                                  child:
                                  Container(
                                    margin: const EdgeInsets
                                        .only(
                                        left:
                                        4),
//                                      color: Colors.blueAccent,
                                    child:
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <
                                          Widget>[
                                        Text(
                                          'config brand',
//                                                                model
//                                                                    .productsList[
//                                                                        index]
//                                                                    .brand,
                                          style:
                                          TextStyle(fontSize: 15, color: Color(0xffEEEEEE)),
                                        ),
                                        Text(
                                          model.wishListItemsList[index].title,

                                          overflow:
                                          TextOverflow.ellipsis,
                                          style:
                                          TextStyle(fontSize: 12, color: Color(0xffEEEEEE).withOpacity(0.7)),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                          textBaseline:
                                          TextBaseline.alphabetic,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "\u20B9",
                                                  style: TextStyle(color: Constants.offWhiteColor),
                                                ),
                                                Text(
                                                  model.wishListItemsList[index].salePrice,

                                                  style: TextStyle(fontSize: 15, color: Color(0xffEEEEEE)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "\u20B9",
                                                  style: TextStyle(fontSize: 11, color: Constants.offWhiteColor),
                                                ),
                                                Text(
                                                  model.wishListItemsList[index].retailPrice,
                                                  style: TextStyle(fontSize: 11, decoration: TextDecoration.lineThrough, color: Color(0xffEEEEEE).withOpacity(0.7)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              model.wishListItemsList[index].inventoryCount > model.wishListItemsList[index].minInventoryCount

                                  ? Container()
                                  : Expanded(
                                flex: 1,
                                child:
                                Container(
                                  child:
                                  Text(
                                    'Few Left',
                                    style:
                                    TextStyle(fontSize: 14, color: Colors.red.withOpacity(0.9)),
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
//            Expanded(
//              flex: 1,
//              child: Container(
//                color: Color(0xff393E46),
//                child: Row(
//                  mainAxisAlignment:
//                  MainAxisAlignment
//                      .spaceEvenly,
//                  children: <Widget>[
//                    Expanded(
//                      flex: 2,
//                      child: Padding(
//                        padding:
//                        const EdgeInsets
//                            .all(8.0),
//                        child: Container(
////                                            width: 120,
//                          child:
//                          model.wishListItemsList[index].inventoryCount==0 ? RaisedButton(
//                            color: Constants.tealColor,
//                            disabledColor:
//                            Constants.darkBlackColor,
////                            onPressed: model.productsList[index].inventoryCount <= model.productsList[index].minInventoryCount ? null :(){
//////                                                                     model.addItemToCart(
//////                                                                        model.productsList[
//////                                                                        index]);
//
////                            },
//                            child: Text(
//                                'Out Of Stock',
//                                style: TextStyle(
//                                    fontSize:
//                                    12,
//                                    color:
//                                    Color(0xffEEEEEE))),
//                          ) :  RaisedButton(
//                            color: Constants.tealColor,
//                            disabledColor:
//                            Constants.darkBlackColor,
//                            onPressed: (){
//
////                              model.addItemToCart(
////                                  model.productsList[
////                                  index]);
//
//                            },
//                            child: Text(
//                                'Add To Cart',
//                                style: TextStyle(
//                                    fontSize:
//                                    12,
//                                    color:
//                                    Color(0xffEEEEEE))),
//                          ),
//                        ),
//                      ),
//                    ),
//                    Flexible(
//                      child: Padding(
//                        padding:
//                        const EdgeInsets
//                            .all(8.0),
//                        child: GestureDetector(
//                          onTap: (){
//                            model.removeFromWishlist(index: index,product: model.wishListItemsList[index]);
//                          },
//                          child: Container(
//                            width: 80,
//                            child: Icon(
//                              Icons
//                                  .cancel,
//                              color: Color(
//                                  0xff00ADB5),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            )
          ],
        ),
      ),
      Positioned(
        child: Container(
          alignment: Alignment.topRight,
          child: CustomPaint(
            painter: CurvePainter(),
            child: Container(
              height: 160,
              width: 60,
              padding:
              EdgeInsets.only(top: 10),
              child: Container(
//                                        color: Colors.red,
                margin: EdgeInsets.only(
                    left: 6),
                child: Text(
                  model.wishListItemsList[index]
                      .discount +
                      "% OFF",
                  textAlign:
                  TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(
                          context)
                          .size
                          .width /
                          MediaQuery.of(
                              context)
                              .size
                              .width *
                          14.0,
                      fontWeight:
                      FontWeight.w900,
                      color: Constants
                          .offWhiteColor),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}


class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green[800];
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(
        size.width / 20, size.height / 3, size.width, size.height * 0.4);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}