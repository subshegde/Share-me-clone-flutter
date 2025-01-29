import 'package:flutter/material.dart';
import 'package:sub_share_me/utils/helper.dart';

class AppColors {
  AppColors._();

  static const int primaryColor = 0xff6ACAC6;
  static const int primaryColorDark = 0xff08ACA5;

  static MaterialColor primaryMaterialColor =
      getSwatch(const Color.fromARGB(255, 0, 0, 0));
  static MaterialColor primaryMaterialColorDark =
      getSwatch(const Color.fromARGB(255, 4, 6, 6));

  static const int secondaryColor = 0xff3544C4;

  static const Color grey100Color = Color(0xFFEEEEEE);
  static const Color grey200Color = Color(0xFFEEEEEE);
  static const Color grey300Color = Color(0xFFE0E0E0);
  static const Color grey400Color = Color(0xFFBDBDBD);
  static const Color grey500Color = Color(0xFF9E9E9E);
  static const Color grey600Color = Color(0xFF757575);
  static const Color grey700Color = Color(0xFF616161);
  static const Color grey800Color = Color(0xFF424242);
  static const Color grey900Color = Color(0xFF212121);

  static const Color red = Color(0xFFD50000);
  static const Color yellow = Color.fromARGB(255, 255, 193, 7);
  static const Color peacockGreen = Color.fromARGB(255, 11, 116, 14);
  static const Color green = Color.fromARGB(255, 40, 167, 69);
  static const Color receive = Color.fromARGB(255, 54, 202, 86);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color tranperent = Color.fromARGB(0, 0, 0, 0);

  static const Color purple = Color.fromARGB(255, 111, 66, 193);
  static const Color blue = Colors.blue;
  static const Color grey = Colors.grey;
  static const Color navyBlue = Color.fromARGB(255, 25, 61, 118);
  static const Color darkBlue = Color.fromARGB(255, 0, 140, 255);
  static const Color white = Colors.white;
  static const Color containerGrey = Color.fromARGB(255, 26, 25, 25);
  static const Color containerGreyBorder = Color.fromARGB(255, 39, 39, 39);
  static const Color dimWhite = Color.fromARGB(255, 216, 215, 215);

  static const Color bg =  Color.fromARGB(255, 20, 20, 20);


}
