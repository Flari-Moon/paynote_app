import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:intl/intl.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/ui/views/tinkAccountLink/TinkAccountLinkView.dart';
import 'package:paynote_app/ui/widgets/global/OverLayWidget.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'AccountMainViewModel.dart';

class AccountMainView extends StatelessWidget {
  AccountMainView(
      {@required this.user,
      @required this.imageFile,
      this.accountDeleted = false});

  User user;
  File imageFile;
  bool accountDeleted;

  NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountMainViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: model.bankAccounts
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.08),
                  child: FloatingActionButton(
                    child: Icon(
                      PaynoteIcons.plus,
                    ),
                    backgroundColor: AppColors.brandBlue,
                    onPressed: () {
                      _navigationService.navigateWithTransition(
                        TinkAccountLinkView(user: user),
                        transition: "leftToRight",
                      );
                    },
                  ),
                )
              : null,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _topBar(context, model),
              model.bankAccounts == true
                  ? (model.isBusy
                      ? OverLayWidget(
                          title: 'Constructing...',
                          description: 'we are getting your accounts...',
                        )
                      : accountsMainView(context, model))
                  : _centralContent(context, model),
              _bottomAppBar(context, model),
            ],
          ),
        );
      },
      viewModelBuilder: () => AccountMainViewModel(),
      onModelReady: (model) async {
        await model.getUserAccounts(context);
        model.setAccountDeleted(accountDeleted);
        model.initLanguage();
      },
    );
  }

  Widget _topBar(BuildContext context, AccountMainViewModel model) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30.w,
        right: 80.w,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 200.h),
        Text(
          //"Accounts",
          model.pageLanguageData["ACC-0-00"][0][model.userLanguage.language],
          textAlign: TextAlign.left,
          style: TextStyle(
              color: AppColors.brandBlue,
              fontSize: 60.nsp,
              fontFamily: 'Alata'),
        ),
      ]),
    );
  }

  Widget _centralContent(BuildContext context, AccountMainViewModel model) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          top: 50.h,
          left: 70.w,
          right: 70.w,
        ),
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.asset("Assets/Illustrations/Tech_1.png")),
            ),
            Center(
                child: Text(
              //"You have no accounts yet",
              model.pageLanguageData["ACC-0-10"][0]
                  [model.userLanguage.language],
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.brandBlue,
                  fontSize: 62.nsp,
                  fontFamily: 'Alata'),
            )),
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  //"When you're ready, connect your first account to start with paynote!",
                  model.pageLanguageData["ACC-0-20"][0]
                      [model.userLanguage.language],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.brandMediumGrey,
                      fontSize: 48.nsp,
                      fontFamily: 'Roboto'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context, AccountMainViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        model.bankAccounts == false
            ? RaisedButton(
                elevation: 0,
                color: AppColors.brandBlue,
                disabledColor: AppColors.brandLightGrey,
                onPressed: () {
                  _navigationService.navigateWithTransition(
                    TinkAccountLinkView(user: user),
                    transition: "leftToRight",
                  );
                  // showGeneralDialog(
                  //   barrierLabel: "Label",
                  //   barrierDismissible: true,
                  //   barrierColor: Colors.black.withOpacity(0.5),
                  //   transitionDuration: Duration(milliseconds: 600),
                  //   context: context,
                  //   pageBuilder: (context, anim1, anim2) {
                  //     return HomepageOverlay();
                  //   },
                  //   transitionBuilder: (context, anim1, anim2, child) {
                  //     return SlideTransition(
                  //       position:
                  //       Tween(begin: Offset(0, 1), end: Offset(0, 0))
                  //           .animate(anim1),
                  //       child: child,
                  //     );
                  //   },
                  // );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Center(
                      child: Text(
                    //"Add a new bank account",
                    model.pageLanguageData["ACC-0-30"][0]
                        [model.userLanguage.language],
                    style: TextStyle(
                        color: AppColors.brandWhite,
                        fontFamily: 'Alata',
                        fontSize: 48.nsp),
                  )),
                ))
            : Container(),
        Container(
          height: 15,
        ),
        Menu(
          bankACC_: true,
        ),
      ],
    );
  }

  Widget accountsMainView(BuildContext context, AccountMainViewModel model) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          top: 50.h,
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.87,
              child: Text(
                "${model.accounts.length} bank accounts",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AppColors.brandDarkGrey,
                    fontSize: 16,
                    fontFamily: 'Alata'),
              ),
            ),
            Container(
              height: 20.h,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.87,
                child: Text(
                  "${NumberFormat.currency(name: 'eu', symbol: '€').format(model.totalBalance)}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.brandBlue,
                      fontSize: 32,
                      fontFamily: 'Alata'),
                )),
            Visibility(
              visible: model.accountDeleted,
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 100.w,
                  vertical: 50.h,
                ),
                margin: EdgeInsets.symmetric(vertical: 30.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Bank account deleted",
                        style: TextStyle(
                            color: AppColors.brandWhite,
                            fontSize: 38.nsp,
                            fontFamily: "Alata",
                            fontWeight: FontWeight.bold)),
                    Expanded(child: SizedBox()),
                    /* Text("Undo",
                        style: TextStyle(
                            color: AppColors.brandWhite,
                            fontSize: 38.nsp,
                            fontFamily: "Alata")),
                    Icon(
                      PaynoteIcons.chevron_right,
                      color: AppColors.brandWhite,
                      size: 70.r,
                    ),*/
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: model.accounts.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      new Container(
                        decoration:
                            BoxDecoration(color: AppColors.brandLightGrey),
                        child: Container(
                          child: ListTile(
                            onTap: () {
                              print(i);
                              model.viewAccountDetails(i, imageFile);
                              // AccountsViewModel().accessAccDetails();
                            },
                            title: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                        "${model.accounts.elementAt(i).type}",
                                        style: TextStyle(
                                            color: AppColors.brandBlue,
                                            fontSize: 40.nsp,
                                            fontFamily: "Alata")),
                                  ),
                                  Container(
                                    child: Text(
                                        "${model.accounts.elementAt(i).accountNumber}",
                                        style: TextStyle(
                                            color: AppColors.brandDarkGrey,
                                            fontFamily: "Roboto",
                                            fontSize: 40.nsp)),
                                  ),
                                  /*  Container(
                                      child: Text(
                                          "${_mockedBankData[i]['bank']}",
                                          style: TextStyle(
                                              color: AppColors.brandDarkGrey,
                                              fontFamily: "Roboto",
                                              fontSize: 40.nsp)))*/
                                ],
                              ),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    "${NumberFormat.currency(name: 'eu', symbol: '€').format(model.accounts.elementAt(i).balance)}",
                                    style: TextStyle(
                                        color: AppColors.brandBlue,
                                        fontSize: 48.nsp,
                                        fontFamily: "Alata")),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30.h,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
