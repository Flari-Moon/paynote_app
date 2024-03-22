import 'package:flutter/material.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/TransactionModel.dart';
import 'package:paynote_app/Api/TransactionSortedDateModel.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/StringUtils.dart';
import 'package:paynote_app/utils/date_conversion_utils.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:stacked_services/stacked_services.dart';

class LastTransactionsExpandableList extends StatelessWidget {
  LastTransactionsExpandableList({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<TransactionMainModel> data;
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Last Transactions Title
              Text(
                "Last transactions",
                style: TextStyle(
                    fontFamily: "Alata",
                    color: AppColors.brandDarkGrey,
                    fontSize: 46.nsp),
              ),

              /// Right Arrow Icon
              GestureDetector(
                onTap: () {
                  _navigationService.navigateTo(Routes.transactionsAllAccView, arguments: TransactionsAllAccViewArguments(transactionList: data));
                },
                child: Icon(
                  PaynoteIcons.chevron_right,
                  size: 80.r,
                  color: AppColors.brandLightBlue,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 40.h),

        Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.2,
          //color: AppColors.brandBlue,
          child: ListView.builder(
            itemCount: data?.length ?? 0,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: ()=>_navigationService.navigateTo(Routes.transactionsDetailView,arguments: TransactionsDetailViewArguments(transactionModel:data[i].transaction )),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.r,
                    vertical: 20.r,
                  ),
                  child: Row(
                    children: [
                      /// Left Icon
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          border: Border.all(color: data[i].transaction.amount[1] != '-' ? Colors.green : AppColors.brandBlue),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Icon(
                          PaynoteIcons.inbox_outline,
                          color: data[i].transaction.amount[1] != '-' ? Colors.green : AppColors.brandBlue,
                        ),
                      ),

                      SizedBox(width: 30.w),

                      /// Text Content
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Center content
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    this.data[i].transaction.description,
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
                                    this.data[i].transaction.categoryType,
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
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data[i].transaction.amount[1] != '-' ? StringUtils.insertStringAtIndex(data[i].transaction.amount, 1, '+') : data[i].transaction.amount}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppColors.brandBlue,
                                        fontSize: 43.nsp,
                                        fontFamily: 'Alata'),
                                  ),
                                  SizedBox(height: 5.r),
                                  Text(
                                    DateConversionUtils.dateToString(DateTime.fromMillisecondsSinceEpoch(data[i].transaction.date)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppColors.brandMediumGrey,
                                        fontSize: 28.nsp,
                                        fontFamily: 'Alata'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
