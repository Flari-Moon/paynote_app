import 'package:flutter/material.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/utils/SharedPref.dart';

class MetricTile extends StatelessWidget {
  const MetricTile({
    Key key,
    @required this.data,
    @required this.title,
    @required this.metricKey,
    this.onTap,
    this.fontSize,
    this.hidden,
    this.valueColor = AppColors.brandDarkGrey,
    this.balance,
  }) : super(key: key);

  final List<TransactionMainModel> data;
  final Color valueColor;
  final String title;
  final String metricKey;
  final double fontSize;
  final bool hidden;
  final void Function() onTap;
  final String balance;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 50.r,
        vertical: 0,
      ),
      title: Text(title,
          style: TextStyle(
            fontSize: 46.nsp,
            fontFamily: "Roboto",
            color: AppColors.brandBlue,
          )),
      trailing: Text(
        balance != null ? hidden ? '****' : "$balance" : '0',
        style: TextStyle(
            fontSize: fontSize ?? 54.nsp,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
            color: valueColor),
      ),
    );
  }
}
