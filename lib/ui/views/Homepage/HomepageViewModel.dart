import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paynote_app/Api/AccMod.dart';
import 'package:paynote_app/Api/AccountsModel.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/models/HomeTabBar/userBalance.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/utils/Constants.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:stacked/stacked.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:paynote_app/Api/Buffer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:paynote_app/services/SharedPrefService.dart';


class HomepageViewModel extends BaseViewModel {
  bool get metricsHidden => _metricsHidden;
  var userId;
  List<AccountsModel> accounts = [];

  bool _metricsHidden = false;

  final RequestService _requestService = locator<RequestService>();
 // final HiveService hiveService = locator<HiveService>();

  List<charts.Series> seriesList = [];
  List<charts.Series<dynamic,String>> seriesList2 = [];

  var currentBalance = 0.0;
  var recurringCosts = 0.0;
  var spendableIncome = 0.0;
  String m,t,w,th,f,s,su;
  double m1=0,t2=0,w3=0,th4=0,f5=0,s6=0,su7=0;
  final _sharedPrefService = locator<SharedPrefService>();


  set metricsHidden(bool value) {
    _metricsHidden = value;
    SharedPref().setBool(Constants.metricsHidden, value);
    notifyListeners();
  }

  initState(BuildContext context) {
    /// TODO: Remove this line in production
    try {
      var metricsHidden = SharedPref().getBool(Constants.metricsHidden);
      if (metricsHidden != null) {
        _metricsHidden = metricsHidden;
      }
    } catch (e) {
      print(e);
    }
    getUserAccounts(context);
  }
  getUserAccounts(BuildContext context) async {
    setBusy(true);
    accounts=_sharedPrefService.userAccountsFromPrefs();
    String userId = SharedPref().getString('userId');
     // userId = 'c639132b3af543438885068c0cb897ad';
      if (accounts==null && userId != null) {
        print('debug : $userId');
        accounts = await _requestService.getUserAccounts(userId, context);
    }
    bool updateBalance =     SharedPref().getBool("updateAccountNeeded");
    if(updateBalance!=null){
      //userId = 'c639132b3af543438885068c0cb897ad';
      if(updateBalance) {
        accounts.clear();
        accounts = await _requestService.getUserAccounts(userId, context);
        SharedPref().setBool('updateAccountNeeded', false);
      }
    }

  }

