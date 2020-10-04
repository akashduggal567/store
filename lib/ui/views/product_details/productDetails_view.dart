import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/models/product.dart';
import 'productDetails_viewModel.dart';

class ProductDetailsView extends StatelessWidget {
  Product productDetails;
  ProductDetailsView({
    @required this.productDetails,
  });
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailsViewModel>.reactive(
        onModelReady: (model) => model.getCartCount(),
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  iconTheme: new IconThemeData(color: Color(0xff00ADB5)),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.search),
                      tooltip: 'Next page',
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                      ),
                      tooltip: 'Show Snackbar',
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Badge(
                          badgeColor: Constants.offWhiteColor,
                          badgeContent: Text(model.cartCount),
                          child: Icon(Icons.shopping_cart)),
                      tooltip: 'Next page',
                      onPressed: () {
                        model.navigateToCart();
                      },
                    ),
                  ],
                ),
                backgroundColor: Colors.black,
                body: Container(
                  color: Colors.black,
                  child: ListView(
                    children: <Widget>[
                      Hero(
                        tag: productDetails.id,
                        child: Container(
                            height: 400,
                            child:
                            CarouselSlider.builder(
                              itemCount: productDetails.images.length,
                              options: CarouselOptions(
                                aspectRatio: 1.0,
//                                enlargeCenterPage: true,
                                autoPlay: false,
                              ),
                              itemBuilder: (ctx, index) {
                                return Container(
                                  child:       productDetails.images?.length == 0 ? Padding(
                                    padding: const EdgeInsets.all(38.0),
                                    child: Center(child: SvgPicture.asset("assets/images/empty_photo_illustration.svg")),
                                  ):


                                  CachedNetworkImage(
                                    fit: BoxFit.fitHeight,
                                    imageUrl: productDetails.images[index],
                                    placeholder: (context, url) => CupertinoActivityIndicator(radius: 30,),
                                    errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.white,),
                                  ),
                                );
                              },
                            )


//                            productDetails.images?.length == 0 ? Padding(
//                              padding: const EdgeInsets.all(38.0),
//                              child: Center(child: SvgPicture.asset("assets/images/empty_photo_illustration.svg")),
//                            ):
//
//
//                            CachedNetworkImage(
//                                fit: BoxFit.fitHeight,
//                                imageUrl: productDetails.images[0],
//                                placeholder: (context, url) => CupertinoActivityIndicator(radius: 30,),
//                                errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.white,),
//                            )
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        color: Color(0xff222831),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(left: 4),
//                                      color: Colors.blueAccent,
                                      child: Row(
                                        textBaseline: TextBaseline.alphabetic,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
//                                            productDetails.brand,
                                          "config brand",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                color: Color(0xffEEEEEE)),
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          Flexible(
                                            child: Text(
                                              productDetails.title,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffEEEEEE)
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            productDetails.salePrice,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xffEEEEEE)),
                                          ),
                                          SizedBox(
                                            width: 14,
                                          ),
                                          Text(
                                            productDetails.retailPrice,
                                            style: TextStyle(
                                                fontSize: 11,
                                                decoration: TextDecoration
                                                    .lineThrough,
                                                color: Color(0xffEEEEEE)
                                                    .withOpacity(0.7)),
                                          ),
                                          SizedBox(
                                            width: 14,
                                          ),
                                          Container(
                                            child: Text(
                                              productDetails.discount + "%OFF",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xffEEEEEE)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            productDetails.inventoryCount > productDetails.minInventoryCount? Container() :
                            Flexible(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(right: 8),
                                padding: EdgeInsets.all(4.0),
                                child:       Text(
                                  'Few Left',
                                  style:
                                  TextStyle(fontSize: 14, color: Colors.red.withOpacity(0.9)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 34,
                        color: Color(0xff222831),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    children: <Widget>[
                                      Text(
                                        "Product Details",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              color: Constants.darkBlackColor,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
//                                  productDetails.description,
                                "config descripttion",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      wordSpacing: 5,
                                      color: Colors.white70),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 50,
                        color: Color(0xff222831),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: Icon(
                                  Icons.directions_bike,
                                  color: Colors.white,
                                  size: 24,
                                )),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                    child: Text(
                                  "Fast Delivery",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 10),
                                ))
                              ],
                            )),
                            Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: Icon(
                                  Icons.directions_bike,
                                  color: Colors.white,
                                  size: 24,
                                )),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                    child: Text(
                                  "Fast Delivery",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 10),
                                ))
                              ],
                            )),
                            Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: Icon(
                                  Icons.directions_bike,
                                  color: Colors.white,
                                  size: 24,
                                )),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                    child: Text(
                                  "Fast Delivery",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 10),
                                ))
                              ],
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: Row(
                                  textBaseline: TextBaseline.alphabetic,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  children: <Widget>[
                                    Text(
                                      "Other Variants",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Color(0xffEEEEEE)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: Container(
//        color: Color(0xff393E46),
                  height: 56,
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(4),
                          height: double.infinity,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0, color: const Color(0xff00ADB5))),
                          child: RaisedButton(
                            color: Colors.transparent,
                            splashColor: Color(0xff00ADB5),
                            onPressed: (){
                              model.addItemToCart(productDetails);
                            },
                            child: Text('Add To Cart',
                                style: TextStyle(
                                    fontSize: 16,
//                          fontWeight: FontWeight.w400,
                                    color: Color(0xffEEEEEE))),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(4),
                          height: double.infinity,
                          width: 100,
                          child: const RaisedButton(
                            disabledColor: Color(0xff00ADB5),
                            onPressed: null,
                            child: Text('Buy Now',
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xffEEEEEE))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => ProductDetailsViewModel());
  }
}
