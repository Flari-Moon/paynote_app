import 'dart:async';
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

class OtpVerificationViewModel extends BaseViewModel {
  bool _otpVerified;
  bool get otpVerified => _otpVerified;
  String phoneNumber;
  String phoneIsoCode;
  TwilioService _twilioService = locator<TwilioService>();
  NavigationService _navigationService = locator<NavigationService>();
  int _secondsRemaining = 30;

  int get secondsRemaining => _secondsRemaining;
  bool enableResend = false;
  Timer timer;

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

  inIt() {
    initLanguage();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_secondsRemaining != 0) {
        print(_secondsRemaining);
        _secondsRemaining--;
        notifyListeners();
      } else {
        enableResend = true;
        notifyListeners();
      }
    });
  }

  void verify(BuildContext context, String otp) async {
    //goToSignUp();
    setBusy(true);
    _otpVerified = await _twilioService.verifyOTPService( context,phoneNumber, otp);
    if (otpVerified) {
      //do smethin
      //navigate to next page
      setBusy(false);
      goToSignUp();
      notifyListeners();
    }
    else {
      //do something
      setBusy(false);
      notifyListeners();
    }
  }

  void goToSignUp() {
    timer.cancel();
    _navigationService.replaceWith(Routes.signupView,
        arguments: SignupViewArguments(
            phoneNumber: phoneNumber, isoCode: phoneIsoCode));
  }

  goBack() {
    timer.cancel();
    _navigationService.replaceWith(Routes.phoneVerificationView,
        arguments: PhoneVerificationViewArguments(
            title: 'Get started with Paynote',
            subTitle:
                'Please confirm your country code. Paynote will send a code to verify your phone number'));
  }

  resendOtp(BuildContext context, String number) async {
    print('hello;');
     _secondsRemaining = 30;
    enableResend = false;
    notifyListeners();
    setBusy(true);
    bool smsSent= await _twilioService.sendOTPService(context,number);
    if(smsSent){
      setBusy(false);
    }
    else{
      setBusy(false);
    }
  }
}
