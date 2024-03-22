import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/paynote_icons.dart';

import 'package:select_form_field/select_form_field.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:stacked/stacked.dart';
import 'LanguageViewModel.dart';

class LanguageOverlay extends StatelessWidget {
  LanguageOverlay({
    this.languageSettings,
  });

  final List languageSettings;

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'EN-US',
      'label': 'English',
    },
    {
      'value': 'PT-BR',
      'label': 'Português',
    },
    {
      'value': 'NL',
      'label': 'Dutch',
    },
  ];

  final List<Map<String, dynamic>> _items2 = [
    {
      'value': 'americanDollar',
      'label': 'American Dollar',
    },
    {
      'value': 'chineseYen',
      'label': 'Yen',
    },
    {
      'value': 'russianRublo',
      'label': 'Rublo',
    },
  ];

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LanguageViewModel>.reactive(
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, true);
            return true;
          },
          child: Material(
            //backgroundColor: Colors.white,
            child: Stack(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _topBar(context, model),
                _centralContent(context, model),
                _bottomAppBar(context, model),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => LanguageViewModel(),
      onModelReady: (model) => model.initLanguage(),
    );
  }

  Widget _topBar(BuildContext context, LanguageViewModel model) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50.w, 120.w, 50.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                  model.pageLanguageData["PRO-5-00"][0]
                      [model.userLanguage.language],
                  // "Settings",
                  style: TextStyle(
                      color: AppColors.brandDarkGrey,
                      fontFamily: "Alata",
                      fontSize: 48.nsp)),
              Expanded(child: SizedBox()),
              IconButton(
                splashRadius: 60,
                focusColor: AppColors.brandDarkGrey,
                icon: Icon(PaynoteIcons.close_outline, size: 35),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              model.pageLanguageData["PRO-9-20"][0]
                  [model.userLanguage.language],
              //"Language",
              style: TextStyle(
                  color: AppColors.brandBlue,
                  fontSize: 60.nsp,
                  fontFamily: "Alata"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _centralContent(BuildContext context, LanguageViewModel model) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.2,
      child: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.95,
                    decoration: BoxDecoration(
                        color: AppColors.brandWhite,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30))),
                    child: Material(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            // child: ListTile(
                            //   title: Text(
                            //     "Currency",
                            //     style: TextStyle(
                            //         color: AppColors.brandBlue,
                            //         fontFamily: "Roboto",
                            //         fontSize: 43.nsp),
                            //   ),
                            //   trailing: Container(
                            //     width: MediaQuery.of(context).size.width * 0.55,
                            //     child: SelectFormField(
                            //       initialValue: 'americanDollar',
                            //       icon: Icon(Icons.monetization_on),
                            //       labelText: 'Currency',
                            //       items: widget._items2,
                            //       onChanged: (val) => print(val),
                            //       onSaved: (val) => print(val),
                            //     ),
                            //   ),
                            // ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ListTile(
                              title: Text(
                                //"Language",
                                model.pageLanguageData["PRO-9-20"][0]
                                    [model.userLanguage.language],
                                style: TextStyle(
                                    color: AppColors.brandBlue,
                                    fontFamily: "Roboto",
                                    fontSize: 43.nsp),
                              ),
                              trailing: Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: SelectFormField(
                                  initialValue: model.userLanguage.language,
                                  icon: Icon(PaynoteIcons.flag),
                                  labelText: model.pageLanguageData["PRO-9-20"]
                                      [0][model.userLanguage.language],
                                  controller:
                                      model.textEditingControllerLanguage,
                                  items: _items,
                                  onChanged: (val) => model.editLanguageLocal(
                                      Language(language: val), context),
                                  onSaved: (val) => print(val),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                          ),
                          // RaisedButton(
                          //     elevation: 0,
                          //     color: AppColors.brandBlue,
                          //     disabledColor: AppColors.brandLightGrey,
                          //     onPressed: () {
                          //       print("Save Changes");
                          //     },
                          //     child: Container(
                          //       width: MediaQuery.of(context).size.width * 0.8,
                          //       height: MediaQuery.of(context).size.height * 0.08,
                          //       child: Center(
                          //           child: Text(
                          //         "Save Changes",
                          //         style: TextStyle(
                          //             color: AppColors.brandWhite,
                          //             fontFamily: 'Alata',
                          //             fontSize: 48.nsp),
                          //       )),
                          //     )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context, LanguageViewModel model) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.05,
      left: 0,
      right: 0,
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 50.w,
            vertical: 30.h,
          ),
          child: Container()),
    );
  }
}
