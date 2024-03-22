import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paynote_app/Api/SubscriptionModel.dart';
import 'package:paynote_app/Api/TransactionSortedDateModel.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/ui/views/recurringCosts/RecurringCostsViewModel.dart';
import 'package:paynote_app/ui/widgets/global/CacheImage.dart';
import 'package:paynote_app/ui/widgets/global/LinkedTile.dart';
import 'package:paynote_app/ui/widgets/global/TransactionTile.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paynote_app/Api/RecurringData.dart';


class RecurringTransactionsView extends StatelessWidget {
  //RecurringTransactionsView({@required this.subscriptionModel});
  RecurringTransactionsView({this.subscriptionModel});
  final TextEditingController textEditingController = TextEditingController();
  final Subscriptions subscriptionModel;
  final NavigationService _navigationService = locator<NavigationService>();
  var yearly ;

  @override
  Widget build(BuildContext context) {
    yearly = (double.tryParse(subscriptionModel.amountTransaction)*12).toStringAsPrecision(6);
    return ViewModelBuilder<RecurringCostsViewModel>.reactive(
      builder: (context, model, widget) {
        return Scaffold(
          backgroundColor: AppColors.brandWhite,
          body: Column(
            children: <Widget>[
              _topBar(context, model),
              Expanded(child: _centralContent(context, model)),
              _bottomAppBar(context, model),
            ],
          ),
        );
      },
      viewModelBuilder: () => RecurringCostsViewModel(),
    );
  }

  Widget _topBar(BuildContext context, RecurringCostsViewModel model) {
    return Column(
      children: [
        SizedBox(height: 120.h),
        Padding(
          padding: EdgeInsets.only(
            top: 50.h,
            left: 20.w,
            right: 70.w,
          ),
          child: Row(
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
        ),
        SizedBox(height: 30.h),
        Padding(
          padding: EdgeInsets.only(
            left: 60.w,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(color: Colors.grey[300])),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: CachedImage((subscriptionModel.logo==null)?'':subscriptionModel.logo,
                    width:MediaQuery.of(context).size.width * 0.2 ,
                    height:MediaQuery.of(context).size.width * 0.2 ,),
                ),
              ),
              SizedBox(
                width: 40.w,
              ),
              Expanded(
                child: Text(
                  subscriptionModel.company,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.brandBlue,
                      fontSize: 22,
                      fontFamily: "Alata"),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 70.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "€ ${subscriptionModel.amountTransaction}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: AppColors.brandBlue,
                            fontSize: 16,
                            fontFamily: "Alata"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.r),
                        child: Text(
                          '/m',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.brandMediumGrey,
                              fontSize: 10,
                              fontFamily: "Alata"),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    subscriptionModel.timestamp.date.substring(0,10),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: "Alata"),
                  ),
                ],
              ),
              SizedBox(width: 40.w),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "€$yearly",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.brandBlue,
                        fontSize: 16,
                        fontFamily: "Alata"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.r),
                    child: Text(
                      '/y',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: AppColors.brandMediumGrey,
                          fontSize: 12,
                          fontFamily: "Alata"),
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),

      ],

    );
  }

  Widget _centralContent(BuildContext context, RecurringCostsViewModel model) {
    return ListView(
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children:
          <TextSpan>[
           subscriptionModel.statusInformation.stillActive?
           TextSpan(text: "Active", style: TextStyle(color: Colors.green)) :
            TextSpan(text: "Inactive", style: TextStyle(color: Colors.grey)),
          ]),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(40.r),
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
                    subscriptionModel.category,
                    style: TextStyle(color: AppColors.brandBlue, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 40.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Divider(
            color: AppColors.brandDarkGrey,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(
                "Company details",
                style: TextStyle(
                  color: AppColors.brandBlue,
                  fontSize: 42.nsp,
                ),
              ),
              expandedAlignment: Alignment.topLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              childrenPadding: EdgeInsets.symmetric(
                horizontal: 80.w,
                vertical: 40.h,
              ),
              children: [
                Text(
                  "Name",
                  style: TextStyle(
                    color: AppColors.brandMediumGrey,
                    fontSize: 42.nsp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  ( subscriptionModel.company==null)? '':subscriptionModel.company,
                  style: TextStyle(
                    color: AppColors.brandBlue,
                    fontSize: 42.nsp,
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  "Location",
                  style: TextStyle(
                    color: AppColors.brandMediumGrey,
                    fontSize: 42.nsp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  ( subscriptionModel.address==null)? '':subscriptionModel.address,
                  style: TextStyle(
                    color: AppColors.brandBlue,
                    fontSize: 42.nsp,
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  "Website",
                  style: TextStyle(
                    color: AppColors.brandMediumGrey,
                    fontSize: 42.nsp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  ( subscriptionModel.website==null)? '':subscriptionModel.website,
                  style: TextStyle(
                    color: AppColors.brandBlue,
                    fontSize: 42.nsp,
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  "Client Number",
                  style: TextStyle(
                    color: AppColors.brandMediumGrey,
                    fontSize: 42.nsp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  (subscriptionModel.clientNumber==null)? '':subscriptionModel.clientNumber,
                  style: TextStyle(
                    color: AppColors.brandBlue,
                    fontSize: 42.nsp,
                  ),),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Divider(
            color: AppColors.brandDarkGrey,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(
                "Linked Transactions",
                style: TextStyle(color: AppColors.brandBlue, fontSize: 42.nsp),
              ),
              childrenPadding: EdgeInsets.only(left: 20.w),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var v in subscriptionModel.linked )
                  LinkedTile(linkedModel: v),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Divider(
            color: AppColors.brandDarkGrey,
          ),
        ),
        SizedBox(height: 40.h),
        Container(
          color: AppColors.brandLightBlue,
          padding: EdgeInsets.symmetric(
            horizontal: 80.w,
            vertical: 50.h,
          ),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lower your subscriptions',
                      style: TextStyle(
                        color: AppColors.brandWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        PaynoteIcons.chevron_right,
                        size: 80.r,
                        color: AppColors.brandWhite,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: 30.w,
                ),
                child: Text(
                  'Check out cheaper subscriptions with similar sellers',
                  style: TextStyle(
                    color: AppColors.brandWhite,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottomAppBar(BuildContext context, RecurringCostsViewModel model) {
    return Column(
      children: [
        // Text(
        //   'This is not a recurring cost',
        //   style: TextStyle(
        //     decoration: TextDecoration.underline,
        //     color: AppColors.brandBlue,
        //     fontSize: 36.nsp,
        //   ),
        // ),
        SizedBox(height: 20.h),
        Menu(),
      ],
    );
  }
}
