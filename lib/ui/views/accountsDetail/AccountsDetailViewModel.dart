import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:paynote_app/Api/AccountsModel.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/SubscriptionModel.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/RecurringData.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/services/SharedPrefService.dart';

class AccountsDetailViewModel extends BaseViewModel {
  List<TransactionMainModel> transactionList = [];
  //List<SubscriptionModel> subscriptionList = <SubscriptionModel>[];
  NavigationService _navigationService = locator<NavigationService>();
  RequestService requestService = locator<RequestService>();
  int limit = 10;
  int skip = 0;
  String month, year;
  List<Subscriptions> subscriptionList = [];
  SharedPrefService _sharedPrefService = locator<SharedPrefService>();

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

  List<TransactionMainModel> getTransactionFromShared(
      AccountsModel accountsModel) {
    List<String> acc =
        SharedPref().getStringList('${accountsModel.accountId}transactionList');
    if (acc != null) {
      for (String s in acc) {
        Map<String, dynamic> accMap;
        accMap = jsonDecode(s) as Map<String, dynamic>;
        final TransactionMainModel accMod =
            TransactionMainModel.fromJson(accMap);
        transactionList.add(accMod);
      }

      print('trans in pref found $transactionList');
      return transactionList;
    }

    return null;
  }

  getTransactions(BuildContext context, AccountsModel accountsModel) async {
    setBusy(true);
    var userId = SharedPref().getString('userId');
    //userId= 'a070c1b4e75e499cbf73fe64fa1d1bd6';
    transactionList = getTransactionFromShared(accountsModel);
    if (userId != null && transactionList == null) {
      transactionList = [];
      print('account ${accountsModel.accountId}');
      await requestService
          .getUserTransactions(
              userId, skip, limit, 'date', context, accountsModel.accountId)
          .then((value) {
        if (value != null) {
          transactionList.addAll(value);
          print('vale: $value');
        } else {
          setBusy(false);
        }
      });
      setBusy(false);
      print('transaction detials $transactionList');
      notifyListeners();
    }
  }

/*
 https://34.209.198.131/rest/run?model=buffer&parameters={"accountId":"fef2129a79674712a8901a1df00991b3","save":"30","days":1}
 https://34.209.198.131/rest/run?model=recurring&parameters={"accountId":"fef2129a79674712a8901a1df00991b3"}
*/
  /* getSubscriptions(BuildContext context) async {
    var userId = SharedPref().getString('userId');
    if (userId != null && subscriptionList.isEmpty) {
      await requestService
          .getUserSubscriptions(userId, 3, 1,context)
          .then((value) => subscriptionList.addAll(value));
      notifyListeners();
    }
  }
*/

  fetchRecurringsTrans(AccountsModel accountsModel) {
    getSubscriptionFromShared(accountsModel);
    setBusy(false);
    if (subscriptionList == null || subscriptionList.isEmpty) {
      // for (AccountsModel a in accounts) {
      print('subs not found');
      fetchRecurring(accountsModel);
      // }
    }
  }

  List<Subscriptions> getSubscriptionFromShared(AccountsModel accountsModel) {
    List<String> acc =
        SharedPref().getStringList('${accountsModel.accountId}subscription');
    if (acc != null) {
      for (String s in acc) {
        Map<String, dynamic> accMap;
        accMap = jsonDecode(s) as Map<String, dynamic>;
        final Subscriptions accMod = Subscriptions.fromJson(accMap);
        subscriptionList.add(accMod);
      }
      SharedPref().getString('${accountsModel.accountId}monthSubscription');
      SharedPref().getString('${accountsModel.accountId}yearSubscription');
      print('subs found $subscriptionList');
      return subscriptionList;
    }

    return null;
  }

  Future<Subscriptions> fetchRecurring(AccountsModel accountsModel) async {
    setBusy(true);
    try {
      final response = await http.get(Uri.http('136.144.254.26',
          '/rest/recurring', {"id": accountsModel.accountId}));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        var responseBody = RecurringData.fromJson(jsonDecode(response.body));
        //responseBody.data.subscriptions;
        // recurringTransDetail.company=
        month = responseBody.data.amountPerMonth;
        year = responseBody.data.amountPerYear;
        subscriptionList = responseBody.data.subscriptions;
        saveRecurring(accountsModel);
      } else {
        subscriptionList = null;
        // If the server did not return a 200 OK response,
        // then throw an exception.
        setBusy(false);
        notifyListeners();
      }
    } catch (e) {
      setBusy(false);
      notifyListeners();
    }
    setBusy(false);
    notifyListeners();
  }

  saveRecurring(AccountsModel accountsModel) {
    if (subscriptionList != null) {
      List<String> savedPrefsJson = [];
      for (Subscriptions savedPref in subscriptionList) {
        String savedPrefJson = jsonEncode(savedPref);
        savedPrefsJson.add(savedPrefJson);
      }
      SharedPref()
          .setString('${accountsModel.accountId}monthSubscription', month);
      SharedPref()
          .setString('${accountsModel.accountId}yearSubscription', year);
      print('month $month');
      print('year $year');
      SharedPref().setStringList(
          '${accountsModel.accountId}subscription', savedPrefsJson);
    }
  }

  void showRecurringDetial(Subscriptions transaction) {
    _navigationService.navigateTo(Routes.recurringTransactionsView,
        arguments:
            RecurringTransactionsViewArguments(subscriptionModel: transaction));
  }
}
