import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/ui/views/wishlist/wishlist_viewModel.dart';

class WishListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WishListViewModel>.reactive(
      onModelReady: (model)=> model.initialiseWishlist(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Wishlist"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: model.wishListItemsList.length == 0 ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeIn(duration: Duration(seconds: 1),child: SvgPicture.asset('assets/images/wishlist_illustration.svg')),
              ):GridView.builder(
                  itemCount: model.wishListItemsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3.2 / 5,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return item(context, model,index);
                  }),
            )),
        viewModelBuilder: () => WishListViewModel());
  }
}

Widget item(BuildContext context,WishListViewModel model,int index) {
  return Stack(
    children: <Widget>[
      Container(
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
                            EdgeInsets.only(top: 2),
                            child:model.wishListItemsList[index].images?.length == 0 ? Padding(
                              padding: const EdgeInsets.all(38.0),
                              child: Center(child: SvgPicture.asset("assets/images/empty_photo_illustration.svg")),
                            ): CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl:  model
                                  .wishListItemsList[index]
                                  .images[0],
                              placeholder: (context, url) => CupertinoActivityIndicator(radius: 40,),
                              errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.white,),
                            ),
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
            Expanded(
              flex: 1,
              child: Container(
                color: Color(0xff393E46),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding:
                        const EdgeInsets
                            .all(8.0),
                        child: Container(
//                                            width: 120,
                          child:
                          model.wishListItemsList[index].inventoryCount==0 ? RaisedButton(
                            color: Constants.tealColor,
                            disabledColor:
                            Constants.darkBlackColor,
//                            onPressed: model.productsList[index].inventoryCount <= model.productsList[index].minInventoryCount ? null :(){
////                                                                     model.addItemToCart(
////                                                                        model.productsList[
////                                                                        index]);

//                            },
                            child: Text(
                                'Out Of Stock',
                                style: TextStyle(
                                    fontSize:
                                    12,
                                    color:
                                    Color(0xffEEEEEE))),
                          ) :  RaisedButton(
                            color: Constants.tealColor,
                            disabledColor:
                            Constants.darkBlackColor,
                            onPressed: (){

//                              model.addItemToCart(
//                                  model.productsList[
//                                  index]);

                            },
                            child: Text(
                                'Add To Cart',
                                style: TextStyle(
                                    fontSize:
                                    12,
                                    color:
                                    Color(0xffEEEEEE))),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding:
                        const EdgeInsets
                            .all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            model.removeFromWishlist(index: index,product: model.wishListItemsList[index]);
                          },
                          child: Container(
                            width: 80,
                            child: Icon(
                              Icons
                                  .cancel,
                              color: Color(
                                  0xff00ADB5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      Positioned(
//                                left: MediaQuery.of(context).size.width *0.29,
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