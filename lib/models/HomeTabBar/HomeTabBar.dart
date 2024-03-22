import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/TransactionSortedDateModel.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/models/HomeTabBar/thisWeekTabContent.dart';
import 'package:paynote_app/models/HomeTabBar/userBalance.dart';

import 'package:flutter/services.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/models/OverlayLoadingScreens/OverlaysForLoading.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/ui/views/Homepage/HomepageViewModel.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:stacked_services/stacked_services.dart';

import 'todayTabContent.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

//testing imports
import '../../ui/views/transactions/transactionsAllAccView.dart';
import '../../ui/views/transactions/transactionDetail/transactionDetailView.dart';
import 'package:paynote_app/Api/TransactionModel.dart';

class HomeTabBar extends StatelessWidget {
  HomeTabBar({
    this.data,
    this.model,
  });

  final List<TransactionMainModel> data;
  final HomepageViewModel model;
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    // ============================================================================================================
   /* List<charts.Series<UserBalance, String>> createUserData() {
      final chartData = [
        new UserBalance("Recurring costs", this.data[0][0]["GraphData"]["val2"],
            charts.Color.fromHex(code: "#EB684F")),
        new UserBalance(
            "Spendable income",
            this.data[0][0]["GraphData"]["val1"],
            charts.Color.fromHex(code: "#243665")),
        new UserBalance("Current balance", this.data[0][0]["GraphData"]["val3"],
            charts.Color.fromHex(code: "#868E94")),
      ];

      return [
        new charts.Series<UserBalance, String>(
          id: 'userExpected',
          domainFn: (UserBalance userExpected, _) => userExpected.category,
          measureFn: (UserBalance userExpected, _) => userExpected.amount,
          data: chartData,
          colorFn: (UserBalance userExpected, _) => userExpected.color,
        )
      ];
    }

    List<charts.Series<UserBalance, String>> createUserWeekData() {
      final spendableIncomeData = [
        new UserBalance("M", this.data[0][0]["GraphData"]["val1"],
            charts.Color.fromHex(code: "#EB684F")),
        new UserBalance("T", this.data[0][0]["GraphData"]["val1"],
            charts.Color.fromHex(code: "#EB684F")),
        new UserBalance("W", this.data[0][0]["GraphData"]["val1"],
            charts.Color.fromHex(code: "#EB684F")),
        new UserBalance("T", this.data[0][0]["GraphData"]["val1"],
            charts.Color.fromHex(code: "#EB684F")),
        new UserBalance("F", this.data[0][0]["GraphData"]["val1"],
            charts.Color.fromHex(code: "#EB684F")),
        new UserBalance("S", this.data[0][0]["GraphData"]["val1"],
            charts.Color.fromHex(code: "#EB684F")),
        new UserBalance("S", this.data[0][0]["GraphData"]["val1"],
            charts.Color.fromHex(code: "#EB684F")),
      ];

      final recurringCostsData = [
        new UserBalance("M", this.data[0][0]["GraphData"]["val2"],
            charts.Color.fromHex(code: "#243665")),
        new UserBalance("T", this.data[0][0]["GraphData"]["val2"],
            charts.Color.fromHex(code: "#243665")),
        new UserBalance("W", this.data[0][0]["GraphData"]["val2"],
            charts.Color.fromHex(code: "#243665")),
        new UserBalance("T", this.data[0][0]["GraphData"]["val2"],
            charts.Color.fromHex(code: "#243665")),
        new UserBalance("F", this.data[0][0]["GraphData"]["val2"],
            charts.Color.fromHex(code: "#243665")),
        new UserBalance("S", this.data[0][0]["GraphData"]["val2"],
            charts.Color.fromHex(code: "#243665")),
        new UserBalance("S", this.data[0][0]["GraphData"]["val2"],
            charts.Color.fromHex(code: "#243665")),
      ];

      final upcomingCostsData = [
        new UserBalance("M", this.data[0][0]["GraphData"]["val3"],
            charts.Color.fromHex(code: "#868E94")),
        new UserBalance("T", this.data[0][0]["GraphData"]["val3"],
            charts.Color.fromHex(code: "#868E94")),
        new UserBalance("W", this.data[0][0]["GraphData"]["val3"],
            charts.Color.fromHex(code: "#868E94")),
        new UserBalance("T", this.data[0][0]["GraphData"]["val3"],
            charts.Color.fromHex(code: "#868E94")),
        new UserBalance("F", this.data[0][0]["GraphData"]["val3"],
            charts.Color.fromHex(code: "#868E94")),
        new UserBalance("S", this.data[0][0]["GraphData"]["val3"],
            charts.Color.fromHex(code: "#868E94")),
        new UserBalance("S", this.data[0][0]["GraphData"]["val3"],
            charts.Color.fromHex(code: "#868E94")),
      ];

      return [
        new charts.Series<UserBalance, String>(
          id: 'upcomingCosts',
          domainFn: (UserBalance userExpected, _) => userExpected.category,
          measureFn: (UserBalance userExpected, _) => userExpected.amount,
          data: upcomingCostsData,
          colorFn: (UserBalance userExpected, _) => userExpected.color,
          labelAccessorFn: (userBalance, _) => '',
          outsideLabelStyleAccessorFn: (userBalance, _) =>
              charts.TextStyleSpec(fontSize: 30.w.toInt()),
        ),
        new charts.Series<UserBalance, String>(
          id: 'spendableIncome',
          domainFn: (UserBalance userExpected, _) => userExpected.category,
          measureFn: (UserBalance userExpected, _) => userExpected.amount,
          data: spendableIncomeData,
          colorFn: (UserBalance userExpected, _) =>
              charts.ColorUtil.fromDartColor(Colors.transparent),
          labelAccessorFn: (userBalance, _) => '',
          outsideLabelStyleAccessorFn: (userBalance, _) =>
              charts.TextStyleSpec(fontSize: 30.w.toInt()),
        ),
        new charts.Series<UserBalance, String>(
          id: 'recurringCosts',
          domainFn: (UserBalance userExpected, _) => userExpected.category,
          measureFn: (UserBalance userExpected, _) => userExpected.amount,
          data: recurringCostsData,
          colorFn: (UserBalance userExpected, _) => userExpected.color,
          labelAccessorFn: (userBalance, _) =>
              '€' + userBalance.amount.toString(),
          outsideLabelStyleAccessorFn: (userBalance, _) =>
              charts.TextStyleSpec(fontSize: 30.w.toInt()),
        ),
      ];
    }
*/
    // ============================================================================================================
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 120.w,
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabBar(
                    labelColor: AppColors.brandBlue,
                    unselectedLabelColor: AppColors.brandMediumGrey,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    labelPadding: EdgeInsets.only(
                      bottom: 30.h,
                      left: 30.w,
                      right: 30.w,
                    ),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 3,
                        color: AppColors.brandLightBlue,
                      ),
                      // insets: EdgeInsets.symmetric(horizontal: 10.w),
                    ),
                    tabs: [
                      Text(
                        "Today",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 42.nsp,
                          fontFamily: "Roboto",
                        ),
                      ),
                      Text(
                        "This Week",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 42.nsp,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 100.w,
                      bottom: 30.w,
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => model.metricsHidden = !model.metricsHidden,
                      child: Icon(
                        model.metricsHidden
                            ? PaynoteIcons.eye_off
                            : PaynoteIcons.eye,
                        color: AppColors.brandLightBlue,
                        size: 60.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              TodayTabContent(
                data: data,
              //  userData: createUserData(),
                model: model,
                userData: model.seriesList,
              ),
              ThisWeekTabContent(
                data: data,
               userData: model.seriesList2,
                model: model,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
