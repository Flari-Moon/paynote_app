import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/ui/views/Homepage/HomepageViewModel.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../ui/widgets/global/donutPieChart.dart';
import '../../ui/widgets/global/goalsExpandableList.dart';
import '../../ui/widgets/global/lastTransactionsExpandableList.dart';
import '../../ui/widgets/global/metricTile.dart';
import 'package:flutter_screenutil/size_extension.dart';

class TodayTabContent extends StatelessWidget {
  final List<charts.Series> userData;

  TodayTabContent({
    Key key,
    @required this.data,
    this.userData,
    @required this.model,
  }) : super(key: key);

  final List<TransactionMainModel> data;
  final HomepageViewModel model;
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
          var metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            if (metrics.pixels != 0) {
              _navigationService.navigateTo(Routes.transactionsAllAccView,arguments: TransactionsAllAccViewArguments(transactionList: data));
            }
          }
          return true;
        },
        child: ListView(
          children: [
            Container(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              color: AppColors.brandLightGrey,
              child: MetricTile(
                balance: '${NumberFormat.currency(name: 'eu', symbol: '€').format(model.currentBalance)}',
                data: data,
                title: "Current balance",
                metricKey: "currentBalance",
                hidden: model.metricsHidden,
                onTap: () {
                  _navigationService.navigateTo(Routes.accountMainView, arguments: AccountMainViewArguments(user: User(), imageFile: null));
                },
              ),
            ),
            Container(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              color: AppColors.brandLightGrey,
              child: MetricTile(
                data: data,
                balance: '${NumberFormat.currency(name: 'eu', symbol: '€').format(model.recurringCosts)}',
                title: "Recurring costs",
                metricKey: "recurringCosts",
                hidden: model.metricsHidden,
                onTap: () {
                  _navigationService.navigateTo(Routes.recurringCostsView);
                },
              ),
            ),
            Container(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              color: AppColors.brandLightGrey,
              child: MetricTile(
                data: data,
                balance: '${NumberFormat.currency(name: 'eu', symbol: '€').format(model.spendableIncome)}',
                title: "Spendable income",
                metricKey: "spendableIncome",
                valueColor: AppColors.brandBlue,
                fontSize: 62.nsp,
                hidden: model.metricsHidden,
              ),
            ),
            Container(
              height: 10,
            ),
            Container(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(50.w, 0, 50.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expected & Spending",
                    style: TextStyle(
                        color: AppColors.brandDarkGrey, fontSize: 46.nsp),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.w),
                    child: Text(
                      'What if..',
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: AppColors.brandLightBlue,
                            offset: Offset(0, -3.w),
                          )
                        ],
                        color: Colors.transparent,
                        fontSize: 46.nsp,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.brandLightBlue,
                        decorationThickness: 2,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(height: 80.r),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.5,
              child: Stack(
                children: <Widget>[
                  Center(
                      child: Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 1,
                    child: DonutPieChart(userData, animate: true),
                  )),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${NumberFormat.currency(name: 'eu', symbol: '€').format(model.spendableIncome)}",
                          style: TextStyle(
                              fontSize: 52.nsp,
                              color: AppColors.brandBlue,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Spend",
                          style: TextStyle(
                              fontSize: 40.nsp, color: AppColors.brandDarkGrey),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 80.r),
            // GoalsExpandableList(data: data),
            LastTransactionsExpandableList(data: data),
          ],
        ),
      ),
    );
  }
}
