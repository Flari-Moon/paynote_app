import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paynote_app/Api/User.dart';
import 'AccountsPageViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/Api/AccountsModel.dart';
import 'package:flutter_screenutil/size_extension.dart';

class AccountsPageView extends StatelessWidget {
  AccountsPageView(
      {@required this.user,
      @required this.accounts,
      @required this.valueDouble});
  User user;
  List<AccountsModel> accounts;
  /* List _mockedUserPreferences = ["\$", ""];
  List _mockedBankData = [
    {
      "accName": "Spending",
      "value": 214.66,
      "accountNumber": "NL 11 RABO 010101010001",
      "bank": "Rabobank",
      "users": [
        {"userID": "", "userImage": ""}
      ]
    },
    {
      "accName": "Saving private",
      "value": 254.33,
      "accountNumber": "NL 11 RABO 010101010001",
      "bank": "Rabobank",
      "users": [
        {"userID": "", "userImage": ""}
      ]
    },
    {
      "accName": "Home Shared family",
      "value": 50000.87,
      "accountNumber": "NL 11 RABO 010101010001",
      "bank": "Rabobank",
      "users": [
        {"userID": "", "userImage": ""}
      ]
    },
    {
      "accName": "Saving Shared",
      "value": 954.77,
      "accountNumber": "NL 11 RABO 010101010001",
      "bank": "Rabobank",
      "users": [
        {"userID": "", "userImage": ""}
      ]
    },
  ];*/

  double valueDouble = 0.00;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountsPageViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: accountsMainView(context, model),
        );
      },
      viewModelBuilder: () => AccountsPageViewModel(),
      onModelReady: (model) => {model.initLanguage()},
    );
  }

  Widget accountsMainView(BuildContext context, AccountsPageViewModel model) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.15,
          bottom: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.87,
                child: Text(
                  //"${accounts.length} bank accounts",
                  "${accounts.length} ${model.pageLanguageData["ACC1-0-10"][0][model.userLanguage.language]}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.brandDarkGrey,
                      fontSize: 43.nsp,
                      fontFamily: 'Alata'),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  child: Text(
                    "€ $valueDouble", //mocked for now
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.brandBlue,
                        fontSize: 60.nsp,
                        fontFamily: 'Alata'),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    itemCount: model.accounts.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          new Container(
                            decoration:
                                BoxDecoration(color: AppColors.brandLightGrey),
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              child: ListTile(
                                onTap: () {
                                  print(i);
                                  model.viewAccountDetails(i);
                                  // AccountsViewModel().accessAccDetails();
                                },
                                title: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.03),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                            "${accounts.elementAt(i).type}",
                                            style: TextStyle(
                                                color: AppColors.brandBlue,
                                                fontSize: 43.nsp,
                                                fontFamily: "Alata")),
                                      ),
                                      Container(
                                        child: Text(
                                            "${accounts.elementAt(i).accountNumber}",
                                            style: TextStyle(
                                                color: AppColors.brandDarkGrey,
                                                fontFamily: "Roboto",
                                                fontSize: 43.nsp)),
                                      ),
                                      /* Container(
                                        child: Text(
                                            "${_mockedBankData[i]['bank']}",
                                            style: TextStyle(
                                                color: AppColors.brandDarkGrey,
                                                fontFamily: "Roboto",
                                                fontSize: 43.nsp)))*/
                                    ],
                                  ),
                                ),
                                trailing: Container(
                                  height: 300,
                                  child: Column(
                                    children: [
                                      Text("€ ${accounts.elementAt(i).balance}",
                                          style: TextStyle(
                                              color: AppColors.brandBlue,
                                              fontSize: 48.nsp,
                                              fontFamily: "Alata")),
                                      Container(
                                          width: 50.0,
                                          height: 30.0,
                                          decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: new NetworkImage(
                                                      "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-2.jpg")))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      );
                    },
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
