import 'package:flutter/material.dart';
import 'package:sub_downloader/services/apis.dart';

class ChooseLangWidget extends StatelessWidget {
  const ChooseLangWidget({
    Key key,
    @required this.text,
    @required this.provider,
  }) : super(key: key);

  final List<String> text;
  final MyProvider provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        List<Widget> textWiget = List<Widget>();
        text.forEach((element) {
          textWiget.add(
            GestureDetector(
              onTap: () {
                //
                provider.language = element;
                Navigator.pop(context);
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    element,
                    style: TextStyle(fontSize: 25, color: Color(0xffffbd69)),
                  ),
                ),
              ),
            ),
          );
        });
        showDialog(
          builder: (ctx) {
            return Container(
              height: 500,
              child: SimpleDialog(
                backgroundColor: Color(0xFF202040),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34),
                ),
                title: Column(
                  children: textWiget,
                ),
              ),
            );
          },
          context: context,
        );
      },
      child: Center(
        child: Row(
          children: <Widget>[
            Icon(Icons.language),
            SizedBox(
              width: 4,
            ),
            Text(
              provider.lang,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
