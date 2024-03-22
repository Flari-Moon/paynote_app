import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/models/HomeTabBar/custom_bar_chart_decorator.dart';

import '../../../models/HomeTabBar/userBalance.dart';

class HistogramChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HistogramChart(this.seriesList, {this.animate});

  static List<charts.Series<UserBalance, String>> _createPurchaseData() {
    final data = [
      new UserBalance(
          "Spendable income", 100, charts.Color(r: 255, g: 89, b: 100)),
      new UserBalance(
          "Recurring costs", 75, charts.Color(r: 89, g: 255, b: 89)),
      new UserBalance(
          "Upcoming costs", 25, charts.Color(r: 89, g: 216, b: 255)),
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

  factory HistogramChart.withSampleData() {
    return new HistogramChart(
      _createPurchaseData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList ?? [],
      animate: animate,
      defaultRenderer: new charts.BarRendererConfig(
        cornerStrategy: const charts.ConstCornerStrategy(30),
        barRendererDecorator: new CustomBarChartDecorator(
          outsideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 18.nsp.toInt()),
          labelPosition: BarLabelPosition.outside,
        ),
      ),
    );
  }
}
