import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_screenutil/size_extension.dart';

import '../../../models/HomeTabBar/userBalance.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  static List<charts.Series<UserBalance, String>> _createPurchaseData() {
    final data = [
      new UserBalance(
          "Spendable income", 100, charts.Color(r: 89, g: 255, b: 89)),
      new UserBalance(
          "Recurring costs", 75, charts.Color(r: 255, g: 89, b: 100)),
      new UserBalance(
          "Current balance", 25, charts.Color(r: 89, g: 216, b: 255)),
    ];

    return [
      new charts.Series<UserBalance, String>(
        id: 'userExpected',
        domainFn: (UserBalance userExpected, _) => userExpected.category,
        measureFn: (UserBalance userExpected, _) => userExpected.amount,
        data: data,
        colorFn: (UserBalance userExpected, _) => userExpected.color,
      )
    ];
  }

  factory DonutPieChart.withSampleData() {
    return new DonutPieChart(
      _createPurchaseData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList ?? [],
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: 70.r.toInt(),
          arcRendererDecorators: [
            new charts.ArcLabelDecorator(
              showLeaderLines: false,
              outsideLabelStyleSpec:
                  new charts.TextStyleSpec(fontSize: 32.nsp.toInt()),
              labelPosition: charts.ArcLabelPosition.outside,
            )
          ]),
    );
  }
}
