import 'package:charts_flutter/flutter.dart' as charts;

class UserBalance {
  final String category;
  final num amount;
  final charts.Color color;

  UserBalance(this.category, this.amount, this.color);
}