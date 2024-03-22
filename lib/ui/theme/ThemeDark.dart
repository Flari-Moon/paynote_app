import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'AppColors.dart';

class DarkTheme {
  ThemeData getTheme() => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //primarySwatch: AppColors.primarySwatch,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          // change app bar color according to you need
          color: Colors.transparent,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 54.nsp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 80.nsp, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 58.nsp, fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 48.nsp, fontWeight: FontWeight.bold),
          subtitle1: TextStyle(fontSize: 38.nsp, fontWeight: FontWeight.w600),
          bodyText1: TextStyle(fontSize: 43.nsp, fontWeight: FontWeight.w600),
          bodyText2: TextStyle(fontSize: 32.nsp),
        ),
      );
}
