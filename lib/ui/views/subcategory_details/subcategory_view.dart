import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/ui/views/subcategory_details/subcategory_viewModel.dart';

class SubCategoryView extends StatelessWidget {
  String categoryTitle;
  SubCategoryView({
    @required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubCategoryViewModel>.reactive(
        onModelReady: (model) => model.initialiseCategory(categoryTitle),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(categoryTitle),
              ),
              backgroundColor: Colors.black,
              body: model.isBusy && model.subCategories.length == 0
                  ? Center(child: Text("Loading...",style: TextStyle(color: Colors.white),))
                  : model.subCategories.length == 0
                      ? Center(
                          child: Text(
                            "Coming Soon...",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : ListView.builder(
                          itemCount: model.subCategories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: ExpansionTile(
                                    leading: Icon(Icons.person),
                                    title: Text(
                                      model.subCategories[index],
                                      style: TextStyle(
                                          color: Constants.offWhiteColor),
                                    ),
                                    children: <Widget>[
                                      ListTile(
                                        title: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "item 1",
                                            style: TextStyle(
                                                color: Colors.white70),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "item 2",
                                            style: TextStyle(
                                                color: Colors.white70),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            );
                          },
                        ),
            ),
        viewModelBuilder: () => SubCategoryViewModel());
  }
}
