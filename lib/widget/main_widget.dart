import 'package:flutter/material.dart';

import 'package:sub_downloader/services/apis.dart';
import 'package:sub_downloader/widget/subtitle_listview.dart';
import 'package:sub_downloader/widget/tvshow_section.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key key, @required this.provider}) : super(key: key);

  final MyProviders provider;

  void search(s, ep, se) async {
    print(s + ep + se);
    provider.toogleLoading();
    await provider.getData(s, ep, se);
    provider.toogleLoading();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 20),
              child: TextField(
                textInputAction: TextInputAction.search,
                style: TextStyle(
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
                controller: _textController,
                onSubmitted: (s) async {
                  search(s, '', '');
                },
                decoration: InputDecoration(
                  prefix: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: provider.isMovie
                      ? "Enter your movie title"
                      : "Enter your tvShow title",
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            provider.isMovie
                ? Container()
                : TvShowSection(
                    textEditingController: _textController,
                    provider: provider,
                    search: search,
                  ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 20,
            ),
            provider.isLoading
                ? CircularProgressIndicator()
                : provider.errMSG != ""
                    ? Text(
                        provider.errMsg,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    : SubtitleListViewWidget(provider: provider)
          ],
        ),
      ),
    );
  }
}
