import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/ui/views/accountsDetail/DeleteAccountOverlay.dart';
import 'package:paynote_app/ui/widgets/global/SubscriptionTile.dart';
import 'package:paynote_app/ui/widgets/global/TransactionTile.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:stacked_services/stacked_services.dart';
import 'AccountsDetailViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:paynote_app/Api/AccountsModel.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/ui/widgets/global/OverLayWidget.dart';

class AccountsDetailView extends StatelessWidget {
  AccountsDetailView(
      {@required this.account,
      @required this.user,
      @required this.imageFile,
      @required this.accTransactionDetails});

  AccountsModel account;
  User user;
  File imageFile;
  String accName;
  String accNumber;
  double accTotalValue;
  List accTransactionDetails;
  List recurringCostsDetails;

  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountsDetailViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: model.isBusy
              ? OverLayWidget(
                  title: model.pageLanguageData["LOA-4-00"][0]
                      [model.userLanguage.language],
                  description: model.pageLanguageData["LOA-4-10"][0]
                      [model.userLanguage.language],
                )
              : homeScreen(context, model),
        );
      },
      onModelReady: (model) async {
        model.initLanguage();
        await model.getTransactions(context, account);
        await model.fetchRecurringsTrans(account);
      },
      viewModelBuilder: () => AccountsDetailViewModel(),
    );
  }

  Widget homeScreen(BuildContext context, AccountsDetailViewModel model) {
    return Column(
      children: <Widget>[
        _topBar(context, model),
        _centralContent(context, model),
        _bottomAppBar,
      ],
    );
  }

  Widget _topBar(BuildContext context, AccountsDetailViewModel model) {
    return Padding(
      padding: EdgeInsets.only(
        top: 100.h,
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
              IconButton(
                icon: Icon(PaynoteIcons.settings_outline),
                color: AppColors.brandBlue,
                iconSize: 70.r,
                onPressed: () {
                  showGeneralDialog(
                    barrierLabel: "Label",
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.1),
                    transitionDuration: Duration(milliseconds: 600),
                    context: context,
                    pageBuilder: (context, anim1, anim2) {
                      return DeleteAccountOverlay(
                          account: account, user: user, imageFile: imageFile);
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
                        child: FadeTransition(
                          child: SlideTransition(
                            position:
                                Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                    .animate(anim1),
                            child: child,
                          ),
                          opacity: anim1,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Container(
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                //"${widget.accName}",

                account.type,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AppColors.brandBlue,
                    fontSize: 60.nsp,
                    fontFamily: 'Alata'),
              ),
              trailing: Text("€ ${account.balance} ",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: AppColors.brandBlue,
                      fontSize: 60.nsp,
                      fontFamily: 'Alata')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _centralContent(BuildContext context, AccountsDetailViewModel model) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.w),
            child: Text(
              //"${widget.accNumber}",
              account.accountNumber,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.brandDarkGrey,
                  fontSize: 43.nsp,
                  fontFamily: 'Alata'),
            ),
          ),
          Container(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  //"Recurring costs",
                  model.pageLanguageData["HOM-2-00"][0]
                      [model.userLanguage.language],
                  style: TextStyle(
                      color: AppColors.brandDarkGrey,
                      fontSize: 43.nsp,
                      fontFamily: 'Alata'),
                ),

                /// Right Arrow Icon
                GestureDetector(
                  onTap: () {
                    _navigationService.navigateTo(Routes.recurringCostsView);
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
          Flexible(
            child: (model.subscriptionList != null)
                ? ListView.builder(
                    itemCount: model.subscriptionList.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: GestureDetector(
                              onTap: () {
                                model.showRecurringDetial(
                                    model.subscriptionList[i]);
                              },
                              child: SubscriptionTile(
                                subscriptionModel: model.subscriptionList[i],
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
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transaction",
                  style: TextStyle(
                      color: AppColors.brandDarkGrey,
                      fontSize: 43.nsp,
                      fontFamily: 'Alata'),
                ),

                /// Right Arrow Icon
                GestureDetector(
                  onTap: () {
                    _navigationService.navigateTo(Routes.transactionsAllAccView,
                        arguments: TransactionsAllAccViewArguments(
                            transactionList: null));
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
          Flexible(
            /* child: NotificationListener<ScrollEndNotification>(
              onNotification: (scrollEnd) {
                var metrics = scrollEnd.metrics;
                if (metrics.atEdge) {
                  if (metrics.pixels != 0) {
                    _navigationService.navigateTo(Routes.transactionsAllAccView,
                        arguments: TransactionsAllAccViewArguments(
                            transactionList: null));
                  }
                }
                return true;
              },*/
            child: (model.transactionList != null)
                ? ListView.builder(
                    itemCount: model.transactionList.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          _navigationService.navigateTo(
                              Routes.transactionsDetailView,
                              arguments: TransactionsDetailViewArguments(
                                  transactionModel:
                                      model.transactionList[i].transaction));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: TransactionTile(
                            transactionModel:
                                model.transactionList[i].transaction,
                          ),
                        ),
                      );
                    })
                : Container(
                    child: Expanded(
                        child: Center(
                      child: Text(
                        "You have no transactions",
                        style: TextStyle(
                            color: AppColors.brandDarkGrey,
                            fontSize: 43.nsp,
                            fontFamily: 'Alata'),
                      ),
                    )),
                  ),
            /* ),*/
          ),
        ],
      ),
    );
  }

  Widget get _bottomAppBar {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 15,
        ),
        Menu(
          bankACC_: true,
        ),
      ],
    );
  }
}
