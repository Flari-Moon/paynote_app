import 'dart:async';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:convert';
import 'dart:convert' as JSON;
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:paynote_app/services/FirebaseNotificationService.dart';
import 'package:paynote_app/services/SharedPrefService.dart';

class CheckStatusViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  User user = new User();
  var language;
  bool pinSet = false;
  final RequestService _requestService = locator<RequestService>();
  final FirebaseNotificationService _pushNotificationService =
      locator<FirebaseNotificationService>();
  final _sharedPrefService = locator<SharedPrefService>();

  Future loadLanguageLocal() async {
    final myData = await rootBundle
        .loadString("Assets/translations/TranslationTagsFinal.csv");

    List<List<dynamic>> csvTable =
        CsvToListConverter(fieldDelimiter: ';').convert(myData);

    //print("CSV TABLE AS JSON" + (csvTable).toString());


    ///test codemagic build
    var string = '{';
    for (var i in csvTable) {
      string = string +
          """"${i[0]}": [{"EN-US": "${i[1]}","PT-BR":"${i[2]}", "NL": "${i[3]}"}],""";
    }
    string = string + ' "end":"end"}';

    //currentLanguage.language = textEditingControllerLanguage.text;
    //  SharedPref().setString('language', jsonEncode('EN-US'));
    SharedPref().setString('translationTag', (string));

    try {
      language = _sharedPrefService.loadProfileLanguage();
      print("language collected successfully: $language");
    } catch (e) {
      SharedPref().setString('language', ('NL'));
    }
    //language = _sharedPrefService.loadProfileLanguage().language;

    print("CIURRENT TRANSLATIONS INIT LOAD:$string");
    print("CIURRENT LANGUAGE INIT LOAD: ${language}");
  }

  handleStartupLogic() async {
    await SharedPref().init();
    await _pushNotificationService.initialize();

    Timer(Duration(seconds: 2), () async {
      String phoneNumber = SharedPref().getString("phoneNumber");
      pinSet = SharedPref().getBool('pinCodeSet');

      await loadLanguageLocal();
      if (phoneNumber != null) {
        user = _sharedPrefService.loadProfileUser();

        if (pinSet != null) {
          if (pinSet) {
            goToLoginCode(user);
          } else {
            goToDashboard(user);
            //gotodashboard directly

          }
        } else {
          SharedPref().setBool('bankAccounts', false);
          _navigationService.replaceWith(Routes.startupView);
        }
      } else {
        SharedPref().setBool('bankAccounts', false);
        _navigationService.replaceWith(Routes.startupView);
      }
    });
  }

  goToLoginCode(User u) {
    _navigationService.replaceWith(Routes.loginCodeView,
        arguments: LoginCodeViewArguments(user: u));
  }

  goToDashboard(User abc) {
    print('dfsfvd $abc');
    _navigationService.replaceWith(Routes.dashboardView,
        arguments: DashboardViewArguments(user: abc));
  }
}
