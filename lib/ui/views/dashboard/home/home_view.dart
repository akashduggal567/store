import 'dart:async';
import 'dart:math';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:store/app/locator.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/services/local_notification_service.dart';
import 'package:store/ui/views/onboarding/onBoarding_viewModel.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import '../../custom_icon_icons.dart';
import 'home_viewModel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child)=> Padding(
          padding: const EdgeInsets.all(8.0),
          child: HomeMobileLayout(model: model),
        ),
        viewModelBuilder: ()=> locator<HomeViewModel>(),
    );
  }
}

class HomeMobileLayout extends StatefulWidget {
  HomeViewModel model;
  HomeMobileLayout({
    this.model
  });
  @override
  _HomeMobileLayoutState createState() => _HomeMobileLayoutState();
}

class _HomeMobileLayoutState extends State<HomeMobileLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static int refreshNum = 10; // num
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();
  LocalNotificationService _localNotificationService = locator<LocalNotificationService>();

  Future<void> _handleRefresh() {
      return widget.model.refreshCategories();
  }
//  WebSocketChannel channel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          key: PageStorageKey('storage-key'),
          children: <Widget>[
            Container(
                height: 180,
                child: Carousel(
                  images: [
                    AssetImage('assets/images/sample_banner_1.jpg'),
                    AssetImage('assets/images/sample_banner_2.jpg'),
                    AssetImage('assets/images/sample_banner_3.png'),
                  ],
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotColor: Color(0xffEEEEEE),
                  dotIncreasedColor: Color(0xff0AD5B1),
                  autoplayDuration: Duration(seconds: 4),
                  indicatorBgPadding: 5.0,
                  autoplay: false,
                  dotBgColor: Color(0xff222831).withOpacity(0.8),
                  borderRadius: false,
                )),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => {
                print("clicked!!"),
                widget.model.showNotification()
              },
              child: Container(
                height: 40,
                color: Color(0xff222831),
                child: Center(
                    child: Text(
                      "For Offers or Something",
                      style: TextStyle(color: Colors.white54),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 30,
                  child: Text(
                    "Categories ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                InkWell(
                  onTap: (){
                    widget.model.navigateToProductsListView();
                  },
                  child: Container(
                    height: 30,
                    child: Text(
                      "See All",
                      style: TextStyle(color: Color(0xff00ADB5), fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              child: widget.model.isBusy && widget.model.categories.length ==0 ?
              GridView.builder(
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  childAspectRatio: MediaQuery.of(context).size.width *
                      2.4 /
                      MediaQuery.of(context).size.height *
                      0.9,
                ),
                itemBuilder: (BuildContext context,int index){
                  return Shimmer.fromColors(
                    baseColor: Colors.black,
                    highlightColor: Constants.lightBlackColor,
                    enabled: true,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
//                          color: Color(0xff393E46),
                          color: Color(0xff222831),
                          border: Border.all(color: Colors.grey, width: 0)),
                    ),
                  );
                })  :
              GridView.builder(
                  key: PageStorageKey("storage-key"),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.model.categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    childAspectRatio: MediaQuery.of(context).size.width *
                        2.4 /
                        MediaQuery.of(context).size.height *
                        0.9,
                  ),
                  itemBuilder: (BuildContext context,int index){
                    return _buildCategoryTile(widget.model,widget.model.categories, index);
                  })

//              FutureBuilder(
//                future: widget.model.categories,
//                builder: (context,snapshot){
//                  if(snapshot.hasError){
//                    return Text("Error ${snapshot.error}");
//                  }
//                  if(snapshot.hasData){
//                    return GridView.builder(
//                        key: PageStorageKey("storage-key"),
//                        physics: NeverScrollableScrollPhysics(),
//                        shrinkWrap: true,
//                        itemCount: snapshot.data.length<6 ? snapshot.data.length: 6,
//                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                          crossAxisSpacing: 10,
//                          mainAxisSpacing: 10,
//                          crossAxisCount: 3,
//                          childAspectRatio: MediaQuery.of(context).size.width *
//                              2.4 /
//                              MediaQuery.of(context).size.height *
//                              0.9,
//                        ),
//                        itemBuilder: (BuildContext context,int index){
//                          return _buildCategoryTile(snapshot, index);
//                        });
//                  }
//
//                  return GridView.builder(
//                      shrinkWrap: true,
//                      itemCount: 6,
//                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                        crossAxisSpacing: 10,
//                        mainAxisSpacing: 10,
//                        crossAxisCount: 3,
//                        childAspectRatio: MediaQuery.of(context).size.width *
//                            2.4 /
//                            MediaQuery.of(context).size.height *
//                            0.9,
//                      ),
//                      itemBuilder: (BuildContext context,int index){
//                        return Shimmer.fromColors(
//                          baseColor: Colors.black,
//                          highlightColor: Constants.lightBlackColor,
//                          enabled: true,
//                          child: Container(
//                            padding: const EdgeInsets.all(8),
//                            decoration: BoxDecoration(
////                          color: Color(0xff393E46),
//                                color: Color(0xff222831),
//                                border: Border.all(color: Colors.grey, width: 0)),
//                          ),
//                        );
//                      });
//                },
//              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 30,
                  child: Text(
                    "Previously Bought ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Container(
                  height: 30,
                  child: Text(
                    "See All",
                    style: TextStyle(color: Color(0xff00ADB5), fontSize: 16),
                  ),
                ),
              ],
            ),
            Container(
                height: 160,
                width: 100,
//                    color: Color(0xff222831),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: mycard(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: mycard(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: mycard(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: mycard(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: mycard(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: mycard(),
                    ),
                    SizedBox(
                      width: 10,
                    ),


                  ],
                )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class mycard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 260,
      child: new Card(
        color: Color(0xD9EEEEEE),
        elevation: 0,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xff222831),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3), topRight: Radius.circular(3)),
              ),
              height: 24,
              width: double.infinity,
              child: Center(
                  child: Text(
                    "13 March 2020",
                    style: TextStyle(color: Color(0xffEEEEEE)),
                  )),
            ),
            Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff393E46),
                  ),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Bringraj Oil" + " x1",
                                  style: TextStyle(color: Color(0xffEEEEEE)),
                                ),
                                Text(
                                  "Rs. 30",
                                  style: TextStyle(color: Color(0xffEEEEEE)),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Container(
//                    color: Colors.redAccent,
                            child: Icon(Icons.shopping_cart,
                                size: 36, color: Color(0xff00ADB5)),
                          )),
                    ],
                  ),
                )),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff00ADB5),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(3)),
              ),
              height: 24,
              width: double.infinity,
              child: Center(
                  child: Text(
                    "BUY",
                    style: TextStyle(color: Color(0xffffffff)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
class myTabcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 320,
      child: new Card(
        color: Color(0xD9EEEEEE),
        elevation: 0,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xff222831),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3), topRight: Radius.circular(3)),
              ),
              height: 38,
              width: double.infinity,
              child: Center(
                  child: Text(
                    "13 March 2020",
                    style: TextStyle(color: Color(0xffEEEEEE), fontSize: 20),
                  )),
            ),
            Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff393E46),
                  ),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Bringraj Oil" + " x1",
                                  style: TextStyle(
                                      color: Color(0xffEEEEEE), fontSize: 20),
                                ),
                                Text(
                                  "Rs. 30",
                                  style: TextStyle(
                                      color: Color(0xffEEEEEE), fontSize: 20),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Container(
//                    color: Colors.redAccent,
                            child: Icon(
                              Icons.shopping_cart,
                              size: 45,
                              color: Color(0xD9EEEEEE),
                            ),
                          )),
                    ],
                  ),
                )),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffEEEEEE),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(3)),
              ),
              height: 24,
              width: double.infinity,
              child: Center(
                  child: Text(
                    "BUY",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCategoryTile(HomeViewModel model,snapshot,index){
  return InkWell(
    onTap: (){

      model.navigateToSubCategory(snapshot[index]);
    },
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
//                          color: Color(0xff393E46),
          color: Color(0xff222831),
          border: Border.all(color: Colors.grey, width: 0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.face,
            size: 35,
            color: Color(0xff00ADB5),
//                                  color: Colors.white60,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            snapshot[index].name.toString(),
            style: TextStyle(color: Color(0xffEEEEEE)),
          ),
        ],
      ),
    ),
  );
}