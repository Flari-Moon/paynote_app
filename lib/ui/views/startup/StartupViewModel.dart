import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/services/SharedPrefService.dart';
import 'package:paynote_app/utils/SharedPref.dart';
//import 'package:paynote_app/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paynote_app/services/FirebaseNotificationService.dart';

class StartupViewModel extends BaseViewModel {
  Language userLanguage;
  var pageLanguageData;
  SharedPrefService _sharedPrefService = locator<SharedPrefService>();

  NavigationService _navigationService = locator<NavigationService>();
  final FirebaseNotificationService _pushNotificationService =
      locator<FirebaseNotificationService>();

  void handleStarupLogic() async {
    bool isLoggedIn = true; // implement logic for checking user logged in
    Future.delayed(Duration(seconds: 3), () {
      if (isLoggedIn) {
        _navigationService.replaceWith(Routes.homeView);
      } else {
        _navigationService.replaceWith(Routes.loginView);
      }
    });
  }

  initLanguage() {
    //userLanguage = _sharedPrefService.loadProfileLanguage();

    pageLanguageData = json.decode(SharedPref().getString('translationTag'));
    userLanguage = Language(language: SharedPref().getString('language'));

    // print(userLanguage.language);
    // print('USER LANGUAGE: ${(SharedPref().getString('language'))}');
    // print(
    //     "THIS PRINT" + pageLanguageData["SIN-0-30"][0][userLanguage.language]);
  }

  void verifyPhoneNumber() {
    //_navigationService.replaceWith(Routes.manageYourAccessView);
    _navigationService.replaceWith(Routes.phoneVerificationView,
        arguments: PhoneVerificationViewArguments(
            title: 'Get started with Paynote',
            subTitle:
                'Please confirm your country code. Paynote will send a code to verify your phone number'));
  }

  void goToLogin() {
    _navigationService.replaceWith(Routes.loginView);
  }
}
