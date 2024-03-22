import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/models/Settings/privacy.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/services/SharedPrefService.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:paynote_app/ui/views/accessCode/AccessCodeView.dart';
import 'appearence.dart';
import 'LanguageView.dart';
import 'notifications.dart';
import 'package:flutter_screenutil/size_extension.dart';

//import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:paynote_app/Api/ApiClientService.dart';

class Settings extends StatefulWidget {
  Settings(
      {Key key,
      this.phoneNumber,
      this.userName,
      this.userSurname,
      this.email,
      this.imagefile,
      this.user})
      : super(key: key);

  final String phoneNumber;
  final String userName;
  final String userSurname;
  final String email;
  final File imagefile;
  final User user;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _confirmEmail = false;
  NavigationService _navigationService = locator<NavigationService>();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            _topBar,
            _centralContent,
            _bottomAppBar,
          ],
        ),
      ),
    );
  }

  Widget get _topBar {
    File _image;
    return Padding(
      padding: EdgeInsets.only(
        top: 100.h,
        left: 50.w,
        bottom: 50.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //FlatButton(onPressed: null, child: Icon())
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  PaynoteIcons.arrow_back_outline,
                  size: 40,
                ),
              ),
              Container(
                width: 40,
              ),
              Container(
                child: Text(
                  //"Profile",
                  this.pageLanguageData["PRO-5-01"][0]
                      [this.userLanguage.language],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.brandMediumGrey,
                      fontSize: 38.nsp,
                      fontFamily: 'Alata'),
                ),
              )
            ],
          ),
          Container(
            height: 20,
          ),
          Container(
              child: Text(
            //Settings",
            this.pageLanguageData["PRO-5-00"][0][this.userLanguage.language],
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColors.brandBlue,
                fontSize: 60.nsp,
                fontFamily: 'Alata'),
          )),
          Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Text(
                //"Account settings",
                this.pageLanguageData["PRO-5-10"][0]
                    [this.userLanguage.language],
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AppColors.brandMediumGrey,
                    fontSize: 38.nsp,
                    fontFamily: 'Alata'),
              )),
        ],
      ),
    );
  }

  Widget get _centralContent {
    return Expanded(
      child: Column(
        children: <Widget>[
          _confirmEmail == true
              ? Container(
                  padding: EdgeInsets.all(50.r),
                  color: AppColors.brandOrange,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.brandWhite, width: 2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Icons.move_to_inbox,
                        color: AppColors.brandWhite,
                      ),
                    ),
                    title: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.height * 0.6,
                            child: Text(
                              "Verify your email",
                              style: TextStyle(
                                  color: AppColors.brandWhite,
                                  fontFamily: "Roboto",
                                  fontSize: 38.nsp,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.height * 0.6,
                            child: Text(
                              "Please confirm ${widget.user.email}",
                              style: TextStyle(
                                color: AppColors.brandWhite,
                                fontSize: 38.nsp,
                                fontFamily: "Roboto",
                              ),
                            )),
                      ],
                    ),
                  ),
                )
              : Container(),
          // ListTile(
          //   contentPadding: EdgeInsets.symmetric(horizontal: 50.w),
          //   onTap: () {
          //     //Navigator.of(context).push(NotificationsOverlay());
          //     showGeneralDialog(
          //       barrierLabel: "Label",
          //       barrierDismissible: true,
          //       barrierColor: Colors.black.withOpacity(0.5),
          //       transitionDuration: Duration(milliseconds: 600),
          //       context: context,
          //       pageBuilder: (context, anim1, anim2) {
          //         return NotificationsOverlay();
          //       },
          //       transitionBuilder: (context, anim1, anim2, child) {
          //         return SlideTransition(
          //           position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
          //               .animate(anim1),
          //           child: child,
          //         );
          //       },
          //     );
          //   },
          //   leading:
          //       Icon(PaynoteIcons.bell_outline, color: AppColors.brandBlue),
          //   title: Text(
          //     "Notifications",
          //     style: TextStyle(
          //       color: AppColors.brandBlue,
          //       fontSize: 48.nsp,
          //     ),
          //   ),
          // ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 50.w),
            onTap: () {
              //Navigator.of(context).push(LanguageOverlay());
              showGeneralDialog(
                barrierLabel: "Label",
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: Duration(milliseconds: 600),
                context: context,
                pageBuilder: (context, anim1, anim2) {
                  return LanguageOverlay();
                },
                transitionBuilder: (context, anim1, anim2, child) {
                  return SlideTransition(
                    position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                        .animate(anim1),
                    child: child,
                  );
                },
              );
            },
            leading: Icon(PaynoteIcons.chat_bubble_outline,
                color: AppColors.brandBlue),
            title: Text(
              //"Language",
              this.pageLanguageData["PRO-5-30"][0][this.userLanguage.language],
              style: TextStyle(
                color: AppColors.brandBlue,
                fontSize: 48.nsp,
              ),
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     //Navigator.of(context).push(AppearenceOverlay());
          //     showGeneralDialog(
          //       barrierLabel: "Label",
          //       barrierDismissible: true,
          //       barrierColor: Colors.black.withOpacity(0.5),
          //       transitionDuration: Duration(milliseconds: 600),
          //       context: context,
          //       pageBuilder: (context, anim1, anim2) {
          //         return AppearenceOverlay();
          //       },
          //       transitionBuilder: (context, anim1, anim2, child) {
          //         return SlideTransition(
          //           position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
          //               .animate(anim1),
          //           child: child,
          //         );
          //       },
          //     );
          //   },
          //   contentPadding: EdgeInsets.symmetric(horizontal: 50.w),
          //   leading: Icon(PaynoteIcons.color_palette_outline,
          //       color: AppColors.brandBlue),
          //   title: Text(
          //     "Appearence",
          //     style: TextStyle(
          //       color: AppColors.brandBlue,
          //       fontSize: 48.nsp,
          //     ),
          //   ),
          // ),
          ListTile(
            onTap: () {
              //Navigator.of(context).push(AccessCodeOverlay());
              showGeneralDialog(
                barrierLabel: "Label",
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: Duration(milliseconds: 600),
                context: context,
                pageBuilder: (context, anim1, anim2) {
                  return AccessCodeView();
                },
                transitionBuilder: (context, anim1, anim2, child) {
                  return SlideTransition(
                    position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                        .animate(anim1),
                    child: child,
                  );
                },
              );
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 50.w),
            leading:
                Icon(PaynoteIcons.lock_outline, color: AppColors.brandBlue),
            title: Text(
              //"Access code",
              this.pageLanguageData["PRO-5-50"][0][this.userLanguage.language],
              style: TextStyle(
                color: AppColors.brandBlue,
                fontSize: 48.nsp,
              ),
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     //Navigator.of(context).push(PrivacyOverlay());
          //     showGeneralDialog(
          //       barrierLabel: "Label",
          //       barrierDismissible: true,
          //       barrierColor: Colors.black.withOpacity(0.5),
          //       transitionDuration: Duration(milliseconds: 600),
          //       context: context,
          //       pageBuilder: (context, anim1, anim2) {
          //         return PrivacyOverlay();
          //       },
          //       transitionBuilder: (context, anim1, anim2, child) {
          //         return SlideTransition(
          //           position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
          //               .animate(anim1),
          //           child: child,
          //         );
          //       },
          //     );
          //   },
          //   contentPadding: EdgeInsets.symmetric(horizontal: 50.w),
          //   leading: Icon(PaynoteIcons.cloud_upload_outline,
          //       color: AppColors.brandBlue),
          //   title: Text(
          //     "Privacy",
          //     style: TextStyle(
          //       color: AppColors.brandBlue,
          //       fontSize: 48.nsp,
          //     ),
          //   ),
          // ),
          // ListTile(
          //   contentPadding: EdgeInsets.symmetric(horizontal: 50.w),
          //   leading:
          //       Icon(PaynoteIcons.trash_outline, color: AppColors.brandBlue),
          //   title: Text(
          //     "Delete account",
          //     style: TextStyle(
          //       color: AppColors.brandBlue,
          //       fontSize: 48.nsp,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget get _bottomAppBar {
    File _image;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 15,
        ),
        Menu(
          profile_: true,
        )
      ],
    );
  }
}
