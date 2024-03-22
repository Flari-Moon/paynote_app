import 'package:flutter/material.dart';
import 'package:paynote_app/Api/RecurringData.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/paynote_icons.dart';

class SubscriptionTile extends StatelessWidget{
   SubscriptionTile({
    this.subscriptionModel,
  });

   final Subscriptions subscriptionModel;

   @override
   Widget build(BuildContext context) {
     return Container(
       padding: EdgeInsets.symmetric(
         horizontal: 60.r,
         vertical: 20.r,
       ),
       color: AppColors.brandLightGrey,
       child: Row(
         children: [

           /// Left Icon
           Container(
             padding: EdgeInsets.all(10.r),
             decoration: BoxDecoration(
               border: Border.all(),
               borderRadius: BorderRadius.all(Radius.circular(100)),
             ),
             child: Icon(
               PaynoteIcons.inbox_outline,
               color: AppColors.brandBlue,
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
                   width: MediaQuery.of(context).size.width * 0.5,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         subscriptionModel.company,
                         textAlign: TextAlign.left,
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                         style: TextStyle(
                             color: AppColors.brandBlue,
                             fontSize: 35.nsp,
                             fontFamily: 'Alata'),
                       ),
                       SizedBox(height: 5.r),
                       Text(
                         subscriptionModel.description,
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
                       '€${subscriptionModel.amountTransaction}',
                       style: TextStyle(
                           color: AppColors.brandBlue,
                           fontSize: 40.nsp,
                           fontFamily: 'Alata'),
                     ),
                     SizedBox(height: 5.r),
                     Text(
                       subscriptionModel.timestamp.date.substring(0, 10),
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