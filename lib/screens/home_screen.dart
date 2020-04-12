import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_downloader/services/apis.dart';
import 'package:sub_downloader/widget/about_dialog.dart';
import 'package:sub_downloader/widget/choose_lang.dart';
import 'package:sub_downloader/widget/main_widget.dart';
import 'package:sub_downloader/widget/no_internet.dart';
import 'package:sub_downloader/widget/toogle_type.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var connectivityResult;
  StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      setState(() {
        connectivityResult = result;
      });
      print(result);
    });
    super.initState();
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }

  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);

    List<String> text = provider.langList;

    return Scaffold(
        appBar: AppBar(
          leading: AboutDialogWidget(),
          actions: <Widget>[
            ToogleTypeWidget(provider: provider),
            SizedBox(
              width: 15,
            ),
            ChooseLangWidget(text: text, provider: provider),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bac.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: provider.isDownloading
              ? AlertDialog(
                  backgroundColor: Color(0xFF202040),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34),
                  ),
                  content: Container(
                    height: 150.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          provider.per,
                          style:
                              TextStyle(fontSize: 25, color: Color(0xffffbd69)),
                        ),
                      ],
                    ),
                  ),
                )
              : connectivityResult == ConnectivityResult.none
                  ? NoInternetWidget()
                  : MainWidget(provider: provider),
        ));
  }
}
