import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:sub_downloader/screens/home_screen.dart';
import 'package:sub_downloader/services/apis.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MyProvider())],
      child: MaterialApp(
        theme: ThemeData(
          buttonColor: Color(0xffffbd69),
          iconTheme: IconThemeData(color: Color(0xffffbd69)),
          accentColor: Color(0xffffbd69),
          primaryColor: Color(0xFF202040),
          textTheme: GoogleFonts.iMFellDWPicaTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: Colors.black,
                  displayColor: Colors.black,
                ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
                decorationColor: Colors.red,
                color: Colors.black87,
                fontSize: 20),
            hintStyle: TextStyle(
                decorationColor: Colors.red,
                color: Colors.black87,
                fontSize: 20),
          ),
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Color(0xffffbd69)),
              textTheme: GoogleFonts.hennyPennyTextTheme(
                Theme.of(context).textTheme.apply(
                      bodyColor: Color(0xffffbd69),
                    ),
              )),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
