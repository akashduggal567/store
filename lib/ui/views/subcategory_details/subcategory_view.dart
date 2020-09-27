import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/models/category.dart';
import 'package:store/ui/views/subcategory_details/subcategory_viewModel.dart';

class SubCategoryView extends StatelessWidget {
  Category categoryDetails;
  SubCategoryView({
    @required this.categoryDetails,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubCategoryViewModel>.reactive(
        onModelReady: (model) => model.initialiseCategory(categoryDetails),
        builder: (context, model, child) => WillPopScope(
          onWillPop:() {
            model.navigateToDashboard();
            return Future.value(false);
          },
          child: Scaffold(
                appBar: AppBar(
                  title: Text(categoryDetails.name),
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
                              return expansionTile(model: model,index: index,categoryDetails: categoryDetails,);
                            },
                          ),
              ),
        ),
        viewModelBuilder: () => SubCategoryViewModel());
  }
}



class expansionTile extends StatelessWidget {
  SubCategoryViewModel model;
  int index;
  Category categoryDetails;
  expansionTile({
    this.model, this.index, this.categoryDetails
  });
  List<Widget> _getChildren(subCategory) {

    List<Widget> children = [];
    model.subChildCategories.forEach((subChildCategory) {

      if(subChildCategory.parentCategoryIds.contains(subCategory.id)){
        children.add(
          InkWell(
            onTap: (){
              model.navigateToProductListView([categoryDetails.id,subCategory.id, subChildCategory.id],);
            },
            child: ListTile(
              title: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  subChildCategory.name,
                  style: TextStyle(
                      color: Colors.white70),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
        );
      }
    });
    return children;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ExpansionTile(
            leading: Icon(Icons.person),
            title: Text(
              model.subCategories[index].name,
              style: TextStyle(
                  color: Constants.offWhiteColor),
            ),
            children: _getChildren(model.subCategories[index]),
//            children: <Widget>[
//              InkWell(
//                onTap: (){
////                                          print(model.subCategories[index].parentCategoryIds);
////                                          print(model.subCategories[index].where((i)=>i.parentCategoryIds==categoryDetails.id).toList());
//                  print(categoryDetails.id);
//                  print(model.subCategories[index].id);
//                  print("clicked item of " + index.toString());
//                  model.navigateToProductListView([categoryDetails.id,model.subCategories[index].id]);
//                },
//                child: ListTile(
//                  title: Container(
//                    margin: EdgeInsets.only(left: 10),
//                    child: Text(
//                      "item 1",
//                      style: TextStyle(
//                          color: Colors.white70),
//                      textAlign: TextAlign.left,
//                    ),
//                  ),
//                ),
//              ),
//              ListTile(
//                title: Container(
//                  margin: EdgeInsets.only(left: 10),
//                  child: Text(
//                    "item 2",
//                    style: TextStyle(
//                        color: Colors.white70),
//                    textAlign: TextAlign.left,
//                  ),
//                ),
//              ),
//            ]



        ),
      ),
    );
  }
}
