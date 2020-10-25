import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/ui/views/cart/cart_view.dart';
import 'package:store/ui/views/dashboard/search/search_viewModel.dart';
import 'package:store/ui/views/onboarding/onBoarding_viewModel.dart';
import 'package:store/ui/widgets/creation_aware_list_item.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
        builder: (context, model, child)=>Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: Colors.black,
              child: Theme(
                data: ThemeData(primaryColor: Constants.tealColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Constants.offWhiteColor),
                    keyboardType: TextInputType.text,
                    controller: controller ,
                    maxLines: 1,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.offWhiteColor, width: 0.5),
                      ),
                      counterText: '',
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                      labelStyle: TextStyle(color: Constants.offWhiteColor),
                    ),
                    onSubmitted: (String value) async {
                        await model.fetchProducts(value.trim(), 1, model.limit);

                    },
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              flex: 10,
              child: Container(
                color: Colors.black,
//              height: MediaQuery.of(context).size.height*2.0,
                child:  searchResult(model: model),
              ),
            )
          ],
        ),
        viewModelBuilder: ()=> SearchViewModel());
  }
}


class searchResult extends StatelessWidget {
  SearchViewModel model;
  searchResult({
    @required this.model,
  });
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: model.isBusy ? GridView.builder(
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
            }) : model.productsList.length == 0
          ? Padding(
        padding: const EdgeInsets.all(18.0),
        child: FadeIn(
          duration: Duration(seconds: 1),
          child: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: SvgPicture.asset(
                      "assets/images/not_found.svg")),
              Expanded(
                child: Text(
                  "Sorry, No products found",
                  style: TextStyle(
                      color: Constants.offWhiteColor),
                ),
              )
            ],
          ),
        ),
      )
          :  CustomScrollView(
        controller: controller,
        slivers: <Widget>[
          SliverGrid(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.4 / 4),
            delegate: SliverChildBuilderDelegate(
                    (context, int index) {
                  return VisibilityDetector(
                    key: Key('$index'),
                    onVisibilityChanged: (visibilityInfo) {
                      print(visibilityInfo.size);
                      model.itemBuildIndex = index;
                    },
                    child: CreationAwareListItem(
                      itemCreated: () {
//                              print('Item created at $indexd');
                        SchedulerBinding.instance
                            .addPostFrameCallback((duration) =>
                            model.handleItemCreated(index));
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            color: Colors.black,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: InkWell(
                                    onTap: (){
                                      model.navigateToProductDetailsView(
                                          productDetails:
                                          model.productsList[index]);
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
                                                  .productsList[
                                              index]
                                                  .id,
                                              child: Container(
                                                margin:
                                                EdgeInsets.only(top: 2),
                                                child:model.productsList[index].images?.length == 0 ? Padding(
                                                  padding: const EdgeInsets.all(38.0),
                                                  child: Center(child: SvgPicture.asset("assets/images/empty_photo_illustration.svg")),
                                                ): CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  imageUrl:  model
                                                      .productsList[index]
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
                                              color: Constants.darkBlackColor,
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
//                                                                            'config brand',
                                                              model
                                                                  .productsList[
                                                              index]
                                                                  .brand ?? "Unknown Brand",
                                                              style:
                                                              TextStyle(fontSize: 15, color: Color(0xffEEEEEE)),
                                                            ),
                                                            Text(
                                                              model.productsList[index].title,
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
                                                                      model.productsList[index].salePrice,
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
                                                                      model.productsList[index].retailPrice,
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
                                                  model.productsList[index].inventoryCount > model.productsList[index].minInventoryCount
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
                                              model.productsList[index].inventoryCount==0 ? RaisedButton(
                                                color: Constants.tealColor,
                                                disabledColor:
                                                Constants.darkBlackColor,
                                                onPressed: model.productsList[index].inventoryCount <= model.productsList[index].minInventoryCount ? null :(){
//                                                                     model.addItemToCart(
//                                                                        model.productsList[
//                                                                        index]);
                                                  print(model.productsList[index].inventoryCount < model.productsList[index].minInventoryCount);
                                                },
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
                                                  model.addItemToCart(
                                                      model.productsList[
                                                      index]);

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
                                            child: Container(
                                              width: 80,
                                              child: Icon(
                                                Icons
                                                    .favorite_border,
                                                color: Color(
                                                    0xff00ADB5),
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
                                  padding:
                                  EdgeInsets.only(top: 10),
                                  child: Container(
//                                        color: Colors.red,
                                    margin: EdgeInsets.only(
                                        left: 6),
                                    child: Text(
                                      model.productsList[index]
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
                      ),
                    ),
                  );
                }, childCount: model.productsList.length),
          ),
          model.isLoadingMore
              ? new SliverToBoxAdapter(
            child: CupertinoActivityIndicator(
              radius: 24,
            ),
          )
              : new SliverToBoxAdapter(
            child: Container(),
          ),
        ],
      ),
    );
  }
}


//class UserSearchDelegate extends SearchDelegate {
//  SearchViewModel model;
//  UserSearchDelegate({this.model});
//  ScrollController controller = ScrollController();
//  @override
//  ThemeData appBarTheme(BuildContext context) {
//    assert(context != null);
//    final ThemeData theme = Theme.of(context);
//    assert(theme != null);
//    return theme.copyWith(
//        primaryColor: Colors.black,
//        primaryIconTheme:
//        theme.primaryIconTheme.copyWith(color: Constants.tealColor),
//        primaryColorBrightness: Brightness.dark,
//        textTheme: theme.textTheme.copyWith(
//            title: theme.textTheme.title
//                .copyWith(color: theme.primaryTextTheme.title.color)));
//  }
//
//  @override
//  List<Widget> buildActions(BuildContext context) {
//    return [
//      IconButton(
//        icon: Icon(Icons.clear),
//        onPressed: () {
//          query = '';
//        },
//      ),
//    ];
//  }
//
//  @override
//  Widget buildLeading(BuildContext context) {
//    return IconButton(
//      icon: Icon(Icons.arrow_back),
//      onPressed: () {
//        close(context, null);
//      },
//    );
//  }
//
//  @override
//  Widget buildResults(BuildContext context) {
//    return FutureBuilder(
//      future: model.getResults(query,model.currentPage,5),
//      builder: (BuildContext context, AsyncSnapshot snapshot) {
////        if (!snapshot.hasData) return Center(child: Text("Still searching",style: TextStyle(color: Colors.white),));
//
//        return model.isBusy ? GridView.builder(
//            itemCount: 6,
//            padding: const EdgeInsets.all(20),
//            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                crossAxisCount: 2,
//                crossAxisSpacing: 10,
//                mainAxisSpacing: 10,
//                childAspectRatio: 3 / 5),
//            itemBuilder: (context, int index) {
//              return Shimmer.fromColors(
//                  baseColor: Colors.black,
//                  highlightColor: Constants.lightBlackColor,
//                  enabled: true,
//                  child: Container(
//                    color: Colors.white,
//                  ));
//            }) : Padding(
//          padding: const EdgeInsets.all(18.0),
//          child: model.results.length == 0
//              ? Padding(
//            padding: const EdgeInsets.all(18.0),
//            child: FadeIn(
//              duration: Duration(seconds: 1),
//              child: Column(
//                children: [
//                  Expanded(
//                      flex: 4,
//                      child: SvgPicture.asset(
//                          "assets/images/not_found.svg")),
//                  Expanded(
//                    child: Text(
//                      "Sorry, No products found",
//                      style: TextStyle(
//                          color: Constants.offWhiteColor),
//                    ),
//                  )
//                ],
//              ),
//            ),
//          )
//              : CustomScrollView(
//            controller: controller,
//            slivers: <Widget>[
//              SliverGrid(
//                gridDelegate:
//                SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisCount: 2,
//                    crossAxisSpacing: 10,
//                    mainAxisSpacing: 10,
//                    childAspectRatio: 2.4 / 4),
//                delegate: SliverChildBuilderDelegate(
//                        (context, int index) {
//                      return VisibilityDetector(
//                        key: Key('$index'),
//                        onVisibilityChanged: (visibilityInfo) {
//                          print(visibilityInfo.size);
//                          model.itemBuildIndex = index;
//                        },
//                        child: CreationAwareListItem(
//                          itemCreated: () {
////                              print('Item created at $indexd');
//                            SchedulerBinding.instance
//                                .addPostFrameCallback((duration) =>
//                                model.handleItemCreated(index));
//                          },
//                          child: Stack(
//                            children: <Widget>[
//                              Container(
//                                color: Colors.black,
//                                child: Column(
//                                  children: <Widget>[
//                                    Expanded(
//                                      flex: 5,
//                                      child: InkWell(
//                                        onTap: (){
////                                          model.navigateToProductDetailsView(
////                                              productDetails:
////                                              model.productsList[index]);
//                                        },
//                                        child: Container(
//                                          child: Column(
//                                            children: <Widget>[
//                                              Expanded(
//                                                flex: 3,
//                                                child: Hero(
//                                                  transitionOnUserGestures:
//                                                  true,
//                                                  tag: model
//                                                      .results[
//                                                  index]
//                                                      .id,
//                                                  child: Container(
//                                                    margin:
//                                                    EdgeInsets.only(top: 2),
//                                                    child:model.results[index].images?.length == 0 ? Padding(
//                                                      padding: const EdgeInsets.all(38.0),
//                                                      child: Center(child: SvgPicture.asset("assets/images/empty_photo_illustration.svg")),
//                                                    ): CachedNetworkImage(
//                                                      fit: BoxFit.fill,
//                                                      imageUrl:  model
//                                                          .results[index]
//                                                          .images[0],
//                                                      placeholder: (context, url) => CupertinoActivityIndicator(radius: 40,),
//                                                      errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.white,),
//                                                    ),
//                                                  ),
//                                                ),
//                                              ),
//                                              Expanded(
//                                                flex: 1,
//                                                child: Container(
//                                                  color: Constants.darkBlackColor,
//                                                  child: Row(
//                                                    mainAxisAlignment:
//                                                    MainAxisAlignment
//                                                        .spaceAround,
//                                                    children: <
//                                                        Widget>[
//                                                      Expanded(
//                                                        flex: 2,
//                                                        child:
//                                                        Padding(
//                                                          padding:
//                                                          const EdgeInsets.all(
//                                                              4.0),
//                                                          child:
//                                                          Container(
//                                                            margin: const EdgeInsets
//                                                                .only(
//                                                                left:
//                                                                4),
////                                      color: Colors.blueAccent,
//                                                            child:
//                                                            Column(
//                                                              mainAxisAlignment:
//                                                              MainAxisAlignment.spaceAround,
//                                                              crossAxisAlignment:
//                                                              CrossAxisAlignment.start,
//                                                              children: <
//                                                                  Widget>[
//                                                                Text(
////                                                                            'config brand',
//                                                                  model
//                                                                      .results[
//                                                                  index]
//                                                                      .brand ?? "Unknown Brand",
//                                                                  style:
//                                                                  TextStyle(fontSize: 15, color: Color(0xffEEEEEE)),
//                                                                ),
//                                                                Text(
//                                                                  model.results[index].title,
//                                                                  overflow:
//                                                                  TextOverflow.ellipsis,
//                                                                  style:
//                                                                  TextStyle(fontSize: 12, color: Color(0xffEEEEEE).withOpacity(0.7)),
//                                                                ),
//                                                                Row(
//                                                                  crossAxisAlignment:
//                                                                  CrossAxisAlignment.baseline,
//                                                                  textBaseline:
//                                                                  TextBaseline.alphabetic,
//                                                                  mainAxisAlignment:
//                                                                  MainAxisAlignment.start,
//                                                                  children: <Widget>[
//                                                                    Row(
//                                                                      children: <Widget>[
//                                                                        Text(
//                                                                          "\u20B9",
//                                                                          style: TextStyle(color: Constants.offWhiteColor),
//                                                                        ),
//                                                                        Text(
//                                                                          model.results[index].salePrice,
//                                                                          style: TextStyle(fontSize: 15, color: Color(0xffEEEEEE)),
//                                                                        ),
//                                                                      ],
//                                                                    ),
//                                                                    SizedBox(
//                                                                      width: 10,
//                                                                    ),
//                                                                    Row(
//                                                                      children: <Widget>[
//                                                                        Text(
//                                                                          "\u20B9",
//                                                                          style: TextStyle(fontSize: 11, color: Constants.offWhiteColor),
//                                                                        ),
//                                                                        Text(
//                                                                          model.results[index].retailPrice,
//                                                                          style: TextStyle(fontSize: 11, decoration: TextDecoration.lineThrough, color: Color(0xffEEEEEE).withOpacity(0.7)),
//                                                                        ),
//                                                                      ],
//                                                                    ),
//                                                                  ],
//                                                                )
//                                                              ],
//                                                            ),
//                                                          ),
//                                                        ),
//                                                      ),
//                                                      model.results[index].inventoryCount > model.results[index].minInventoryCount
//                                                          ? Container()
//                                                          : Expanded(
//                                                        flex: 1,
//                                                        child:
//                                                        Container(
//                                                          child:
//                                                          Text(
//                                                            'Few Left',
//                                                            style:
//                                                            TextStyle(fontSize: 14, color: Colors.red.withOpacity(0.9)),
//                                                          ),
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                    Expanded(
//                                      flex: 1,
//                                      child: Container(
//                                        color: Color(0xff393E46),
//                                        child: Row(
//                                          mainAxisAlignment:
//                                          MainAxisAlignment
//                                              .spaceEvenly,
//                                          children: <Widget>[
//                                            Expanded(
//                                              flex: 2,
//                                              child: Padding(
//                                                padding:
//                                                const EdgeInsets
//                                                    .all(8.0),
//                                                child: Container(
////                                            width: 120,
//                                                  child:
//                                                  model.results[index].inventoryCount==0 ? RaisedButton(
//                                                    color: Constants.tealColor,
//                                                    disabledColor:
//                                                    Constants.darkBlackColor,
//                                                    onPressed: model.results[index].inventoryCount <= model.results[index].minInventoryCount ? null :(){
////                                                                     model.addItemToCart(
////                                                                        model.productsList[
////                                                                        index]);
//                                                      print(model.results[index].inventoryCount < model.results[index].minInventoryCount);
//                                                    },
//                                                    child: Text(
//                                                        'Out Of Stock',
//                                                        style: TextStyle(
//                                                            fontSize:
//                                                            12,
//                                                            color:
//                                                            Color(0xffEEEEEE))),
//                                                  ) :  RaisedButton(
//                                                    color: Constants.tealColor,
//                                                    disabledColor:
//                                                    Constants.darkBlackColor,
//                                                    onPressed: (){
////                                                      model.addItemToCart(
////                                                          model.results[
////                                                          index]);
//
//                                                    },
//                                                    child: Text(
//                                                        'Add To Cart',
//                                                        style: TextStyle(
//                                                            fontSize:
//                                                            12,
//                                                            color:
//                                                            Color(0xffEEEEEE))),
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                            Flexible(
//                                              child: Padding(
//                                                padding:
//                                                const EdgeInsets
//                                                    .all(8.0),
//                                                child: Container(
//                                                  width: 80,
//                                                  child: Icon(
//                                                    Icons
//                                                        .favorite_border,
//                                                    color: Color(
//                                                        0xff00ADB5),
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
//                                      padding:
//                                      EdgeInsets.only(top: 10),
//                                      child: Container(
////                                        color: Colors.red,
//                                        margin: EdgeInsets.only(
//                                            left: 6),
//                                        child: Text(
//                                          model.results[index]
//                                              .discount +
//                                              "% OFF",
//                                          textAlign:
//                                          TextAlign.center,
//                                          style: TextStyle(
//                                              fontSize: MediaQuery.of(
//                                                  context)
//                                                  .size
//                                                  .width /
//                                                  MediaQuery.of(
//                                                      context)
//                                                      .size
//                                                      .width *
//                                                  14.0,
//                                              fontWeight:
//                                              FontWeight.w900,
//                                              color: Constants
//                                                  .offWhiteColor),
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
//                    }, childCount: model.results.length),
//              ),
//              model.isLoadingMore
//                  ? new SliverToBoxAdapter(
//                        child: CupertinoActivityIndicator(
//                radius: 24,
//                ),
//              )
//                  : new SliverToBoxAdapter(
//                child: Container(color: Colors.pink,),
//              ),
//            ],
//          ),
//        );
//      },
//    );
//
//    //Add the search term to the searchBloc.
//    //The Bloc will then handle the searching and add the results to the searchResults stream.
//    //This is the equivalent of submitting the search term to whatever search service you are using
////    InheritedBlocs.of(context)
////        .searchBloc
////        .searchTerm
////        .add(query);
////
//    return Column(
//      children: <Widget>[
//
//        //Build the results based on the searchResults stream in the searchBloc
////        StreamBuilder(
////          stream: InheritedBlocs.of(context).searchBloc.searchResults,
////          builder: (context, AsyncSnapshot<List<Result>> snapshot) {
////            if (!snapshot.hasData) {
////              return Column(
////                crossAxisAlignment: CrossAxisAlignment.center,
////                mainAxisAlignment: MainAxisAlignment.center,
////                children: <Widget>[
////                  Center(child: CircularProgressIndicator()),
////                ],
////              );
////            } else if (snapshot.data.length == 0) {
////              return Column(
////                children: <Widget>[
////                  Text(
////                    "No Results Found.",
////                  ),
////                ],
////              );
////            } else {
////              var results = snapshot.data;
////              return ListView.builder(
////                itemCount: results.length,
////                itemBuilder: (context, index) {
////                  var result = results[index];
////                  return ListTile(
////                    title: Text(result.title),
////                  );
////                },
////              );
////            }
////          },
////        ),
//      ],
//    );
//  }
//
//  @override
//  Widget buildSuggestions(BuildContext context) {
//    // This method is called everytime the search term changes.
//    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
//    return Column(
////      children: <Widget>[Text("d",style: TextStyle(color: Colors.white),),],
//    );
//  }
//}