  Future<Buffer> fetchBuffer(String userId) async {
    print('account id in buffer $userId');
    try{
    final response=await http.get(Uri.http('136.144.254.26', "/rest/buffer",
        { "userId":userId,"save":"30","days":"1","filter":"combined" }));
    //https://34.209.198.131/rest/buffer?accountId=82f461bc3aa441c69b539f354449b35e&save=30&days=1
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Buffer buff =Buffer.fromJson(jsonDecode(response.body));
      SharedPref().setString("buffer", jsonEncode(buff));
      return buff;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('Failed to load $response.statusCode');
      throw Exception(response.body.toString());
    }}
    catch(e){
      //add
      setBusy(false);
    }
    setBusy(false);

  }


  Future<void> getDonutChartData(BuildContext context) async {
    setBusy(true);
    userId = SharedPref().getString('userId');
    //userId = '82f461bc3aa441c69b539f354449b35e';
  //   accounts = await _requestService.getUserAccounts(userId,context);
  //  print('accounts found${accounts.length}fefe' );
    //for (var account in accounts) {

      Buffer accountBuffer = _sharedPrefService.getBufferFromShared() ;
      if(accountBuffer==null){
        accountBuffer= await fetchBuffer(userId);
      }
     // getThisWeekChart(account.accountId);
      currentBalance = double.tryParse(accountBuffer.data.currentBalance);
      spendableIncome = double.tryParse(accountBuffer.data.spendableIncome);
      recurringCosts = double.tryParse(accountBuffer.data.recurringCost);
    // weeklyData week = await fetchWeekly(accountId);
    m=accountBuffer.data.weekly.monday;
    m1=double.tryParse(m);
    t=accountBuffer.data.weekly.tuesday;
    t2=double.tryParse(t);
    w=accountBuffer.data.weekly.wednesday;
    w3=double.tryParse(w);
    th=accountBuffer.data.weekly.thursday;
    th4=double.tryParse(th);
    f=accountBuffer.data.weekly.friday;
    f5=double.tryParse(f);
    s=accountBuffer.data.weekly.saturday;
    s6=double.tryParse(s);
    su=accountBuffer.data.weekly.sunday;
    su7=double.tryParse(su);

    //print(currentBalance);
    final chartData = [
      new UserBalance("Recurring costs", recurringCosts,
          charts.Color.fromHex(code: "#EB684F")),
      new UserBalance("Spendable income", spendableIncome.toDouble().abs(),
          charts.Color.fromHex(code: "#243665")),
      new UserBalance("Current balance", currentBalance.toDouble().abs(),
          charts.Color.fromHex(code: "#868E94")),
    ];

    seriesList = [
      new charts.Series<UserBalance, String>(
        id: 'userExpected',
        domainFn: (UserBalance userExpected, _) => userExpected.category,
        measureFn: (UserBalance userExpected, _) => userExpected.amount,
        data: chartData,
        colorFn: (UserBalance userExpected, _) => userExpected.color,
      )
    ];
    getThisWeekChart();
    setBusy(false);
   notifyListeners();
  }

  //https://34.209.198.131/rest/weekdiagramdata?accountId=fef2129a79674712a8901a1df00991b3
  // Future<weeklyData> fetchWeekly(String accountid) async {
  //   print('account id in weekly  $accountid');
  //   final response=await http.get(Uri.https("paynotegroup.com", "/rest/weekdiagramdata",
  //       { "accountId":accountid}));
  //   //https://34.209.198.131/rest/buffer?accountId=82f461bc3aa441c69b539f354449b35e&save=30&days=1
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return weeklyData.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     print('Failed to load $response.statusCode');
  //     throw Exception(response.body.toString());
  //   }
  //
  // }
  // //=============================
  //=== SORTING DATA IN THE FRONT END. REFACTOR NEEDED when possible.
  //=============================
  void getThisWeekChart()  {

    print(su);

    final spendableIncomeData = [
      new UserBalance("M", m1, charts.Color.fromHex(code: "#EB684F")),
      new UserBalance("Tu", t2, charts.Color.fromHex(code: "#EB684F")),
      new UserBalance("W", w3, charts.Color.fromHex(code: "#EB684F")),
      new UserBalance("Th", th4, charts.Color.fromHex(code: "#EB684F")),
      new UserBalance("F", f5, charts.Color.fromHex(code: "#EB684F")),
      new UserBalance("S", s6, charts.Color.fromHex(code: "#EB684F")),
      new UserBalance("Su", su7, charts.Color.fromHex(code: "#EB684F")),
    ];
/*
    final recurringCostsData = [
      new UserBalance("M", 100, charts.Color.fromHex(code: "#243665")),
      new UserBalance("T", 100, charts.Color.fromHex(code: "#243665")),
      new UserBalance("W", 100, charts.Color.fromHex(code: "#243665")),
      new UserBalance("T", 100, charts.Color.fromHex(code: "#243665")),
      new UserBalance("F", 100, charts.Color.fromHex(code: "#243665")),
      new UserBalance("S", 100, charts.Color.fromHex(code: "#243665")),
      new UserBalance("S", 100, charts.Color.fromHex(code: "#243665")),
    ];

    final upcomingCostsData = [
      new UserBalance("M", 100, charts.Color.fromHex(code: "#868E94")),
      new UserBalance("T", 100, charts.Color.fromHex(code: "#868E94")),
      new UserBalance("W", 100, charts.Color.fromHex(code: "#868E94")),
      new UserBalance("T", 100, charts.Color.fromHex(code: "#868E94")),
      new UserBalance("F", 100, charts.Color.fromHex(code: "#868E94")),
      new UserBalance("S", 100, charts.Color.fromHex(code: "#868E94")),
      new UserBalance("S", 100, charts.Color.fromHex(code: "#868E94")),
    ];*/

    seriesList2= [
      // new charts.Series<UserBalance, String>(
      //   id: 'upcomingCosts',
      //   domainFn: (UserBalance userExpected, _) => userExpected.category,
      //   measureFn: (UserBalance userExpected, _) => userExpected.amount,
      //   data: upcomingCostsData,
      //   colorFn: (UserBalance userExpected, _) => userExpected.color,
      //   labelAccessorFn: (userBalance, _) => '',
      //   outsideLabelStyleAccessorFn: (userBalance, _) =>
      //       charts.TextStyleSpec(fontSize: 30),
      // ),
      new charts.Series<UserBalance, String>(
        id: 'spendableIncome',
        domainFn: (UserBalance userExpected, _) => userExpected.category,
        measureFn: (UserBalance userExpected, _) => userExpected.amount,
        data: spendableIncomeData,
        colorFn: (UserBalance userExpected, _) =>
        userExpected.color,
        labelAccessorFn: (userBalance, _) => '',
        outsideLabelStyleAccessorFn: (userBalance, _) =>
            charts.TextStyleSpec(fontSize: 30),
      ),
      // new charts.Series<UserBalance, String>(
      //   id: 'recurringCosts',
      //   domainFn: (UserBalance userExpected, _) => userExpected.category,
      //   measureFn: (UserBalance userExpected, _) => userExpected.amount,
      //   data: recurringCostsData,
      //   colorFn: (UserBalance userExpected, _) => userExpected.color,
      //   labelAccessorFn: (userBalance, _) =>
      //       '€' + userBalance.amount.toString(),
      //   outsideLabelStyleAccessorFn: (userBalance, _) =>
      //       charts.TextStyleSpec(fontSize: 30),
      // ),
    ];
  }
}
