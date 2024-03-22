import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/services/SharedPrefService.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginCodeViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  bool pinError = false;
  User userPass = new User();

  TextEditingController textEditingController = TextEditingController();

  Language userLanguage;
  var pageLanguageData;
  SharedPrefService _sharedPrefService = locator<SharedPrefService>();

  initLanguage() {
    //userLanguage = _sharedPrefService.loadProfileLanguage();

    pageLanguageData = json.decode(SharedPref().getString('translationTag'));
    userLanguage = Language(language: SharedPref().getString('language'));

    // print(userLanguage.language);
    // print('USER LANGUAGE: ${(SharedPref().getString('language'))}');
    // print(
    //     "THIS PRINT" + pageLanguageData["SIN-0-30"][0][userLanguage.language]);
    notifyListeners();
  }

  verifyPin(String pin, User user) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String base64Pin = stringToBase64.encode(pin);
    if (user.pinCode == base64Pin) {
      userPass = user;
      goToDashboard();
    } else {
      pinError = true;
      textEditingController = null;
      textEditingController = new TextEditingController();

      notifyListeners();
    }
  }

  goToDashboard() {
    _navigationService.clearStackAndShow(Routes.dashboardView,
        arguments: DashboardViewArguments(user: userPass));
  }
}
