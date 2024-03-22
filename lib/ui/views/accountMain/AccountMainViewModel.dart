import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/ui/views/accountMain/AccountMainView.dart';
import 'package:stacked/stacked.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paynote_app/Api/AccountsModel.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'dart:convert';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/services/SharedPrefService.dart';

class AccountMainViewModel extends BaseViewModel {
  bool bankAccounts;
  NavigationService _navigationService = locator<NavigationService>();
  RequestService requestService = locator<RequestService>();
  List<AccountsModel> accounts = [];
  double totalBalance = 0.0;
  bool accountDeleted = false;
  String userId;
  final _sharedPrefService = locator<SharedPrefService>();

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

  getUserAccounts(BuildContext context) async {
    //  SharedPref().setString('userId','c639132b3af543438885068c0cb897ad');// to test run the application without tink
    setBusy(true);
    accounts = _sharedPrefService.userAccountsFromPrefs();
    userId = SharedPref().getString('userId');
    bankAccounts = SharedPref().getBool('bankAccounts');
    if (bankAccounts == null) {
      bankAccounts = false;
    }
    /* bool accountDeleted = SharedPref().getBool("bankAccountDeleted");
    if(accountDeleted!=null){
      if(accountDeleted) {
        getAccounts(context);
      }
    }*/
    //userId = 'c639132b3af543438885068c0cb897ad';
    print('we are here');
    setBusy(true);
    if (accounts == null && userId != null) {
      print('debug : $userId');
      print('getting new accounta');
      accounts = await requestService.getUserAccounts(userId, context);
      if (accounts != null) {
        print('debug : $bankAccounts');
        print('debug : ${accounts.toString()}');
        bankAccounts = true;
        totalAmount();
      }
      //notifyListeners();
    } else {
      if (accounts != null) {
        print('suppp55');
        bankAccounts = true;
        totalAmount();
      } else {
        bankAccounts = false;
        SharedPref().setBool('bankAccounts', false);
      }
    }
    bool updateBalance = SharedPref().getBool("updateAccountNeeded");
    if (updateBalance != null) {
      if (updateBalance) {
        getAccounts(context);
      }
    }

    setBusy(false);
    notifyListeners();
  }

  getAccounts(BuildContext context) async {
    //setBusy(true);
    if (accounts != null) {
      accounts.clear();
    }
    /* for(var v in accounts) {
     double balance=await requestService.getAccountBalance(userId,v.accountId, context);
     if(balance!=null) {
       v.balance = balance;
     }
     accounts.add(v);
    }*/
    accounts = await requestService.getUserAccounts(userId, context);
    /* List<String> savedPrefsJson = [];
    for (AccountsModel savedPref in accounts) {
      String savedPrefJson = jsonEncode(savedPref);
      savedPrefsJson.add(savedPrefJson);
    }
    SharedPref().setBool('bankAccounts', true);
    SharedPref().setStringList("accounts", savedPrefsJson);*/
    SharedPref().setBool('bankAccountDeleted', false);
    SharedPref().setBool('updateAccountNeeded', false);
    totalAmount();
    //setBusy(false);
    //notifyListeners();
  }

  void totalAmount() {
    if (accounts != null) {
      var value = totalBalance;
      for (var i in accounts) {
        value = i.balance + value;
      }
      totalBalance = value;
      SharedPref().setString('balance', totalBalance.toString());
    }
  }

  viewAccountDetails(int i, File imageFile) {
    AccountsModel accountModel = accounts[i];
    Map<String, dynamic> userMap;
    final String userStr = SharedPref().getString('user');
    if (userStr != null) {
      userMap = jsonDecode(userStr) as Map<String, dynamic>;
    }
    final User user = User.fromJson(userMap);
    _navigationService.navigateTo(Routes.accountsDetailView,
        arguments: AccountsDetailViewArguments(
            account: accountModel, user: user, imageFile: imageFile));
  }

  void setAccountDeleted(bool accountDeleted) {
    this.accountDeleted = accountDeleted;
    notifyListeners();
  }

  /* viewAccounts() {
    Map<String, dynamic> userMap;
    final String userStr = SharedPref().getString('user');
    if (userStr != null) {
      userMap = jsonDecode(userStr) as Map<String, dynamic>;
    }
    final User user = User.fromJson(userMap);
    _navigationService.navigateToView(
        AccountMainView(
          user: user,
          imageFile: null,
        ),
        arguments: AccountsPageViewArguments(
            user: user, accounts: accounts, valueDouble: totalBalance));
  }*/
}
