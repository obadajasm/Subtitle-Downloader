import 'package:flutter/material.dart';
import 'package:sub_downloader/services/apis.dart';

class ToogleTypeWidget extends StatelessWidget {
  const ToogleTypeWidget({
    Key key,
    @required this.provider,
  }) : super(key: key);

  final MyProviders provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        provider.toogleisMovie();
        provider.clearData();
      },
      child: Center(
        child: Row(
          children: <Widget>[
            Icon(Icons.swap_horiz),
            SizedBox(
              width: 11,
            ),
            Text(
              provider.isMovie ? "Tv Show" : "Movie",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
