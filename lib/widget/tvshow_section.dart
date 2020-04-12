import 'package:flutter/material.dart';
import 'package:sub_downloader/services/apis.dart';

class TvShowSection extends StatelessWidget {
  TvShowSection(
      {Key key, this.textEditingController, this.provider, this.search})
      : super(key: key);
  final TextEditingController textEditingController;
  final MyProvider provider;
  final Function search;
  @override
  Widget build(BuildContext context) {
    TextEditingController _textController2 = TextEditingController();
    TextEditingController _textController3 = TextEditingController();

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              child: TextField(
                textInputAction: TextInputAction.search,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26),
                controller: _textController2,
                keyboardType: TextInputType.number,
                onSubmitted: (s) async {
                  search(textEditingController.text, _textController2.text,
                      _textController3.text);
                },
                decoration: InputDecoration(
                  hintText: "Season num",
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 150,
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (s) async {
                  search(textEditingController.text, _textController2.text,
                      _textController3.text);
                },
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26),
                keyboardType: TextInputType.number,
                controller: _textController3,
                decoration: InputDecoration(
                  hintText: "Episod num",
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        provider.isLoading
            ? Container()
            : FlatButton(
                color: Color(0xffffbd69),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                onPressed: () {
                  search(textEditingController.text, _textController2.text,
                      _textController3.text);
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: 100,
                    child: Center(
                        child: Text(
                      "Search",
                      style: TextStyle(fontSize: 25),
                    ))),
              ),
      ],
    );
  }
}
