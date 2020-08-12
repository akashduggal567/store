import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:store/ui/views/wishlist/wishlist_viewModel.dart';

class WishListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WishListViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Wishlist"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: model.wishListItemsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3.2 / 5,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return item();
                  }),
            )),
        viewModelBuilder: () => WishListViewModel());
  }
}

Widget item() {
  return Container(
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
                            image: AssetImage("assets/images/shopping.jpg"))),
                  ),
                ),
                Expanded(
                  child: Container(
//                           color: Colors.blueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              margin: const EdgeInsets.only(left: 4),
//                                      color: Colors.blueAccent,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Biotique",
                                    style: TextStyle(
                                        fontSize: 15, color: Color(0xffEEEEEE)),
                                  ),
                                  Text(
                                    "Bhringraj Hair Oil",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color(0xffEEEEEE).withOpacity(0.7)),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Rs 140",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xffEEEEEE)),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Rs 140",
                                        style: TextStyle(
                                            fontSize: 11,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Color(0xffEEEEEE)
                                                .withOpacity(0.7)),
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
                                  fontSize: 14, color: Colors.red[400]),
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
                    width: 120,
                    child: Material(
                      elevation: 0,
                      child: RaisedButton(
                        disabledColor: Color(0xff00ADB5),
                        onPressed: null,
                        child: Text('Add To Cart',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xffEEEEEE))),
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
  );
}
