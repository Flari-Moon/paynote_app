import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/User.dart';
//import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/models/profile/profile.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:stacked_services/stacked_services.dart';

import '../Home/insights.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/services/SharedPrefService.dart';

class Menu extends StatefulWidget {
  Menu({
    Key key,
    this.home_ = false,
    this.insights_,
    this.bankACC_,
    this.profile_,
  }) : super(key: key);

  final bool home_;
  final bool insights_;
  final bool bankACC_;
  final bool profile_;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool _confirmEmail = false;
  final NavigationService _navigationService = locator<NavigationService>();
  final RequestService requestService = locator<RequestService>();
  SharedPrefService _sharedPrefService = locator<SharedPrefService>();
  File imageFile;
  User user;

  @override
  Widget build(BuildContext context) {
    return menu;
  }

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
  }

  @override
  void initState() {
    super.initState();
    user = _sharedPrefService.loadProfileUser();
    getImage();
    initLanguage();
  }

  Future<void> getImage() async {
    imageFile = await _sharedPrefService.loadProfilePicture();
    setState(() {});
  }

  Widget get menu {
    return Material(
      shadowColor: Colors.black,
      elevation: 25,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xffF8F8FA), // @todo fix hex code
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: RaisedButton(
                elevation: 0,
                onPressed: () {
                  if (!widget.home_)
                    _navigationService.clearStackAndShow(Routes.dashboardView,
                        arguments: DashboardViewArguments(user: user));
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => Homepage(
                  //             userName: widget.user.firstName,
                  //           )),
                  // );
                },
                color: AppColors.brandWhite,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.home_ == true
                          ? Icon(
                              PaynoteIcons.home,
                              color: AppColors.brandLightBlue,
                            )
                          : Icon(PaynoteIcons.home_outline,
                              color: AppColors.brandBlue),
                      widget.home_ == true
                          ? Text(
                              //"Home",
                              pageLanguageData["MEN-0-00"][0]
                                  [userLanguage.language],
                              style: TextStyle(
                                color: AppColors.brandLightBlue,
                                fontSize: 38.nsp,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: RaisedButton(
            //     elevation: 0,
            //     onPressed: () {
            //       if (widget.insights_ != true) {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => Insights(
            //               userName: user.firstName,
            //               userSurname: user.lastName,
            //               phoneNumber: user.phoneNumber,
            //               image_file: imageFile,
            //               user: user,
            //             ),
            //           ),
            //         );
            //       }
            //     },
            //     color: AppColors.brandWhite,
            //     child: Container(
            //       height: MediaQuery.of(context).size.height * 0.1,
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(
            //             PaynoteIcons.bar_chart_outline,
            //             color: widget.insights_ == true
            //                 ? AppColors.brandLightBlue
            //                 : AppColors.brandBlue,
            //           ),
            //           widget.insights_ == true
            //               ? Text(
            //                   //"Insights",
            //                   pageLanguageData["MEN-0-01"][0]
            //                       [userLanguage.language],
            //                   style: TextStyle(
            //                     color: AppColors.brandLightBlue,
            //                     fontSize: 38.nsp,
            //                   ),
            //                 )
            //               : Container()
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: RaisedButton(
                elevation: 0,
                onPressed: () {
                  if (widget.bankACC_ != true) {
                    _navigationService.navigateTo(Routes.accountMainView,
                        arguments: AccountMainViewArguments(
                            user: user, imageFile: imageFile));
                    // _navigationService.navigateTo(Routes.recurringCostsView);
                  }
                },
                color: AppColors.brandWhite,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.bankACC_ == true
                          ? Icon(
                              PaynoteIcons.credit_card,
                              color: AppColors.brandLightBlue,
                            )
                          : Icon(PaynoteIcons.credit_card_outline,
                              color: AppColors.brandBlue),
                      widget.bankACC_ == true
                          ? Text(
                              //"Accounts",
                              pageLanguageData["MEN-0-02"][0]
                                  [userLanguage.language],
                              style: TextStyle(
                                color: AppColors.brandLightBlue,
                                fontSize: 38.nsp,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.brandWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.09,
                        height: MediaQuery.of(context).size.width * 0.09,
                        child: FlatButton(
                          onPressed: () {
                            if (widget.profile_ != true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile()),
                              );
                            }
                          },
                          child: Center(
                            child: imageFile == null
                                ? Text(
                                    "No Photo",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: widget.profile_ == true
                                            ? AppColors.brandLightBlue
                                            : AppColors.brandBlue,
                                        fontFamily: "Roboto",
                                        fontSize: 20.nsp),
                                  )
                                : Text(''),
                          ),
                        ),
                        decoration: imageFile == null
                            ? BoxDecoration(
                                border: Border.all(
                                    color: widget.profile_ == true
                                        ? AppColors.brandLightBlue
                                        : AppColors.brandBlue,
                                    width: 2),
                                color: AppColors.brandLightGrey,
                                borderRadius: BorderRadius.circular(200))
                            : BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(imageFile),
                                    fit: BoxFit.cover),
                                color: AppColors.brandLightGrey,
                                borderRadius: BorderRadius.circular(200)),
                      ),
                    ),
                    widget.profile_ == true
                        ? Text(
                            "${user.firstName}",
                            style: TextStyle(
                              color: AppColors.brandLightBlue,
                              fontFamily: 'Roboto',
                              fontSize: 18.nsp,
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
