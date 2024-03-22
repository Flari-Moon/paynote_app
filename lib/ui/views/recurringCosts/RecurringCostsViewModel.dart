import 'package:flutter/material.dart';
import 'package:paynote_app/Api/AccountsModel.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/TransactionModel.dart';
import 'package:paynote_app/Api/TransactionSortedDateModel.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:paynote_app/Api/RecurringData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
//import 'package:paynote_app/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class RecurringCostsViewModel extends BaseViewModel {
  List<TransactionMainModel> transactions;
  NavigationService _navigationService = locator<NavigationService>();
  RequestService requestService = locator<RequestService>();
  int limit = 10;
  int skip = 0;
  String month, year;
  List<Subscriptions> subList = new List<Subscriptions>();
  List<AccountsModel> accounts = [];
  String userId;


  /* getTransactions(BuildContext context) async {
    var userId = '82f461bc3aa441c69b539f354449b35e';
    if (userId != null && transactions.isEmpty) {
      await requestService
          .getUserTransactions(userId, skip, limit, 'date',context)
          .then((value) => transactions.addAll(value));
      notifyListeners();
    }
  }
*/





  fetchRecurringsTrans(){
    setBusy(true);
    //fetchRecurringsTrans();
    getSubscriptionFromShared();
    userId= SharedPref().getString('userId');
        if (subList.isEmpty || subList == null) {
          print('opsss');
          fetchRecurring(userId);
        }
        else{
          setBusy(false);
        }

  }
  Future<Subscriptions> fetchRecurring(String id) async {
    print('sccount is $id');
    setBusy(true);
    try {
      final response = await http.get(
          Uri.http('136.144.254.26', '/rest/recurring',
              {
                "id": id
              }));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        var responseBody = RecurringData.fromJson(jsonDecode(response.body));
        //responseBody.data.subscriptions;
        // recurringTransDetail.company=
        month = responseBody.data.amountPerMonth;
        year = responseBody.data.amountPerYear;
        /*  mon+=mon;
      yea+=yea;*/
        subList.addAll(responseBody.data.subscriptions);
        saveRecurring();
        print('all ok');
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print('Failed to load $response.statusCode');
      }
    }
    catch(e){
      setBusy(false);
      notifyListeners();
    }
    /*month=mon.toString();
    year=yea.toString();*/

    setBusy(false);
    notifyListeners();
  }

  saveRecurring(){
    if(subList!=null) {
      List<String> savedPrefsJson = [];
      for (Subscriptions savedPref in subList) {
        String savedPrefJson = jsonEncode(savedPref);
        savedPrefsJson.add(savedPrefJson);
      }
      SharedPref().setString('monthSubscription', month);
      SharedPref().setString('yearSubscription', year);
      print('month $month');
      print('year $year');
      SharedPref().setStringList("subscriptionList", savedPrefsJson);
    }
  }
  void showRecurringDetial(Subscriptions transaction) {
    _navigationService.navigateTo(Routes.recurringTransactionsView,
        arguments: RecurringTransactionsViewArguments(subscriptionModel: transaction));
  }

  void getSubscriptionFromShared() {

    List<String> acc = SharedPref().getStringList("subscriptionList");
    if (acc != null) {
      for (String s in acc) {
        Map<String, dynamic> accMap;
        accMap = jsonDecode(s) as Map<String, dynamic>;
        final Subscriptions accMod = Subscriptions.fromJson(accMap);
        subList.add(accMod);
      }
      month= SharedPref().getString('monthSubscription');
      year =SharedPref().getString('yearSubscription');
      print('sublist found');
      //return subList;
    }
    setBusy(false);
    notifyListeners();
    //return null;
  }
}
