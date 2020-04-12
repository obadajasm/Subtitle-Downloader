import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.info),
        onPressed: () {
          showDialog(
              context: context,
              child: AlertDialog(
                backgroundColor: Color(0xFF202040),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34),
                ),
                contentPadding: EdgeInsets.all(2),
                content: Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      final Email email = Email(
                        body: '',
                        subject: '',
                        recipients: ['obadajasm0@gmail.com'],
                      );
                      await FlutterEmailSender.send(email);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Author",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xffffbd69)),
                        ),
                        Text(
                          "Obada jasm",
                          style:
                              TextStyle(fontSize: 40, color: Color(0xffffbd69)),
                        ),
                        Text(
                          "obadajasm0@gmail.com",
                          style: GoogleFonts.lato(color: Color(0xffffbd69)),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
