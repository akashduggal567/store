import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'productsList_viewModel.dart';


class ProductsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsListViewModel>.nonReactive(
        builder: (context, model, child)=> LayoutBuilder(
          builder: (context, constraint) {
            if (constraint.maxWidth > 800) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Men"),
                  backgroundColor: Colors.black,
                  iconTheme: new IconThemeData(color: Constants.tealColor),
                ),
                backgroundColor: Colors.black,
                body: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3.2 / 5,
                  crossAxisCount: 3,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
//                        Router.navigator.pushNamed(
//                          Router.productDetailsPage,);
                        print("prod");
                        model.navigateToProductDetailsView();
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
                                      child: Container(
                                        decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                            image: DecorationImage(
                                                colorFilter: new ColorFilter.mode(
                                                    Color(0xffEEEEEE)
                                                        .withOpacity(0.9),
                                                    BlendMode.dstATop),
                                                image: AssetImage(
                                                    "assets/images/shopping.png"))),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
//                           color: Colors.blueAccent,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Container(
                                                  margin:
                                                  const EdgeInsets.only(left: 4),
//                                      color: Colors.blueAccent,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        "Biotique",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Color(0xffEEEEEE)),
                                                      ),
                                                      Text(
                                                        "Bhringraj Hair Oil",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Color(0xffEEEEEE)
                                                                .withOpacity(0.7)),
                                                      ),
                                                      Row(
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
                                                                fontSize: 15,
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
                                                                color:
                                                                Color(0xffEEEEEE)
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
                                                  "10% OFF",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xffEEEEEE)),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 100,
                                        child: const RaisedButton(
                                          disabledColor: Color(0xff00ADB5),
                                          onPressed: null,
                                          child: Text('Add To Cart',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xffEEEEEE))),
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
                    ),
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
                                    child: Container(
                                      decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                          image: DecorationImage(
                                              colorFilter: new ColorFilter.mode(
                                                  Color(0xffEEEEEE)
                                                      .withOpacity(0.9),
                                                  BlendMode.dstATop),
                                              image: AssetImage(
                                                  "assets/images/shopping.png"))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
//                           color: Colors.blueAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                margin:
                                                const EdgeInsets.only(left: 4),
//                                      color: Colors.blueAccent,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Biotique",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color(0xffEEEEEE)),
                                                    ),
                                                    Text(
                                                      "Bhringraj Hair Oil",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(0xffEEEEEE)
                                                              .withOpacity(0.7)),
                                                    ),
                                                    Row(
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
                                                              fontSize: 15,
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
                                                              color:
                                                              Color(0xffEEEEEE)
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
                                                "10% OFF",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffEEEEEE)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      child: const RaisedButton(
                                        disabledColor: Color(0xff00ADB5),
                                        onPressed: null,
                                        child: Text('Add To Cart',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffEEEEEE))),
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
                                    child: Container(
                                      decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                          image: DecorationImage(
                                              colorFilter: new ColorFilter.mode(
                                                  Color(0xffEEEEEE)
                                                      .withOpacity(0.9),
                                                  BlendMode.dstATop),
                                              image: AssetImage(
                                                  "assets/images/shopping.png"))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
//                           color: Colors.blueAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                margin:
                                                const EdgeInsets.only(left: 4),
//                                      color: Colors.blueAccent,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Biotique",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color(0xffEEEEEE)),
                                                    ),
                                                    Text(
                                                      "Bhringraj Hair Oil",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(0xffEEEEEE)
                                                              .withOpacity(0.7)),
                                                    ),
                                                    Row(
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
                                                              fontSize: 15,
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
                                                              color:
                                                              Color(0xffEEEEEE)
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
                                                "10% OFF",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffEEEEEE)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      child: const RaisedButton(
                                        disabledColor: Color(0xff00ADB5),
                                        onPressed: null,
                                        child: Text('Add To Cart',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffEEEEEE))),
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
                                    child: Container(
                                      decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                          image: DecorationImage(
                                              colorFilter: new ColorFilter.mode(
                                                  Color(0xffEEEEEE)
                                                      .withOpacity(0.9),
                                                  BlendMode.dstATop),
                                              image: AssetImage(
                                                  "assets/images/shopping.png"))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
//                           color: Colors.blueAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                margin:
                                                const EdgeInsets.only(left: 4),
//                                      color: Colors.blueAccent,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Biotique",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color(0xffEEEEEE)),
                                                    ),
                                                    Text(
                                                      "Bhringraj Hair Oil",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(0xffEEEEEE)
                                                              .withOpacity(0.7)),
                                                    ),
                                                    Row(
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
                                                              fontSize: 15,
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
                                                              color:
                                                              Color(0xffEEEEEE)
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
                                                "10% OFF",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffEEEEEE)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      child: const RaisedButton(
                                        disabledColor: Color(0xff00ADB5),
                                        onPressed: null,
                                        child: Text('Add To Cart',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffEEEEEE))),
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
                                    child: Container(
                                      decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                          image: DecorationImage(
                                              colorFilter: new ColorFilter.mode(
                                                  Color(0xffEEEEEE)
                                                      .withOpacity(0.9),
                                                  BlendMode.dstATop),
                                              image: AssetImage(
                                                  "assets/images/shopping.png"))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
//                           color: Colors.blueAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                margin:
                                                const EdgeInsets.only(left: 4),
//                                      color: Colors.blueAccent,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Biotique",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color(0xffEEEEEE)),
                                                    ),
                                                    Text(
                                                      "Bhringraj Hair Oil",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(0xffEEEEEE)
                                                              .withOpacity(0.7)),
                                                    ),
                                                    Row(
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
                                                              fontSize: 15,
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
                                                              color:
                                                              Color(0xffEEEEEE)
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
                                                "10% OFF",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffEEEEEE)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      child: const RaisedButton(
                                        disabledColor: Color(0xff00ADB5),
                                        onPressed: null,
                                        child: Text('Add To Cart',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffEEEEEE))),
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
                                    child: Container(
                                      decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                          image: DecorationImage(
                                              colorFilter: new ColorFilter.mode(
                                                  Color(0xffEEEEEE)
                                                      .withOpacity(0.9),
                                                  BlendMode.dstATop),
                                              image: AssetImage(
                                                  "assets/images/shopping.png"))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
//                           color: Colors.blueAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                margin:
                                                const EdgeInsets.only(left: 4),
//                                      color: Colors.blueAccent,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Biotique",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color(0xffEEEEEE)),
                                                    ),
                                                    Text(
                                                      "Bhringraj Hair Oil",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(0xffEEEEEE)
                                                              .withOpacity(0.7)),
                                                    ),
                                                    Row(
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
                                                              fontSize: 15,
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
                                                              color:
                                                              Color(0xffEEEEEE)
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
                                                "10% OFF",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffEEEEEE)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      child: const RaisedButton(
                                        disabledColor: Color(0xff00ADB5),
                                        onPressed: null,
                                        child: Text('Add To Cart',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffEEEEEE))),
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
                                    child: Container(
                                      decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                          image: DecorationImage(
                                              colorFilter: new ColorFilter.mode(
                                                  Color(0xffEEEEEE)
                                                      .withOpacity(0.9),
                                                  BlendMode.dstATop),
                                              image: AssetImage(
                                                  "assets/images/shopping.png"))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
//                           color: Colors.blueAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                margin:
                                                const EdgeInsets.only(left: 4),
//                                      color: Colors.blueAccent,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Biotique",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color(0xffEEEEEE)),
                                                    ),
                                                    Text(
                                                      "Bhringraj Hair Oil",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(0xffEEEEEE)
                                                              .withOpacity(0.7)),
                                                    ),
                                                    Row(
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
                                                              fontSize: 15,
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
                                                              color:
                                                              Color(0xffEEEEEE)
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
                                                "10% OFF",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffEEEEEE)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      child: const RaisedButton(
                                        disabledColor: Color(0xff00ADB5),
                                        onPressed: null,
                                        child: Text('Add To Cart',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffEEEEEE))),
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
                                    child: Container(
                                      decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                          image: DecorationImage(
                                              colorFilter: new ColorFilter.mode(
                                                  Color(0xffEEEEEE)
                                                      .withOpacity(0.9),
                                                  BlendMode.dstATop),
                                              image: AssetImage(
                                                  "assets/images/shopping.png"))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
//                           color: Colors.blueAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                margin:
                                                const EdgeInsets.only(left: 4),
//                                      color: Colors.blueAccent,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Biotique",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color(0xffEEEEEE)),
                                                    ),
                                                    Text(
                                                      "Bhringraj Hair Oil",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(0xffEEEEEE)
                                                              .withOpacity(0.7)),
                                                    ),
                                                    Row(
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
                                                              fontSize: 15,
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
                                                              color:
                                                              Color(0xffEEEEEE)
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
                                                "10% OFF",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffEEEEEE)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      child: const RaisedButton(
                                        disabledColor: Color(0xff00ADB5),
                                        onPressed: null,
                                        child: Text('Add To Cart',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffEEEEEE))),
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
                  ],
                ),
              );
            }
            else {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Men"),
                  backgroundColor: Colors.black,
                  iconTheme: new IconThemeData(color: Constants.tealColor),
                ),
                backgroundColor: Colors.black,
                body: GridView.builder(
                  itemCount: 8,
                  padding: const EdgeInsets.all(20) ,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3.2 / 5

                  ),
                  itemBuilder: (context, int index) {
                    return  InkWell(
                      onTap: (){
                        model.navigateToProductDetailsView();
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
                                      child: Container(
                                        decoration: BoxDecoration(
//                               color: Colors.blueGrey,
                                            image: DecorationImage(
                                                colorFilter: new ColorFilter.mode(
                                                    Color(0xffEEEEEE)
                                                        .withOpacity(0.95),
                                                    BlendMode.dstATop
                                                ),
                                                image: AssetImage(
                                                    "assets/images/shopping.png"))),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
//                           color: Colors.blueAccent,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Container(
                                                  margin:
                                                  const EdgeInsets.only(left: 4),
//                                      color: Colors.blueAccent,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        "Biotique",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Color(0xffEEEEEE)),
                                                      ),
                                                      Text(
                                                        "Bhringraj Hair Oil",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Color(0xffEEEEEE)
                                                                .withOpacity(0.7)),
                                                      ),
                                                      Row(
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
                                                                fontSize: 15,
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
                                                                color:
                                                                Color(0xffEEEEEE)
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
                                                  "10% OFF",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xffEEEEEE)
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
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: Color(0xff393E46),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                      model.addItemToCart("2");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 100,
                                          child: const RaisedButton(
                                            disabledColor: Color(0xff00ADB5),
                                            onPressed: null,
                                            child: Text('Add To Cart',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffEEEEEE))),
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
              );
            }
          },
        ),
        viewModelBuilder: ()=> ProductsListViewModel());
  }
}
