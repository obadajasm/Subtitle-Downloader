import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sub_downloader/services/apis.dart';

class SubtitleListViewWidget extends StatelessWidget {
  const SubtitleListViewWidget({
    Key key,
    @required this.provider,
  }) : super(key: key);

  final MyProviders provider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: provider.items == null ? 0 : provider.items.length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () async {
              var tempDir = await DownloadsPathProvider.downloadsDirectory;

              await Directory(tempDir.path + "/SubDownloader").create();
              String fullPath = tempDir.path +
                  "/SubDownloader/${provider.items[index]['SubFileName']}'";

              print('full path $fullPath');

              await provider.download2(
                provider.items[index]['ZipDownloadLink'],
                fullPath,
              );
              if (provider.errMSG.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Subtitle Saved in $fullPath",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Center(
              child: Card(
                color: Color(0xffdbdbdb),
                //Color(0xffffbd69),
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(55.0),
                  ),
                ),
                elevation: 7,
                child: ListTile(
                  trailing: Text(
                      (int.parse(provider.items[index]['SubSize']) / 1024)
                              .floor()
                              .toString() +
                          "K"),
                  title: Center(
                    child: Text(
                      provider.items == null
                          ? ""
                          : "${provider.items[index]['SubFileName']}",
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
