import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'productsList_viewModel.dart';

class ProductsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsListViewModel>.reactive(
        onModelReady: (model) => model.fetchProducts(),
        builder: (context, model, child) => model.isBusy
            ? CupertinoActivityIndicator(
                radius: 20,
              )
            : WillPopScope(
                onWillPop: () {
                  model.navigateToDashboard();
                  return Future.value(false);
                },
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("Men"),
                    backgroundColor: Colors.black,
                    iconTheme: new IconThemeData(color: Constants.tealColor),
                  ),
                  backgroundColor: Colors.black,
                  body: GridView.builder(
                    itemCount: model.productsList.length,
                    padding: const EdgeInsets.all(20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 5),
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: () {
                          model.navigateToProductDetailsView(
                              productDetails: model.productsList[index]);
                        },
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
                                        child: Hero(
                                          transitionOnUserGestures: true,
                                          tag: model
                                              .productsList[index].productId,
                                          child: Container(
                                            child: CachedNetworkImage(
                                              imageUrl: model
                                                  .productsList[index]
                                                  .thumbnailUrl,
//                                            placeholder: (context, url) => CupertinoActivityIndicator(radius: 40,),
//                                            errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.white,),
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
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
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
                                                          model
                                                              .productsList[
                                                                  index]
                                                              .brand,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Color(
                                                                  0xffEEEEEE)),
                                                        ),
                                                        Text(
                                                          model
                                                              .productsList[
                                                                  index]
                                                              .name,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12,
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
                                                          children: <Widget>[
                                                            Text(
                                                              model
                                                                  .productsList[
                                                                      index]
                                                                  .retailPrice,
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Color(
                                                                      0xffEEEEEE)),
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              model
                                                                  .productsList[
                                                              index]
                                                                  .mrp,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
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
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: Text(
                                                    model.productsList[index]
                                                        .discount + " OFF",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xffEEEEEE)),
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              model.addItemToCart(model.productsList[index]);
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
                                                        color:
                                                            Color(0xffEEEEEE))),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                      );
                    },
                  ),
                ),
              ),
        viewModelBuilder: () => ProductsListViewModel());
  }
}
