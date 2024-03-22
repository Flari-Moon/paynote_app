import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/Api/TransactionSortedDateModel.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/StringUtils.dart';
import 'package:paynote_app/utils/paynote_icons.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    this.transactionModel,
    this.color,
  });

  final TransactionSortedDateModel transactionModel;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 60.r,
        vertical: 20.r,
      ),
      color: color,
      child: Row(
        children: [

                /// Left Icon
            Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              border: Border.all(
                  color: transactionModel.amount[1] != '-'
                      ? Colors.green
                      : AppColors.brandBlue),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            child: Icon(
              PaynoteIcons.inbox_outline,
              color: transactionModel.amount[1] != '-'
                  ? Colors.green
                  : AppColors.brandBlue,
              size: 15,
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
                        transactionModel.description,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.brandBlue,
                            fontSize: 36.nsp,
                            fontFamily: 'Alata'),
                      ),
                      SizedBox(height: 5.r),
                      Text(
                        transactionModel.categoryType,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${transactionModel.amount[1] != '-' ? StringUtils.insertStringAtIndex(transactionModel.amount, 1, '+') : transactionModel.amount}',
                      style: TextStyle(
                          color: transactionModel.amount[1] != '-'
                              ? Colors.green
                              : AppColors.brandBlue,
                          fontSize: 36.nsp,
                          fontFamily: 'Alata'),
                    ),
                    SizedBox(height: 5.r),
                    Text(
                      transactionModel.originalDate.substring(0, 15),
                      style: TextStyle(
                          color: Colors.red, fontSize: 24.nsp, fontFamily: 'Alata'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
