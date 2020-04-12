import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class MyProviders with ChangeNotifier {
  List<dynamic> responseBody;
  bool isLoading = false;
  bool isDownloading = false;
  String errMsg = "";
  String per = "0 %";
  String lang = "ara";
  bool isMovie = true;
  var id;

  Future<void> getData(String moviename, String ep, String se) async {
    try {
      if (!isMovie && (ep == '' || se == '') || moviename == '') {
        return;
      }
      clearData();
      await getid(moviename);

      isMovie ? await getSub(id) : await getTvSub(id, ep, se);

      notifyListeners();
    } catch (e) {
      errMsg = "somthing went Wrong please try again ......";
    }
  }

  String get errMSG {
    return errMsg;
  }

  void toogleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void toogleisDownloading() {
    isDownloading = !isDownloading;
    notifyListeners();
  }

  void toogleisMovie() {
    isMovie = !isMovie;
    notifyListeners();
  }

  List<dynamic> get items {
    return responseBody;
  }

  Future<void> getid(String moviename) async {
    try {
      Dio dio = Dio();
      Response res = await dio.get(
        "http://www.omdbapi.com/?t=$moviename&apikey=4b25eb47",
      );
      id = res.data['imdbID'];
      print(id.toString());
    } catch (e) {}
  }

  Future<void> getSub(id) async {
    print("getSub");

    try {
      HttpClient client = new HttpClient();
      // String s = '';
      client.userAgent = 'obadasub';

      HttpClientRequest request = await client.getUrl(Uri.parse(
          "http://rest.opensubtitles.org/search/imdbid-$id/sublanguageid-$lang"));
      HttpClientResponse response = await request.close();
      var result = new StringBuffer();
      await for (var contents in response.transform(Utf8Decoder())) {
        result.write(contents);
      }
      responseBody = jsonDecode(result.toString());
    } on DioError catch (e) {
      errMsg = e.toString();
    }
  }

  String get pers {
    return per;
  }

  Future<void> download2(String url, String savePath) async {
    var per = await Permission.storage.request();

    if (per.isGranted) {
      toogleisDownloading();
      try {
        Response response = await Dio().get(
          url,
          onReceiveProgress: (received, total) {
            showDownloadProgress(received, total);
          },
          //Received data with List<int>
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }),
        );
        // print(response.headers);
        File file = File(savePath);
        var raf = file.openSync(mode: FileMode.write);
        // response.data is List<int> type
        raf.writeFromSync(response.data);
        await raf.close();
      } catch (e) {
        errMsg = e;
      }

      toogleisDownloading();
      notifyListeners();
    } else {
      errMsg =
          "we need Storage permission to download subtitles to your device ...";
      notifyListeners();
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
      per = (received / total * 100).toStringAsFixed(0) + "%";
      notifyListeners();
    }
  }

  Future<void> getTvSub(id, ep, se) async {
    print("getTvSub");
    HttpClient client = new HttpClient();
    client.userAgent = 'obadasub';

    HttpClientRequest request = await client.getUrl(Uri.parse(
        "https://rest.opensubtitles.org/search/episode-$ep/imdbid-$id/season-$se/sublanguageid-$lang"));
    HttpClientResponse response = await request.close();

    var result = new StringBuffer();
    await for (var contents in response.transform(Utf8Decoder())) {
      result.write(contents);
    }
    responseBody = jsonDecode(result.toString());
  }

  void clearData() {
    if (responseBody != null) responseBody.clear();
    errMsg = '';
  }

  List<String> get langList {
    return ["ara", "eng", "fra", "ger"];
  }

  String get language {
    return lang;
  }

  set language(String s) {
    lang = s;
    notifyListeners();
  }
}
