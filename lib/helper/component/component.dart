import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';


class Buttonhelper extends StatelessWidget {
  Buttonhelper({this.onchange,this.title});
  String ?title;
  VoidCallback ?onchange;

  bool isDark = darkNotifier.value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 400,
      decoration: BoxDecoration(
          color:  isDark
              ? Colors.white70
              : Colors.lightBlue.shade200,
          borderRadius: BorderRadius.circular(60)
      ),
      child: MaterialButton(
          onPressed: onchange,


          child: Center(

            child: Text(
                title!,style:
            GoogleFonts.eduNswActFoundation(
                fontWeight: FontWeight.bold,fontSize: 20)),)
      ),


    );
  }
}


void navigatorTo(context, Widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) => false);
}

dynamic uId = '';

Widget textEdit({
  required String text,
  double fontSize =20,
   Color color =Colors.black,
}) =>
    Text(
      text,
      style: GoogleFonts.cairo(
        fontSize: fontSize,
        color: color ,
      ),
    );
Widget nameEdit({
  required String text,
  double fontSize = 22,
  Color color =Colors.black,
}) =>
    Text(
      text,
      style: GoogleFonts.sourceSansPro(
        fontSize: fontSize,
        color: color,
      ),
    );
Widget timeEdit({
  required String text,
   double fontSize =16,
   Color color = Colors.black38,
}) =>
    Text(
      text,
      style: GoogleFonts.tillana(
        fontSize: fontSize,
        color: color,
      ),
    );
