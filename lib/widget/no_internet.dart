import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Icon(
          Icons.signal_wifi_4_bar_lock,
          size: 200,
        ),
      ),
    );
  }
}
