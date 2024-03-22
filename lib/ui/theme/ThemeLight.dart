import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'package:flutter_screenutil/size_extension.dart';

class LightTheme {
  ThemeData getTheme() => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
     //   primarySwatch: AppColors.primarySwatch,
        // change scaffold background color according to your need
        brightness: Brightness.light,
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
        // Change text font sizes and color according to your need
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
