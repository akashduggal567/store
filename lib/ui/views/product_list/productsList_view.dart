import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/ui/widgets/creation_aware_list_item.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'productsList_viewModel.dart';

class ProductsListView extends StatefulWidget {
  ScrollController scrollController;
  List tagsArray;
  ProductsListView({
    this.tagsArray
   }) {
    this.scrollController = new ScrollController(initialScrollOffset: 0.0);


  }

  @override
  _ProductsListViewState createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  int itemBuildIndex = -1;
  ScrollController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();

  }
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsListViewModel>.reactive(
        onModelReady: (model) => {
          model.updateTagsArray(widget.tagsArray),
          model.fetchProducts(widget.tagsArray, null,null)},
        builder: (context, model, child) => model.isBusy
            ? Scaffold(
                appBar: AppBar(
                  title: Text("Men"),
                  backgroundColor: Colors.black,
                  iconTheme: new IconThemeData(color: Constants.tealColor),
                ),
                body: GridView.builder(
                    itemCount: 6,
                    padding: const EdgeInsets.all(20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 5),
                    itemBuilder: (context, int index) {
                      return Shimmer.fromColors(
                          baseColor: Colors.black,
                          highlightColor: Constants.lightBlackColor,
                          enabled: true,
                          child: Container(
                            color: Colors.white,
                          ));
                    }),
              )
            : Scaffold(
                floatingActionButton: Container(
//                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/1.37,right: MediaQuery.of(context).size.width/3 ),
                  height: 40,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      print("pressed");
                      controller.animateTo(3,duration: Duration(milliseconds: 500),curve: Curves.bounceIn);
                    },
                    focusColor: Constants.tealColor,
                    backgroundColor: Constants.tealColor.withOpacity(0.7),
                    icon: Icon(Icons.arrow_upward),
                    label: Text((model.itemBuildIndex+1).toString() + '/' + model.totalProducts.toString()),
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
                bottomNavigationBar: Container(
                  height: 40,
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
                            color: Constants.lightBlackColor,
                            onPressed: () {
//                                model.navigateToSelectAddressView();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.filter_list, color: Constants.offWhiteColor,),
                                SizedBox(width: 10,),
                                Text('Filter',
                                    style:
                                    TextStyle(fontSize: 18, color: Color(0xffEEEEEE))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          width: 100,
                          child: RaisedButton(
                            elevation: 0,
                            color: Constants.lightBlackColor,
                            onPressed: () {
                              model.openSortBottomSheet();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.sort, color: Constants.offWhiteColor,),
                                SizedBox(width: 10,),
                                Text('Sort',
                                    style:
                                    TextStyle(fontSize: 18, color: Color(0xffEEEEEE))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
             appBar: new AppBar(
              iconTheme: new IconThemeData(color: Color(0xff00ADB5)),
              backgroundColor: Colors.black,
              title: Text("Home"),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                  ),
                  tooltip: 'Show Snackbar',
                  onPressed: () {
//                    model.navigateToWishlist();
                  },
                ),
                IconButton(
                  icon: Badge(
                    badgeContent: Text(model.cartCount),
//                    badgeContent: Text('2'),
                    animationType: BadgeAnimationType.slide,
                    badgeColor: Constants.offWhiteColor,
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                  tooltip: 'Show Snackbar',
                  onPressed: () {
                    model.navigateToCart();
                  },
                ),

              ],
            ),
              backgroundColor: Colors.black,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  controller: controller,
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              MediaQuery.of(context).size.height*1.1),
                      delegate: SliverChildBuilderDelegate((context, int index) {
                        return  VisibilityDetector(
                          key: Key('$index'),
                          onVisibilityChanged: (visibilityInfo) {
                            print(index);
                            model.itemBuildIndex = index;

                          },
                          child: CreationAwareListItem(
                            itemCreated: (){
                              int indexd = index-2;
//                              print('Item created at $indexd');
                              SchedulerBinding.instance.addPostFrameCallback(
                                      (duration) => model.handleItemCreated(index));
                            },
                            child: InkWell(
                              onTap: () {
                                model.navigateToProductDetailsView(
                                    productDetails: model.productsList[index]);
                              },
                              child:  Stack(
                                children: <Widget>[
                                  Container(
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
                                                  child: Hero(
                                                    transitionOnUserGestures: true,
                                                    tag: model.productsList[index].id,
                                                    child: Container(
//                                                  margin:
//                                                      EdgeInsets.only(top: 2),
//                                                  child: CachedNetworkImage(
//                                                    fit: BoxFit.fitHeight,
//                                                    imageUrl: model
//                                                        .productsList[index]
//                                                        .thumbnailUrl,
////                                            placeholder: (context, url) => CupertinoActivityIndicator(radius: 40,),
////                                            errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.white,),
//                                                  ),
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
                                                                children: <Widget>[
                                                                  Text(
                                                                    'config brand',
//                                                                model
//                                                                    .productsList[
//                                                                        index]
//                                                                    .brand,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        15,
                                                                        color: Color(
                                                                            0xffEEEEEE)),
                                                                  ),
                                                                  Text(
                                                                    model
                                                                        .productsList[
                                                                    index]
                                                                        .title,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        12,
                                                                        color: Color(
                                                                            0xffEEEEEE)
                                                                            .withOpacity(
                                                                            0.7)),
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .baseline,
                                                                    textBaseline:
                                                                    TextBaseline
                                                                        .alphabetic,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        children: <Widget>[
                                                                          Text("\u20B9",style: TextStyle(
                                                                              color: Constants.offWhiteColor
                                                                          ),),
                                                                          Text(
                                                                            model
                                                                                .productsList[
                                                                            index]
                                                                                .salePrice,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15,
                                                                                color: Color(
                                                                                    0xffEEEEEE)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        width: 10,
                                                                      ),
                                                                      Row(
                                                                        children: <Widget>[
                                                                          Text("\u20B9",style: TextStyle(
                                                                              fontSize: 11,
                                                                              color: Constants.offWhiteColor
                                                                          ),),
                                                                          Text(
                                                                            model
                                                                                .productsList[
                                                                            index]
                                                                                .retailPrice,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                11,
                                                                                decoration:
                                                                                TextDecoration
                                                                                    .lineThrough,
                                                                                color: Color(0xffEEEEEE)
                                                                                    .withOpacity(0.7)),
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
//                                                    Expanded(
//                                                      flex: 1,
//                                                      child: Container(
//                                                        child: Text(
//                                                          model
//                                                                  .productsList[
//                                                                      index]
//                                                                  .discount +
//                                                              " OFF",
//                                                          style: TextStyle(
//                                                              fontSize: 14,
//                                                              color: Color(
//                                                                  0xffEEEEEE)),
//                                                        ),
//                                                      ),
//                                                    ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: Color(0xff393E46),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        model.addItemToCart(model
                                                            .productsList[index]);
                                                      },
                                                      child: Container(
//                                            width: 120,
                                                        child: const RaisedButton(
                                                          disabledColor:
                                                          Color(0xff00ADB5),
                                                          onPressed: null,
                                                          child: Text('Add To Cart',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0xffEEEEEE))),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      width: 80,
                                                      child: Icon(
                                                        Icons.favorite_border,
                                                        color: Color(0xff00ADB5),
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
//                                      decoration: BoxDecoration(
//                                        gradient: LinearGradient(
//                                          begin: Alignment.topLeft,
//                                          end: Alignment.topRight,
//                                          colors: [
//                                            Colors.red[500],
//                                            Colors.red[300]
//                                          ],
//                                        ),
//                                      ),
                                          padding: EdgeInsets.only(top: 10),
                                          child: Container(
//                                        color: Colors.red,
                                            margin: EdgeInsets.only(left: 6),
                                            child: Text(
                                              model.productsList[index].discount +
                                                  "% OFF",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width/ MediaQuery.of(context).size.width * 14.0,
                                                  fontWeight: FontWeight.w900,
                                                  color: Constants.offWhiteColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: model.productsList.length
                      ),
                    ),
                    model.isLoadingMore ? new SliverToBoxAdapter(
                      child: CupertinoActivityIndicator(radius: 24,),
                    ) :  new SliverToBoxAdapter(
                      child: Container(),
                    ),
                  ],
                ),
              )

//
//                  GridView.builder(
//                    itemCount: model.productsList.length,
//                    controller: widget.scrollController,
//                    padding: const EdgeInsets.all(20),
//                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                        crossAxisCount: 2,
//                        crossAxisSpacing: 10,
//                        mainAxisSpacing: 10,
//                        childAspectRatio: MediaQuery.of(context).size.width /
//                            MediaQuery.of(context).size.height*1.1),
//                    itemBuilder: (context, int index) {
//                      return CreationAwareListItem(
//                        itemCreated: (){
//                          print('Item created at $index');
//                          SchedulerBinding.instance.addPostFrameCallback(
//                                  (duration) => model.handleItemCreated(index));
//                        },
//                        child: InkWell(
//                          onTap: () {
//                            model.navigateToProductDetailsView(
//                                productDetails: model.productsList[index]);
//                          },
//                          child: Stack(
//                            children: <Widget>[
//                              Container(
//                                color: Color(0xff222831),
//                                child: Column(
//                                  children: <Widget>[
//                                    Expanded(
//                                      flex: 5,
//                                      child: Container(
//                                        child: Column(
//                                          children: <Widget>[
//                                            Expanded(
//                                              flex: 3,
//                                              child: Hero(
//                                                transitionOnUserGestures: true,
//                                                tag: model.productsList[index].id,
//                                                child: Container(
////                                                  margin:
////                                                      EdgeInsets.only(top: 2),
////                                                  child: CachedNetworkImage(
////                                                    fit: BoxFit.fitHeight,
////                                                    imageUrl: model
////                                                        .productsList[index]
////                                                        .thumbnailUrl,
//////                                            placeholder: (context, url) => CupertinoActivityIndicator(radius: 40,),
//////                                            errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.white,),
////                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                            Expanded(
//                                              flex: 1,
//                                              child: Container(
////                           color: Colors.blueAccent,
//                                                child: Row(
//                                                  mainAxisAlignment:
//                                                      MainAxisAlignment
//                                                          .spaceAround,
//                                                  children: <Widget>[
//                                                    Expanded(
//                                                      flex: 2,
//                                                      child: Padding(
//                                                        padding:
//                                                            const EdgeInsets
//                                                                .all(4.0),
//                                                        child: Container(
//                                                          margin:
//                                                              const EdgeInsets
//                                                                      .only(
//                                                                  left: 4),
////                                      color: Colors.blueAccent,
//                                                          child: Column(
//                                                            mainAxisAlignment:
//                                                                MainAxisAlignment
//                                                                    .spaceAround,
//                                                            crossAxisAlignment:
//                                                                CrossAxisAlignment
//                                                                    .start,
//                                                            children: <Widget>[
//                                                              Text(
//                                                            'config brand',
////                                                                model
////                                                                    .productsList[
////                                                                        index]
////                                                                    .brand,
//                                                                style: TextStyle(
//                                                                    fontSize:
//                                                                        15,
//                                                                    color: Color(
//                                                                        0xffEEEEEE)),
//                                                              ),
//                                                              Text(
//                                                                model
//                                                                    .productsList[
//                                                                        index]
//                                                                    .title,
//                                                                overflow:
//                                                                    TextOverflow
//                                                                        .ellipsis,
//                                                                style: TextStyle(
//                                                                    fontSize:
//                                                                        12,
//                                                                    color: Color(
//                                                                            0xffEEEEEE)
//                                                                        .withOpacity(
//                                                                            0.7)),
//                                                              ),
//                                                              Row(
//                                                                crossAxisAlignment:
//                                                                    CrossAxisAlignment
//                                                                        .baseline,
//                                                                textBaseline:
//                                                                    TextBaseline
//                                                                        .alphabetic,
//                                                                mainAxisAlignment:
//                                                                    MainAxisAlignment
//                                                                        .start,
//                                                                children: <
//                                                                    Widget>[
//                                                                  Row(
//                                                                    children: <Widget>[
//                                                                      Text("\u20B9",style: TextStyle(
//                                                                        color: Constants.offWhiteColor
//                                                                      ),),
//                                                                      Text(
//                                                                        model
//                                                                            .productsList[
//                                                                        index]
//                                                                            .salePrice,
//                                                                        style: TextStyle(
//                                                                            fontSize:
//                                                                            15,
//                                                                            color: Color(
//                                                                                0xffEEEEEE)),
//                                                                      ),
//                                                                    ],
//                                                                  ),
//                                                                  SizedBox(
//                                                                    width: 10,
//                                                                  ),
//                                                                  Row(
//                                                                    children: <Widget>[
//                                                                      Text("\u20B9",style: TextStyle(
//                                                                            fontSize: 11,
//                                                                          color: Constants.offWhiteColor
//                                                                      ),),
//                                                                      Text(
//                                                                        model
//                                                                            .productsList[
//                                                                        index]
//                                                                            .retailPrice,
//                                                                        style: TextStyle(
//                                                                            fontSize:
//                                                                            11,
//                                                                            decoration:
//                                                                            TextDecoration
//                                                                                .lineThrough,
//                                                                            color: Color(0xffEEEEEE)
//                                                                                .withOpacity(0.7)),
//                                                                      ),
//                                                                    ],
//                                                                  ),
//
//                                                                ],
//                                                              )
//                                                            ],
//                                                          ),
//                                                        ),
//                                                      ),
//                                                    ),
////                                                    Expanded(
////                                                      flex: 1,
////                                                      child: Container(
////                                                        child: Text(
////                                                          model
////                                                                  .productsList[
////                                                                      index]
////                                                                  .discount +
////                                                              " OFF",
////                                                          style: TextStyle(
////                                                              fontSize: 14,
////                                                              color: Color(
////                                                                  0xffEEEEEE)),
////                                                        ),
////                                                      ),
////                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                    Expanded(
//                                      flex: 1,
//                                      child: Container(
//                                        color: Color(0xff393E46),
//                                        child: Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceEvenly,
//                                          children: <Widget>[
//                                            Expanded(
//                                              flex: 2,
//                                              child: Padding(
//                                                padding:
//                                                    const EdgeInsets.all(8.0),
//                                                child: InkWell(
//                                                  onTap: () {
//                                                    model.addItemToCart(model
//                                                        .productsList[index]);
//                                                  },
//                                                  child: Container(
////                                            width: 120,
//                                                    child: const RaisedButton(
//                                                      disabledColor:
//                                                          Color(0xff00ADB5),
//                                                      onPressed: null,
//                                                      child: Text('Add To Cart',
//                                                          style: TextStyle(
//                                                              fontSize: 12,
//                                                              color: Color(
//                                                                  0xffEEEEEE))),
//                                                    ),
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                            Flexible(
//                                              child: Padding(
//                                                padding:
//                                                    const EdgeInsets.all(8.0),
//                                                child: Container(
//                                                  width: 80,
//                                                  child: Icon(
//                                                    Icons.favorite_border,
//                                                    color: Color(0xff00ADB5),
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    )
//                                  ],
//                                ),
//                              ),
//                              Positioned(
////                                left: MediaQuery.of(context).size.width *0.29,
//                                child: Container(
//                                  alignment: Alignment.topRight,
//                                  child: CustomPaint(
//                                    painter: CurvePainter(),
//                                    child: Container(
//                                      height: 160,
//                                      width: 60,
////                                      decoration: BoxDecoration(
////                                        gradient: LinearGradient(
////                                          begin: Alignment.topLeft,
////                                          end: Alignment.topRight,
////                                          colors: [
////                                            Colors.red[500],
////                                            Colors.red[300]
////                                          ],
////                                        ),
////                                      ),
//                                      padding: EdgeInsets.only(top: 10),
//                                      child: Container(
////                                        color: Colors.red,
//                                        margin: EdgeInsets.only(left: 6),
//                                        child: Text(
//                                          model.productsList[index].discount +
//                                              "% OFF",
//                                          textAlign: TextAlign.center,
//                                          style: TextStyle(
//                                              fontSize: MediaQuery.of(context).size.width/ MediaQuery.of(context).size.width * 14.0,
//                                              fontWeight: FontWeight.w900,
//                                              color: Constants.offWhiteColor),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      );
//                    },
//                  ),
            ),
        viewModelBuilder: () => ProductsListViewModel());
  }
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