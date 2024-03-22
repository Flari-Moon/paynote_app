import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/services/SharedPrefService.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/utils/Response.dart';
import 'package:paynote_app/utils/serverError.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import 'package:paynote_app/models/OverlayLoadingScreens/OverlaysForLoading.dart';

class LoginViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  RequestService requestService = locator<RequestService>();
  bool pinError = false;
  User user = new User();
  final TextEditingController controller = TextEditingController();
  SharedPreferences prefs;
  String phoneNumber;

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
  }

  void getUserByPhoneNumber(BuildContext context) async {
    setBusy(true);
    print('phonenumberrrrr $phoneNumber');
    user = await requestService.getUserByPhoneNumber(phoneNumber, context);
    setBusy(false);
    if (user != null) {
      print('response $user');
      goToLoginCode();
    } else {
      print('no resp $user');
      verifyPhoneNumber();
    }
  }

  void verifyPhoneNumber() {
    //_navigationService.replaceWith(Routes.manageYourAccessView);
    _navigationService.replaceWith(Routes.phoneVerificationView,
        arguments: PhoneVerificationViewArguments(
            title: 'Get started with Paynote',
            subTitle:
                'Please confirm your country code. Paynote will send a code to verify your phone number'));
  }

  goToLoginCode() {
    _navigationService.replaceWith(Routes.loginCodeView,
        arguments: LoginCodeViewArguments(user: user));
  }
}
