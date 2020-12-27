import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/enums/connectivity_status.dart';
import 'package:store/ui/views/offline_view/offline_viewModel.dart';

class OfflineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OfflineViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model,child)=>WillPopScope(
          onWillPop: () => Future.value(false),
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text("Sorry"),
              leading: Container(),
            ),
            body: model.connectivityStatus == ConnectivityStatus.WiFi ? model.navigateToDashboard(): Center(child: Text("No Internet Connection",style: TextStyle(color: Colors.white70),)),
          ),
        ),
        viewModelBuilder: ()=> OfflineViewModel());
  }
}
