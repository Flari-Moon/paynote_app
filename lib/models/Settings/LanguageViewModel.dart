import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:stacked/stacked.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paynote_app/services/SharedPrefService.dart';
//=====
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:paynote_app/services/RequestService.dart';

class LanguageViewModel extends BaseViewModel {
  RequestService requestService = locator<RequestService>();
  String base64Image;
  File image_file;
  SharedPreferences prefs;
  //File image;

  Language userLanguage;
  var pageLanguageData;
  SharedPrefService _sharedPrefService = locator<SharedPrefService>();

  List<TransactionMainModel> transactionList = <TransactionMainModel>[];
  String userId;

  bool verificationEmail = false;
  bool verificationPending = false;
/*
  String inputName;
  String inputSurname;
  String inputEmail;*/
  String inputBirth;

  TextEditingController textEditingControllerLanguage;
  NavigationService _navigationService = locator<NavigationService>();

  // initLanguage() {
  //   userLanguage = _sharedPrefService.loadProfileLanguage();
  //   pageLanguageData = json.decode(SharedPref().getString('translationTag'));
  // }

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

  Future<Language> editLanguage(
      Language currentLanguage, BuildContext context) async {
    Language responseLanguage;
    // print("USER BING SENT: $currentUser");
    //  print(textEditingControllerBirth.text);
    print('current language being sent $currentLanguage');

    currentLanguage.language = textEditingControllerLanguage.text;

    print("trest USER being sent: $currentLanguage");
    // responseLanguage = await requestService.updateLanguage(currentLanguage, context);

    // userData = responseLanguage;

    print("RESPONSE USER: $responseLanguage");
    //userData = _sharedPrefService.loadProfileUser();

    notifyListeners();
  }

  Future<Language> editLanguageLocal(
      Language currentLanguage, BuildContext context) async {
    final myData = await rootBundle
        .loadString("Assets/translations/TranslationTagsFinal.csv");
    List<List<dynamic>> csvTable =
        CsvToListConverter(fieldDelimiter: ';').convert(myData);

    //print("CSV TABLE AS JSON" + (csvTable).toString());

    var string = '{';
    for (var i in csvTable) {
      string = string +
          """"${i[0]}": [{"EN-US": "${i[1]}","PT-BR":"${i[2]}", "NL": "${i[3]}"}],""";
    }
    string = string + ' "end":"end"}';

    //currentLanguage.language = textEditingControllerLanguage.text;
    //SharedPref().setString('language', jsonEncode(currentLanguage));

    SharedPref().setString('language', (currentLanguage.language));

    SharedPref().setString('translationTag', (string));

    print("CIURRENT TRANSLATIONS:$string");

    notifyListeners();
  }
}
