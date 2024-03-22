import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paynote_app/Api/TransactionModel.dart';
import 'package:paynote_app/Api/TransactionSortedDateModel.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/ui/views/transactions/transactionDetail/transactionDetailViewModel.dart';
import 'package:paynote_app/ui/widgets/global/CacheImage.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

//===============================================================

class TransactionsDetailView extends StatelessWidget {
  // TransactionsDetailView({@required this.transactionModel});
  TransactionsDetailView({this.transactionModel});
  final TextEditingController textEditingController = TextEditingController();
  final TransactionSortedDateModel transactionModel;

  var transactionType = 0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransactionsDetailViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.brandWhite,
          body: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              _topBar(context, model),
              _centralContent(context, model),
              _bottomAppBar(context, model),
            ],
          ),
        );
      },
      viewModelBuilder: () => TransactionsDetailViewModel(),
    );
  }

  Widget _topBar(BuildContext context, TransactionsDetailViewModel model) {
    return Padding(
        padding: EdgeInsets.only(
          top: 150.h,
          left: 70.w,
          right: 70.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(PaynoteIcons.arrow_back),
                  color: AppColors.brandBlue,
                  iconSize: 30,
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              //height: MediaQuery.of(context).size.width * 0.2,
              child: Row(children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      border: Border.all(color: Colors.grey[300])),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3.0),
                    child: CachedImage('',
                      width:MediaQuery.of(context).size.width * 0.2 ,
                      height:MediaQuery.of(context).size.width * 0.2 ,),
                  ),
                ),
                Container(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${transactionModel.description}", //transactionModel.description,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: AppColors.brandBlue,
                            fontSize: 20,
                            fontFamily: "Alata"),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${transactionModel.amount}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: AppColors.brandBlue,
                                  fontSize: 20,
                                  fontFamily: "Alata"),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "${transactionModel.timestamp}",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: AppColors.brandDarkGrey),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 15,
                ),
              ]),
            ),
          ],
        ));
  }

  Widget _centralContent(
      BuildContext context, TransactionsDetailViewModel model) {
    return Padding(
      padding: EdgeInsets.only(
        top: 500.h,
        left: 70.w,
        right: 70.w,
      ),
      child: ListView(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.brandBlue),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Icon(
                          PaynoteIcons.inbox_outline,
                          color: AppColors.brandBlue,
                          size: 20,
                        ),
                      ),
                      Container(width: 15),
                      Text(
                        transactionModel.categoryName!=null?"${transactionModel.categoryName}":"",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: AppColors.brandBlue, fontSize: 18, ),
                      )
                    ],
                  ),
                ),
              ),
            decoration: new BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 10 Vertically
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.brandDarkGrey,
          ),
          Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  "More details",
                  style: TextStyle(color: AppColors.brandBlue, fontSize: 18),
                ),
                children: [
                  Container(
                      padding: EdgeInsets.only(
                        top: 20.w,
                        left: 70.w,
                        right: 70.w,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              'Type',
                              style: TextStyle(color: AppColors.brandDarkGrey, fontSize: 18),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "${transactionModel.categoryName}",
                              style: TextStyle(color: AppColors.brandBlue, fontSize: 18),
                            ),
                          ),
                          Container(height: 15),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              'Location',
                              style: TextStyle(color: AppColors.brandDarkGrey, fontSize: 18),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "",
                              style: TextStyle(color: AppColors.brandBlue, fontSize: 18),
                            ),
                          ),
                          Container(height: 15),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              'Receiving party',
                              style: TextStyle(color: AppColors.brandDarkGrey, fontSize: 18),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "${transactionModel.payload.TRANSFER_ACCOUNT_NAME_EXTERNAL}",
                              style: TextStyle(color: AppColors.brandBlue, fontSize: 18),
                            ),
                          ),
                          Container(height: 15),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              'Description',
                              style: TextStyle(color: AppColors.brandDarkGrey, fontSize: 18),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "${transactionModel.payload.MESSAGE}",
                              style: TextStyle(color: AppColors.brandBlue, fontSize: 18),
                            ),
                          ),
                          Container(height: 15),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              'Website',
                              style: TextStyle(color: AppColors.brandDarkGrey, fontSize: 18),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "",
                              style: TextStyle(color: AppColors.brandBlue, fontSize: 18),
                            ),
                          ),
                          Container(height: 25),
                        ],
                      )),
                ],
              ),
          ),
          Divider(
            color: AppColors.brandDarkGrey,
          ),
        ],
      ),
    );
  }

  Widget _bottomAppBar(
      BuildContext context, TransactionsDetailViewModel model) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          // RaisedButton(
          //     elevation: 0,
          //     color: AppColors.brandBlue,
          //     disabledColor: AppColors.brandLightGrey,
          //     onPressed: () {},
          //     child: Container(
          //       width: MediaQuery.of(context).size.width * 0.8,
          //       height: MediaQuery.of(context).size.height * 0.08,
          //       child: Center(
          //           child: Text(
          //         "Add a receipt",
          //         style: TextStyle(
          //             color: AppColors.brandWhite,
          //             fontFamily: 'Alata',
          //             fontSize: 48.nsp),
          //       )),
          //     )),
          Container(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Menu()
        ],
      ),
    );
  }
}
