import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:paynote_app/ui/App.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'app/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  setupLocator();
  initializeDateFormatting();
  Firebase.initializeApp();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US')],
      path: 'Assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}
