import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/TransactionModel.dart';
import 'package:paynote_app/Api/TransactionSortedDateModel.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/ui/widgets/global/TransactionTile.dart';
import 'package:paynote_app/utils/Constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paynote_app/ui/widgets/global/SubscriptionTile.dart';
import 'package:paynote_app/Api/RecurringData.dart';
import 'package:paynote_app/ui/widgets/global/OverLayWidget.dart';

import 'RecurringCostsViewModel.dart';

class RecurringCostsView extends StatelessWidget {
  List _mockedPageData = [
    {
      "RecurringCosts": {
        "perYear": "501811.55",
        "perMonth": "8422.62",
      },
      "TransactionsData": [
        {
          "Data": "27/12/2020",
          "transactionName": "Starbucks",
          "accName": "SharedHome",
          "Type": 1,
          "value": 6.75,
        },
        {
          "Data": "24/12/2020",
          "transactionName": "Albert Heijn",
          "accName": "Sparks",
          "Type": 1,
          "value": 26.15,
        },
        {
          "Data": "8/4/2020",
          "transactionName": "Dunder Mifflin Supplies All For one",
          "accName": "Salary",
          "Type": 2,
          "value": 600.76,
        },
      ]
    }
  ];

  NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecurringCostsViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: model.isBusy
              ? OverLayWidget(
                  title: 'Constructing...',
                  description: 'we are building your dashboard',
                )
              : mainBody(context, model),
        );
      },
      onModelReady: (model) => model.fetchRecurringsTrans(),
      viewModelBuilder: () => RecurringCostsViewModel(),
    );
  }

  Widget mainBody(BuildContext context, RecurringCostsViewModel model) {
    return Column(
      children: <Widget>[
        _topBar(context),
        _centralContent(context, model.subList, model),
        _bottomAppBar(context),
      ],
    );
  }

  Widget _topBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 100.h,
        left: 40.w,
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _navigationService.back();
                },
                child: Icon(
                  Icons.keyboard_backspace,
                  color: AppColors.brandBlue,
                  size: 80.r,
                ),
              ),
              SizedBox(height: 30.r),
              Text(
                "Recurring Costs",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AppColors.brandBlue,
                    fontSize: 60.nsp,
                    fontFamily: 'Alata'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _centralContent(BuildContext context, List<Subscriptions> transactions,
      RecurringCostsViewModel model) {
    return Expanded(
      child: ListView(
        children: [
          /// Top Metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  /// Monthly Recurring Cost
                  Text(
                    '€ ${model.month}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.brandBlue,
                        fontSize: 60.nsp,
                        fontFamily: 'Alata'),
                  ),
                  Text(
                    "per month",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.brandMediumGrey,
                        fontSize: 38.nsp,
                        fontFamily: 'Alata'),
                  ),
                ],
              ),

              /// Yearly Recurring Cost
              Column(
                children: [
                  Text(
                    '€ ${model.year}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.brandBlue,
                        fontSize: 60.nsp,
                        fontFamily: 'Alata'),
                  ),
                  Text(
                    "per year",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.brandMediumGrey,
                        fontSize: 38.nsp,
                        fontFamily: 'Alata'),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 50.r),

          /// Transactions
          (transactions != null)
              ? ListView.builder(
                  itemCount: transactions.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: GestureDetector(
                            onTap: () {
                              model.showRecurringDetial(transactions[i]);
                            },
                            child: SubscriptionTile(
                              subscriptionModel: transactions[i],
                            ),
                          ),
                        ),
                      ],
                    );
                  })
              : Container(
                  child: Expanded(
                      child: Center(
                    child: Text(
                      "You have no recurring transactions",
                      style: TextStyle(
                          color: AppColors.brandDarkGrey,
                          fontSize: 43.nsp,
                          fontFamily: 'Alata'),
                    ),
                  )),
                ),
          SizedBox(height: 80.r),

          /// I'm missing text
          Text(
            "I'm missing something",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.brandBlue,
              fontSize: 32.nsp,
              decoration: TextDecoration.underline,
            ),
          ),

          SizedBox(height: 80.r),

          /// Removed as recurring costs
          /*  ExpansionTile(
            title: Text(
              "Removed as recurring costs",
              style: TextStyle(
                fontFamily: "Alata",
                color: AppColors.brandBlue,
                fontSize: 48.nsp,
              ),
            ),
            children: [
              for (var transaction in transactions)
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: TransactionTile(
                    transactionModel: transaction.transaction,
                    color: AppColors.brandLightGrey,
                  ),
                ),
            ],
          ),*/
        ],
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Menu(
          bankACC_: true,
        ),
      ],
    );
  }
}
