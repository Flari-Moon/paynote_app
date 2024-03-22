import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/Api/AccountsModel.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:stacked_services/stacked_services.dart';

class DeleteAccountOverlay extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  final RequestService _requestService = locator<RequestService>();
  final AccountsModel account;
  final File imageFile;
  final User user;

  DeleteAccountOverlay({@required this.account, @required this.imageFile, @required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: BoxDecoration(
              color: AppColors.brandWhite,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Are you sure you want to delete the account:",
                    style: TextStyle(
                        color: AppColors.brandBlue,
                        fontFamily: "Alata",
                        fontSize: 58.nsp)),
                SizedBox(
                  height: 60.h,
                ),
                Text(account.type ?? '',
                    style: TextStyle(
                        color: AppColors.brandBlue,
                        fontFamily: "Alata",
                        fontSize: 58.nsp)),
                Text(account.accountNumber ?? '',
                    style: TextStyle(
                        color: AppColors.brandDarkGrey,
                        fontFamily: "Alata",
                        fontSize: 38.nsp)),
                SizedBox(
                  height: 90.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        onPressed: () async {
                          await _requestService.deleteUserAccount(account.userId, account.accountId,context);
                          _navigationService.clearTillFirstAndShow(Routes.accountMainView, arguments: AccountMainViewArguments(user: user, imageFile: imageFile, accountDeleted: true));
                        },
                        padding: EdgeInsets.symmetric(vertical: 50.h),
                        child: Text("Yes, delete the account",
                            style: TextStyle(
                                color: AppColors.brandBlue,
                                fontFamily: "Alata",
                                fontSize: 43.nsp,
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                          elevation: 0,
                          color: AppColors.brandBlue,
                          disabledColor: AppColors.brandLightGrey,
                          onPressed: () {
                            _navigationService.back();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                                child: Text(
                              "No don't delete",
                              style: TextStyle(
                                  color: AppColors.brandWhite,
                                  fontFamily: 'Alata',
                                  fontSize: 43.nsp),
                            )),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
