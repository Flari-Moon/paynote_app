import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/services/SharedPrefService.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paynote_app/services/TwilioService.dart';

class PhoneVerificationViewModel extends BaseViewModel {
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';
  bool validNumber = false;
  NavigationService _navigationService = locator<NavigationService>();
  TwilioService _twilioService = locator<TwilioService>();

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

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    phoneNumber = number;
    phoneIsoCode = isoCode;
    notifyListeners();
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    visible = true;
    confirmedNumber = internationalizedPhoneNumber;
    notifyListeners();
  }

  replaceWithPin() {
    _navigationService.replaceWith(Routes.otpVerificationView,
        arguments: OtpVerificationViewArguments(
            phoneNumber: phoneNumber, isoCode: phoneIsoCode));
  }

  void sendSMS(BuildContext context, String title) async {
   // replaceWithPin();
     setBusy(true);
    if(title.contains("welcome")){
      //get the user name abased on the mobile numer
      notifyListeners();

    }
    // setBusy(true);
  bool smsSent= await _twilioService.sendOTPService(context,phoneNumber);
  if(smsSent){
    setBusy(false);
    replaceWithPin();
  }
  else{
    setBusy(false);
    //do something
  }
  }
}
