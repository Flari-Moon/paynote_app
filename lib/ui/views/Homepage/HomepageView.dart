import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:paynote_app/Api/ApiClientService.dart';

import 'package:flutter/material.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/TransactionSortedDateModel.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/Api/TransactionModel.dart';

import 'package:paynote_app/models/HomeTabBar/HomeTabBar.dart';
import 'package:paynote_app/ui/views/Homepage/HomepageViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:paynote_app/models/OverlayLoadingScreens/OverlaysForLoading.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/ui/widgets/global/OverLayWidget.dart';


//===
class HomepageView extends StatefulWidget {
  HomepageView(
      {Key key,
      this.phoneNumber,
      this.userName,
      this.userSurname,
      this.email,
      this.imagefile,
      this.user,this.transactionList})
      : super(key: key);

  final String phoneNumber;
  final String userName;
  final String userSurname;
  final String email;

  final File imagefile;
  final User user;
  final  List<TransactionMainModel> transactionList;

  var dataNow =
      "${new DateTime.now().day}/${new DateTime.now().month}/${new DateTime.now().year}";

  var timestamp = [];

  double value = 0.00;

  @override
  _HomepageViewState createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  timestampCheck() async {
    for (var i in widget.transactionList) {
      if (i.transaction.originalDate == widget.dataNow) {
        widget.timestamp.add("Today");
      } else if (i.transaction.originalDate  ==
          "${new DateTime.now().day - 1}/${new DateTime.now().month}/${new DateTime.now().year}") {
        widget.timestamp.add("Yesterday");
      } else if (i.transaction.originalDate  ==
          "${new DateTime.now().day - 7}/${new DateTime.now().month}/${new DateTime.now().year}") {
        widget.timestamp.add("Last week");
      } else if (i.transaction.originalDate  ==
          "${new DateTime.now().day}/${new DateTime.now().month - 1}/${new DateTime.now().year}") {
        widget.timestamp.add("Last month");
      } else {
        widget.timestamp.add(i.transaction.originalDate );
      }
    }
    print(widget.timestamp);
  }

  @override
  Widget build(BuildContext context) {
    timestampCheck();
    return ViewModelBuilder.reactive(

      builder: (context, model, child) => homeNew(model),
      viewModelBuilder: () => HomepageViewModel(),
      onModelReady: (HomepageViewModel model) {
        model.initState(context);
        model.getDonutChartData(context);
       // model.getThisWeekChart();
      },
    );
  }

  Widget homeMainView(HomepageViewModel model) {
    return Container(
      child:HomeTabBar(
        data:widget.transactionList,
        model: model,
      ),
    );
  }

  Widget homeNew(HomepageViewModel model){
    if (model.isBusy) {
      return OverLayWidget(title: 'Constructing...',description: 'we are building your dashboard',);
    } else {
      return homeMainView(model);
    }
  }


}
