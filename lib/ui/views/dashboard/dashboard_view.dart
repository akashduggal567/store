import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/ui/views/dashboard/profie/profile_view.dart';
import 'package:store/ui/views/dashboard/search/search_view.dart';
import 'dashboard_viewModel.dart';
import 'home/home_view.dart';
import 'orders/orders_view.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  bool _allowExit = false;
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white70);
  List<Widget> _widgetOptions = <Widget>[

//    OrderHistory(),

    HomeView(),
    SearchView(),
    OrdersView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.nonReactive(
        builder: (context, model, child)=>WillPopScope(
          onWillPop:() {
            return Future.value(_allowExit);
          },
          child: SafeArea(
            child: Scaffold(
              appBar: new AppBar(
                iconTheme: new IconThemeData(color: Color(0xff00ADB5)),
                backgroundColor: Colors.black,
                title: Text("DStore"),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      model.navigateToCart();
                    },
                  ),

                ],
              ),
              body: Container(
                color: Colors.black,
                child: _widgetOptions.elementAt(_selectedIndex),
              ),

              bottomNavigationBar: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Color(0xff222831),
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    title: Text('Search'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.work),
                    title: Text('Orders'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    title: Text('Profile'),
                  ),
                ],
                currentIndex: _selectedIndex,
//          selectedItemColor: Colors.amber[800],
                selectedItemColor: Color(0xff00ADB5),
                unselectedItemColor: Colors.white54,
                onTap: _onItemTapped,
              ),
              drawer: Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the drawer if there isn't enough vertical
                // space to fit everything.
                child: Container(
                  color: Color(0xff222831),
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Container(
                        height: 140,
                        child: DrawerHeader(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: <Widget>[

                                    Text(
                                      'Akash Duggal',
                                      style: TextStyle(color: Color(0xffEEEEEE),fontSize: 22),
                                    ),
                                    Text(
                                      'MIG 567, Jamalpur Colony, Chandigarh Road, Ludhiana',
                                      style: TextStyle(color: Color(0xD9EEEEEE),
                                          fontSize: 12),
                                    ),

                                    Text(
                                      '+918570897778',
                                      style: TextStyle(color: Color(0xD9EEEEEE),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Icon(Icons.person, color: Color(0xff00ADB5),size: 60,),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.shopping_cart,color: Color(0xff00ADB5),),
                        title: Text(
                          'Cart',
                          style: TextStyle(
                              color: Color(0xffEEEEEE), fontWeight: FontWeight.bold),
                        ),
//                        onTap: () {
//                          // Update the state of the app
//                          // ...
//                          // Then close the drawer
//                          Navigator.pop(context);
//                          Router.navigator.pushNamed(
//                            Router.cartPage,);
//                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.add_shopping_cart,color: Color(0xff00ADB5),),
                        title: Text(
                          'Orders',
                          style: TextStyle(
                              color: Color(0xffEEEEEE), fontWeight: FontWeight.bold),
                        ),
//                        onTap: () {
//                          // Update the state of the app
//                          // ...
//                          // Then close the drawer
//                          Navigator.pop(context);
//                          Router.navigator.pushNamed(
//                            Router.orderHistoryPage,);
//                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.favorite,color: Color(0xff00ADB5),),
                        title: Text(
                          'Wishlist',
                          style: TextStyle(
                              color: Color(0xffEEEEEE), fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.person,color: Color(0xff00ADB5),),
                        title: Text(
                          'Account',
                          style: TextStyle(
                              color: Color(0xffEEEEEE), fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings,color: Color(0xff00ADB5),),
                        title: Text(
                          'Settings',
                          style: TextStyle(
                              color: Color(0xffEEEEEE), fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.home,color: Color(0xff00ADB5),),
                        title: Text(
                          'Addresses',
                          style: TextStyle(
                              color: Color(0xffEEEEEE), fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer


                          Navigator.of(context, rootNavigator: true)..pop();
                          model.naviagteToAddresses();

                        },
                      ),
                      Divider(
                        color: Color(0xffEEEEEE),
                      ),
                      ListTile(
                        leading: Icon(Icons.help,color: Color(0xff00ADB5),),
                        title: Text(
                          'FAQs',
                          style: TextStyle(
                              color: Color(0xffEEEEEE), fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.power_settings_new,color: Color(0xff00ADB5),),
                        title: Text(
                          'Sign Out',
                          style: TextStyle(
                              color: Color(0xffEEEEEE), fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
//                          // Update the state of the app
//                          // ...
//                          FirebaseAuth.instance.signOut();
//                          updateLoggedIn();
//                          // Then close the drawer
                            model.signOutUser();
//                          Router.navigator.pushNamed(
//                            Router.loginPage,);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        viewModelBuilder: ()=> DashboardViewModel());
  }
}



class UserSearchDelegate extends SearchDelegate {

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = ThemeData.dark();
    assert(theme != null);
    return theme.copyWith(
        primaryColor: Colors.black,
        primaryIconTheme:
        theme.primaryIconTheme.copyWith(color: Constants.tealColor),
        primaryColorBrightness: Brightness.dark,
        textTheme: theme.textTheme.copyWith(
            title: theme.textTheme.title
                .copyWith(color: theme.primaryTextTheme.title.color)));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    if (query.length < 8) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",style: TextStyle(
                color: Colors.white
            ),
            ),
          )
        ],
      );
    }

    //Add the search term to the searchBloc.
    //The Bloc will then handle the searching and add the results to the searchResults stream.
    //This is the equivalent of submitting the search term to whatever search service you are using
//    InheritedBlocs.of(context)
//        .searchBloc
//        .searchTerm
//        .add(query);
//
//    return Column(
//      children: <Widget>[
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
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column(
//      children: <Widget>[Text("d")],
    );
  }
}

