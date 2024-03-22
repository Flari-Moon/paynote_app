import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/TransactionModel.dart';
import 'package:paynote_app/Api/TransactionSortedDateModel.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/ui/widgets/global/OverLayWidget.dart';
import 'package:paynote_app/utils/StringUtils.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'transactionsAllAccViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/extensions/date_comparison_extension.dart';
import 'package:paynote_app/Api/User.dart';

//import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
//===============================================================

class TransactionsAllAccView extends StatelessWidget {
  TransactionsAllAccView({@required this.transactionList, this.user});

  List<TransactionMainModel> transactionList;
  final TextEditingController textEditingController = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  final User user;

  buildInternalWidgets(TransactionMainModel data) {
    print(data);
    print(this.transactionList);
    return Column(
      children: [
        Container(
          height: 9,
        ),
        Row(
          children: [
            /// Left Icon
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                border: Border.all(
                    color: data.transaction.amount[1] != '-'
                        ? Colors.green
                        : AppColors.brandBlue),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: Icon(
                PaynoteIcons.inbox_outline,
                color: data.transaction.amount[1] != '-'
                    ? Colors.green
                    : AppColors.brandBlue,
                size: 15,
              ),
            ),

            SizedBox(width: 35.w),

            /// Text Content
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Center content
                  Container(
                    //width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.transaction.description,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.brandBlue,
                              fontSize: 38.nsp,
                              fontFamily: 'Alata'),
                        ),
                        SizedBox(height: 5.r),
                        Text(
                          data.transaction.categoryType,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.brandMediumGrey,
                              fontSize: 32.nsp,
                              fontFamily: 'Alata'),
                        ),
                      ],
                    ),
                  ),

                  /// Right Content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${data.transaction.amount[1] != '-' ? StringUtils.insertStringAtIndex(data.transaction.amount, 1, '+') : data.transaction.amount}',
                        style: TextStyle(
                            color: data.transaction.amount[1] != '-'
                                ? Colors.green
                                : AppColors.brandBlue,
                            fontSize: 38.nsp,
                            fontFamily: 'Alata'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 9,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransactionsAllAccViewModel>.reactive(
      builder: (context, model, child) {
        _scrollController.addListener(() {
          if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
            model.getData(context);
          }
        });
        return Scaffold(
          backgroundColor: Colors.white,
          body: homeNew(context,model),
        );
      },
      viewModelBuilder: () => TransactionsAllAccViewModel(),
      onModelReady: (model) => model.getTransactions(context),
    );
  }

  Widget homeNew(BuildContext context,TransactionsAllAccViewModel model){
    if (model.isBusy) {
      return OverLayWidget(title: 'Constructing...',description: 'we are fetching your transactions...',);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _topBar(context, model),
          _centralContent(context, model),
          _bottomAppBar(context, model),
        ],
      );
    }
  }
  Widget _buildProgressIndicator(TransactionsAllAccViewModel model) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Visibility(
          visible: model.isLoading,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
  Widget _topBar(BuildContext context, TransactionsAllAccViewModel model) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50.w, 120.w, 50.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              PaynoteIcons.arrow_back,
              size: 70.r,
            ),
          ),
          SizedBox(height: 60.h),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Transactions",
                  style: TextStyle(
                      color: AppColors.brandBlue,
                      fontSize: 23,
                      fontFamily: "Alata"),
                ),
                Container(
                  width: 15,
                ),
                Text(
                  "all accounts",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: AppColors.brandDarkGrey),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (content) {
                      print(content);
                      if(content!=null && content.isNotEmpty){
                        model.isSearched=true;
                      model.searchOperation(content);}
                      else{
                        model.isSearched=false;
                      }
                    },
                    decoration: InputDecoration(
                        //border: InputBorder.none,

                        hintText: 'Search',
                        hintStyle: TextStyle(color: AppColors.brandDarkGrey)),
                  ),
                ),
                SizedBox(width: 40.w),
                Icon(
                  PaynoteIcons.search,
                  color: AppColors.brandLightBlue,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _centralContent(
      BuildContext context, TransactionsAllAccViewModel model) {
    String lastDate = '';
    String currentDate = '';

    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(50.w, 0, 50.w, 0),
        child: model.isSearched ==true? ListView.builder(
          itemCount: model.searchResult.length,
          controller: _scrollController,
          itemBuilder: (context, i) {
            if (i == model.searchResult.length) {
              return _buildProgressIndicator(model);
            } else {
              lastDate = currentDate;
              currentDate = model.searchResult[i].transaction.originalDate
                  .substring(0, 15);
              return GestureDetector(
                onTap: () {
                  model.navigateToTransactionDetail(
                      model.searchResult[i].transaction);
                },
                child: Center(
                  child:  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (currentDate != lastDate)
                          Container(
                            child: Text(
                                "${model.searchResult[i].transaction.originalDate.substring(0, 15)}",
                                style: TextStyle(
                                  color: AppColors.brandBlue,
                                  fontSize: 38.nsp,
                                  fontFamily: "Alata",
                                )),
                          ),
                        buildInternalWidgets(model.searchResult[i]),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ) :  ListView.builder(
          itemCount: model.toDisplayTransactions.length,
          controller: _scrollController,
          itemBuilder: (context, i) {
            if (i == model.toDisplayTransactions.length) {
              return _buildProgressIndicator(model);
            } else {
            lastDate = currentDate;
            currentDate = model.toDisplayTransactions[i].transaction.originalDate
                .substring(0, 15);
            return GestureDetector(
              onTap: () {
                model.navigateToTransactionDetail(
                    model.toDisplayTransactions[i].transaction);
              },
              child: Center(
                child:  Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (currentDate != lastDate)
                        Container(
                          child: Text(
                              "${model.toDisplayTransactions[i].transaction.originalDate.substring(0, 15)}",
                              style: TextStyle(
                                color: AppColors.brandBlue,
                                fontSize: 38.nsp,
                                fontFamily: "Alata",
                              )),
                        ),
                      buildInternalWidgets(model.toDisplayTransactions[i]),
                    ],
                  ),
                ),
              ),
            );
          }
          },
        ),
      ),
    );
  }

  String getDateText(String date) {
    //   Sun 27 Dec 2020 03:48:07 am
    var dateTime = DateFormat('EEE dd MMM yyyy hh:mm:ss a').parse(date);
    var currentDate = DateTime.now();
    if (dateTime.isSameDate(currentDate)) {
      return 'Today';
    } else if (dateTime.isOneDayBefore(currentDate)) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM dd yyyy').format(dateTime);
      // return DateFormat('dd MMM yyyy hh:mm').format(dateTime);
    }
  }

  Widget _bottomAppBar(
      BuildContext context, TransactionsAllAccViewModel model) {
    return Menu();
  }
}
