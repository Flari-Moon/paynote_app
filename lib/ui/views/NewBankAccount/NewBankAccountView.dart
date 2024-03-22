import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/models/Home/homepageOverlay.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'package:stacked/stacked.dart';

import 'NewBankAccountViewModel.dart';

class NewBankAccountView extends StatelessWidget {
  NewBankAccountView({this.bankData});

  final List bankData;

  List _mockedBankData = [
    [
      [
        'https://cdn5.vectorstock.com/i/thumb-large/77/94/your-logo-here-placeholder-symbol-vector-25817794.jpg',
        'Name of the Bank here'
      ],
      [
        'https://cdn5.vectorstock.com/i/thumb-large/77/94/your-logo-here-placeholder-symbol-vector-25817794.jpg',
        'Name of the Bank here'
      ],
      [
        'https://cdn5.vectorstock.com/i/thumb-large/77/94/your-logo-here-placeholder-symbol-vector-25817794.jpg',
        'Name of the Bank here'
      ],
      [
        'https://cdn5.vectorstock.com/i/thumb-large/77/94/your-logo-here-placeholder-symbol-vector-25817794.jpg',
        'Name of the Bank here'
      ],
    ],
    [
      [
        'https://cdn5.vectorstock.com/i/thumb-large/77/94/your-logo-here-placeholder-symbol-vector-25817794.jpg',
        'Name of the Bank here'
      ],
      [
        'https://cdn5.vectorstock.com/i/thumb-large/77/94/your-logo-here-placeholder-symbol-vector-25817794.jpg',
        'Name of the Bank here'
      ],
      [
        'https://cdn5.vectorstock.com/i/thumb-large/77/94/your-logo-here-placeholder-symbol-vector-25817794.jpg',
        'Name of the Bank here'
      ],
      [
        'https://cdn5.vectorstock.com/i/thumb-large/77/94/your-logo-here-placeholder-symbol-vector-25817794.jpg',
        'Name of the Bank here'
      ],
    ]
  ];
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewBankAccountViewModel>.reactive(
      builder: (context, model, child) {
        return Container(
          padding: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.04, 0, 0),
          child: Material(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            child: Container(
              child: Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  _topBar(context),
                  _centralContent(context),
                  _bottomAppBar(context, model),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => NewBankAccountViewModel(),
      //onModelReady: (model) => model.imageCreate(user.picture),
    );
  }

  Widget _topBar(BuildContext context) {
    return Positioned(
        width: MediaQuery.of(context).size.width * 0.9,
        top: MediaQuery.of(context).size.height * 0.02,
        left: 30,
        child: Row(
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(PaynoteIcons.close),
                        onPressed: () {},
                        iconSize: 35,
                        color: AppColors.brandBlue,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Text(
                        "Select your bank",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: AppColors.brandBlue,
                            fontSize: 70.nsp,
                            fontFamily: 'Alata'),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Icon(
                        PaynoteIcons.search_outline,
                        size: 35,
                      ),
                      Text(
                        "Placeholder for Searchbar",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: AppColors.brandBlue,
                            fontSize: 38.nsp,
                            fontFamily: 'Alata'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _centralContent(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.2,
        bottom: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                itemCount: this._mockedBankData[0].length,
                itemBuilder: (context, i) {
                  return new Container(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.46,
                          height: MediaQuery.of(context).size.height * 0.13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border(
                              top: BorderSide(
                                  width: 1.0, color: AppColors.brandLightGrey),
                              left: BorderSide(
                                  width: 1.0, color: AppColors.brandLightGrey),
                              right: BorderSide(
                                  width: 1.0, color: AppColors.brandLightGrey),
                              bottom: BorderSide(
                                  width: 1.0, color: AppColors.brandLightGrey),
                            ),
                          ),
                          child: RaisedButton(
                              child: Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.12,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: new NetworkImage(
                                                "${this._mockedBankData[0][i][0]}",
                                              )))),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.217,
                                      child: Text(
                                        "${this._mockedBankData[0][i][1]}",
                                        style: TextStyle(
                                            color: AppColors.brandBlue,
                                          fontSize: 38.nsp,
                                        ),
                                      ))
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: AppColors.brandWhite,
                              elevation: 0.0,
                              onPressed: () {}),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                itemCount: this._mockedBankData[0].length,
                itemBuilder: (context, i) {
                  return new Container(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.46,
                          height: MediaQuery.of(context).size.height * 0.13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border(
                              top: BorderSide(
                                  width: 1.0, color: AppColors.brandLightGrey),
                              left: BorderSide(
                                  width: 1.0, color: AppColors.brandLightGrey),
                              right: BorderSide(
                                  width: 1.0, color: AppColors.brandLightGrey),
                              bottom: BorderSide(
                                  width: 1.0, color: AppColors.brandLightGrey),
                            ),
                          ),
                          child: RaisedButton(
                              child: Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.12,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: new NetworkImage(
                                                "${this._mockedBankData[0][i][0]}",
                                              )))),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.217,
                                      child: Text(
                                        "${this._mockedBankData[0][i][1]}",
                                        style: TextStyle(
                                            color: AppColors.brandBlue,
                                          fontSize: 38.nsp,
                                        ),
                                      ))
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: AppColors.brandWhite,
                              elevation: 0.0,
                              onPressed: () {}),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Widget _bottomAppBar(BuildContext context, NewBankAccountViewModel model) {
    Animation<double> animation;
    Animation<double> secondaryAnimation;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
              elevation: 0,
              color: AppColors.brandBlue,
              disabledColor: AppColors.brandLightGrey,
              onPressed: () {},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                    child: Text(
                  "Connect",
                  style: TextStyle(
                      color: AppColors.brandWhite,
                      fontFamily: 'Alata',
                      fontSize: 48.nsp,
                  ),
                )),
              )),
          Container(
            height: 15,
          ),
        ],
      ),
    );
  }
}
