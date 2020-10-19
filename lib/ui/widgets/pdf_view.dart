import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:store/app/locator.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/models/PushNotification.dart';
import 'package:store/services/local_notification_service.dart';


class PdfViewPage extends StatefulWidget {
  final String path;
  final String fileUrl;
  const PdfViewPage({Key key, this.path, this.fileUrl}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;
  bool downloading = false;
  var progressString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice PDF"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Constants.lightBlackColor.withOpacity(1.0),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: PDFView(
              filePath: widget.path,
              autoSpacing: true,
              enableSwipe: true,
              pageSnap: true,
              swipeHorizontal: true,
              nightMode: false,
              onError: (e) {
                print(e);
              },
              onRender: (_pages) {
                setState(() {
                  _totalPages = _pages;
                  pdfReady = true;
                });
              },
              onViewCreated: (PDFViewController vc) {
                _pdfViewController = vc;
              },
              onPageChanged: (int page, int total) {
                setState(() {});
              },
              onPageError: (page, e) {},
            ),
          ),
          !pdfReady
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Offstage(),
          downloading
              ? Center(
                child: Container(
            height: 120.0,
            width: 200.0,
            child: Card(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Downloading File: $progressString",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
            ),
          ),
              )
              : Container(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0
              ? FloatingActionButton.extended(
            backgroundColor: Colors.red,
            label: Icon(Icons.arrow_back_ios),
            onPressed: () {
              _currentPage -= 1;
              _pdfViewController.setPage(_currentPage);
            },
          )
              : Offstage(),
          _currentPage+1 < _totalPages
              ? FloatingActionButton.extended(
            backgroundColor: Constants.tealColor,
            label: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              _currentPage += 1;
              _pdfViewController.setPage(_currentPage);
            },
          )
              : Offstage(),
          FloatingActionButton.extended(
            backgroundColor: Colors.black,
            label: Icon(Icons.file_download),
            onPressed: () {
              downloadFile(widget.fileUrl);
            },
          ),
        ],
      ),
    );
  }

  void downloadFile(fileUrl) async{

    PermissionStatus permission = await Permission.storage.request();
    if(permission.isGranted){
      try {
        var dir = await getExternalStorageDirectory();
        print(dir.path + Platform.pathSeparator + 'Download');
        var data = await Dio().download(fileUrl,"/storage/emulated/0/Download/invoice.pdf",onReceiveProgress: (rec,total){
          setState(() {
            downloading = true;
            progressString = ((rec/total)*100).toStringAsFixed(0)+"%";
          });
        });
        print(data.data.toString());

      } catch (e) {
        print(e);
        throw Exception("Error opening url file");
      }

      setState(() {
        downloading = false;
        progressString = "Completed";
      });
      LocalNotificationService _l = locator<LocalNotificationService>();
      var message = {
        "notification": {"title":"Pdf","body":"downloaded"},
        "data": {}
      };
      var f = PushNotification.fromJson(new Map<String, dynamic>.from({
        "notification":new Map<String, dynamic>.from(message["notification"]),
        "data": new Map<String, dynamic>.from(message["data"])
      }));
      _l.showNotification(notification: f.notification);
    }else{
      print("Permission denied");
    }

  }
}