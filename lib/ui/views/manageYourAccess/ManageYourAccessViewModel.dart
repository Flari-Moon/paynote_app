import 'dart:convert';

import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/services/SharedPrefService.dart';
import 'package:stacked/stacked.dart';

import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';

import 'package:stacked_services/stacked_services.dart';

import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:paynote_app/models/OverlayLoadingScreens/OverlaysForLoading.dart';
import 'package:paynote_app/utils/SharedPref.dart';

class ManageYourAccessViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  int _pageIndex = 0;
  var pinCodeType = 1;
  String pincode1 = '';
  String pincode2 = '';
  bool pinError = false;
  int get pageIndex => _pageIndex;
  User responseUser = new User();
  DialogService _dialogService = locator<DialogService>();
  RequestService requestService = locator<RequestService>();
  TextEditingController _pinPutController = TextEditingController();
  TextEditingController get pinPutController => _pinPutController;
  bool pinCodeSet = false;

  void setIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }

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

  checkPin(String pin, User user, BuildContext context) {
    if (pinCodeType == 1) {
      pinCodeType++;
      pincode1 = pin;
      pinPutController.clear();
      notifyListeners();
    } else if (pinCodeType == 2) {
      pinCodeType++;
      pincode2 = pin;
      if (pincode1 != pincode2) {
        pinError = !pinError;
        pinCodeType = 1;
        notifyListeners();
      } else {
        user.pinCode = pin;
        setUpPin(user, context);
      }
    }
    print("CODE 1 $pincode1");
    print("CODE 2 $pincode2");
  }

  void setUpPin(User user, BuildContext context) async {
    setBusy(true);
    pinCodeSet = true;
    setPinPref();
    responseUser = await requestService.setUpPin(user, context);
    print(responseUser);

    setBusy(false);
    /*showOver2(context);
    hideOver();*/
    if (responseUser != null) {
      goToDashboard(responseUser);
    } else {
      // _dialogService.showDialog(title: 'Ops',description: 'Something went wrong');
      setBusy(false);
      notifyListeners();
    }
  }

  goToDashboard(User abc) {
    _navigationService.clearStackAndShow(Routes.dashboardView,
        arguments: DashboardViewArguments(user: abc));
  }

  Future showError(String error) async {
    await _dialogService.showDialog(
      title: 'Error',
      description: error,
    );
  }

  setPinPref() {
    initLanguage();
    SharedPref().setBool('pinCodeSet', pinCodeSet);
  }
}
