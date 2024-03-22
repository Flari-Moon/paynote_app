import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paynote_app/services/SharedPrefService.dart';

class AccessCodeViewModel extends BaseViewModel {
  bool isPinSet = false;
  bool showPinScreen = false;
  final _sharedPrefService = locator<SharedPrefService>();
  int _pageIndex = 0;
  var pinCodeType = 1;
  String pincode1 = '';
  String pincode2 = '';
  bool pinError = false;
  int get pageIndex => _pageIndex;
  User responseUser = new User();
  User user = new User();
  NavigationService _navigationService = locator<NavigationService>();
  RequestService requestService = locator<RequestService>();
  TextEditingController _pinPutController = TextEditingController();
  TextEditingController get pinPutController => _pinPutController;

  Language userLanguage;
  var pageLanguageData;

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

  void getPinStatus() {
    isPinSet = SharedPref().getBool('pinCodeSet');
    print('niyial $isPinSet');
    user = _sharedPrefService.loadProfileUser();
  }

  void setIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  void setToggle(bool index) {
    isPinSet = index;
    print('set toggle $isPinSet');
    notifyListeners();
  }

  checkPin(String pin, BuildContext context) {
    if (pinCodeType == 1) {
      pinCodeType++;
      pincode1 = pin;
      pinPutController.clear();
      notifyListeners();
    } else if (pinCodeType == 2) {
      pinCodeType++;
      pincode2 = pin;
      if (pincode1 != pincode2) {
        pinPutController.clear();
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
    isPinSet = true;
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

  setPinPref() {
    SharedPref().setBool('pinCodeSet', isPinSet);
  }

  goToDashboard(User abc) {
    _navigationService.replaceWith(Routes.dashboardView,
        arguments: DashboardViewArguments(user: abc));
  }
}
