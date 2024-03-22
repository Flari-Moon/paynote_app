import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/services/SharedPrefService.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:flutter_screenutil/size_extension.dart';

class FAQPage extends StatefulWidget {
  FAQPage({this.faqData});

  final List faqData;

  List _mockedFAQData = [
    [
      'Which banks are connected with Paynote?',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, \n\n\n\n sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    ],
    [
      'How can I contact Paynote?',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tincidunt augue interdum velit euismod in pellentesque massa placerat. Quam id leo in vitae turpis massa sed. Et leo duis ut diam quam nulla porttitor massa. In tellus integer feugiat scelerisque varius. Ultricies integer quis auctor elit sed. Tincidunt nunc pulvinar sapien et ligula ullamcorper malesuada proin libero. Diam ut venenatis tellus in metus vulputate eu scelerisque felis. Elementum nisi quis eleifend quam adipiscing vitae proin sagittis. Nisi vitae suscipit tellus mauris a diam maecenas sed. Nunc sed blandit libero volutpat sed cras ornare arcu. Ac placerat vestibulum lectus mauris ultrices. Eget dolor morbi non arcu risus. Ut faucibus pulvinar elementum integer enim neque volutpat. Feugiat sed lectus vestibulum mattis ullamcorper velit. Posuere ac ut consequat semper viverra nam libero justo. In fermentum posuere urna nec tincidunt praesent semper feugiat nibh.'
    ],
    [
      'What do you do with my data?',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tincidunt augue interdum velit euismod in pellentesque massa placerat. Quam id leo in vitae turpis massa sed. Et leo duis ut diam quam nulla porttitor massa. In tellus integer feugiat scelerisque varius. Ultricies integer quis auctor elit sed. Tincidunt nunc pulvinar sapien et ligula ullamcorper malesuada proin libero. Diam ut venenatis tellus in metus vulputate eu scelerisque felis. Elementum nisi quis eleifend quam adipiscing vitae proin sagittis. Nisi vitae suscipit tellus mauris a diam maecenas sed. Nunc sed blandit libero volutpat sed cras ornare arcu. Ac placerat vestibulum lectus mauris ultrices. Eget dolor morbi non arcu risus. Ut faucibus pulvinar elementum integer enim neque volutpat. Feugiat sed lectus vestibulum mattis ullamcorper velit. Posuere ac ut consequat semper viverra nam libero justo. In fermentum posuere urna nec tincidunt praesent semper feugiat nibh.'
    ],
    [
      'How does Paynote makes money?',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tincidunt augue interdum velit euismod in pellentesque massa placerat. Quam id leo in vitae turpis massa sed. Et leo duis ut diam quam nulla porttitor massa. In tellus integer feugiat scelerisque varius. Ultricies integer quis auctor elit sed. Tincidunt nunc pulvinar sapien et ligula ullamcorper malesuada proin libero. Diam ut venenatis tellus in metus vulputate eu scelerisque felis. Elementum nisi quis eleifend quam adipiscing vitae proin sagittis. Nisi vitae suscipit tellus mauris a diam maecenas sed. Nunc sed blandit libero volutpat sed cras ornare arcu. Ac placerat vestibulum lectus mauris ultrices. Eget dolor morbi non arcu risus. Ut faucibus pulvinar elementum integer enim neque volutpat. Feugiat sed lectus vestibulum mattis ullamcorper velit. Posuere ac ut consequat semper viverra nam libero justo. In fermentum posuere urna nec tincidunt praesent semper feugiat nibh.'
    ],
    [
      'How can I delete my account?',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tincidunt augue interdum velit euismod in pellentesque massa placerat. Quam id leo in vitae turpis massa sed. Et leo duis ut diam quam nulla porttitor massa. In tellus integer feugiat scelerisque varius. Ultricies integer quis auctor elit sed. Tincidunt nunc pulvinar sapien et ligula ullamcorper malesuada proin libero. Diam ut venenatis tellus in metus vulputate eu scelerisque felis. Elementum nisi quis eleifend quam adipiscing vitae proin sagittis. Nisi vitae suscipit tellus mauris a diam maecenas sed. Nunc sed blandit libero volutpat sed cras ornare arcu. Ac placerat vestibulum lectus mauris ultrices. Eget dolor morbi non arcu risus. Ut faucibus pulvinar elementum integer enim neque volutpat. Feugiat sed lectus vestibulum mattis ullamcorper velit. Posuere ac ut consequat semper viverra nam libero justo. In fermentum posuere urna nec tincidunt praesent semper feugiat nibh.'
    ],
    ['How can I change my phone number?', 'malesuada fames ac turpis egestas'],
    [
      'How does Paynote protect my account and data?',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lacus sed viverra tellus in. Venenatis cras sed felis eget velit. Aliquet lectus proin nibh nisl condimentum id. Faucibus scelerisque eleifend donec pretium vulputate sapien nec.'
    ],
    [
      'What are terms of use for Paynote?',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lacus sed viverra tellus in. Venenatis cras sed felis eget velit. Aliquet lectus proin nibh nisl condimentum id. Faucibus scelerisque eleifend donec pretium vulputate sapien nec.'
    ],
  ];

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  SharedPrefService _sharedPrefService = locator<SharedPrefService>();

  Language userLanguage;
  var pageLanguageData;

  initLanguage() {
    //userLanguage = _sharedPrefService.loadProfileLanguage();

    pageLanguageData = json.decode(SharedPref().getString('translationTag'));
    userLanguage = Language(language: SharedPref().getString('language'));

    // print(userLanguage.language);
    // print('USER LANGUAGE: ${(SharedPref().getString('language'))}');
    // print(
    //     "THIS PRINT" + pageLanguageData["SIN-0-30"][0][userLanguage.language]);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    initLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(80.w, 80.h, 80.w, 80.h),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.95,
            decoration: BoxDecoration(
                color: AppColors.brandWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Profile",
                          style: TextStyle(
                              color: AppColors.brandDarkGrey,
                              fontFamily: "Alata",
                              fontSize: 48.nsp)),
                      Expanded(child: SizedBox()),
                      IconButton(
                        splashRadius: 60,
                        focusColor: AppColors.brandDarkGrey,
                        icon: Icon(PaynoteIcons.close_outline, size: 35),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                      //"FAQ",
                      this.pageLanguageData["PRO-4-00"][0]
                          [this.userLanguage.language],
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontSize: 60.nsp,
                          fontFamily: "Alata"),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    child: Text(
                      //"All the frequently asked questions",
                      this.pageLanguageData["PRO-4-10"][0]
                          [this.userLanguage.language],
                      style: TextStyle(
                          color: AppColors.brandDarkGrey,
                          fontSize: 38.nsp,
                          fontFamily: "Alata"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: widget._mockedFAQData.length,
                        itemBuilder: (context, i) {
                          return new ExpansionTile(
                            tilePadding: EdgeInsets.symmetric(horizontal: 0),
                            title: new Text(
                              widget._mockedFAQData[i][0],
                              style: new TextStyle(
                                  fontSize: 48.nsp,
                                  color: AppColors.brandBlue,
                                  fontFamily: "Alata"),
                            ),
                            children: <Widget>[
                              new Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.brandDarkGrey),
                                        color: AppColors.brandLightGrey),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      widget._mockedFAQData[i][1],
                                      style: TextStyle(
                                          color: AppColors.brandBlue,
                                          fontSize: 43.nsp),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
