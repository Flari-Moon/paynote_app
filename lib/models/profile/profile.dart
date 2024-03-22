import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/models/Settings/settings.dart';
import 'package:paynote_app/models/profile/editProfileModel.dart';
import 'package:paynote_app/models/profile/termsOfUse.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:stacked_services/stacked_services.dart';

import 'FAQPage.dart';
import 'editProfile.dart';

import 'dart:ui';
import 'package:paynote_app/services/RequestService.dart';

import 'package:paynote_app/services/SharedPrefService.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  final NavigationService _navigationService = locator<NavigationService>();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _confirmEmail = false;
  final RequestService requestService = locator<RequestService>();
  File imageFile;
  User user;
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
    user = _sharedPrefService.loadProfileUser();
    getImage();
    initLanguage();
  }

  Future<void> getImage() async {
    imageFile = await _sharedPrefService.loadProfilePicture();
    setState(() {});
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.passthrough,
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
    return Positioned(
        width: MediaQuery.of(context).size.width * 0.9,
        top: MediaQuery.of(context).size.height * 0.081,
        left: 30,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    "${user.firstName} ${user.lastName}",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColors.brandBlue,
                        fontSize: 70.nsp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Alata'),
                  ),
                ),
                Text(
                  user.phoneNumber,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.brandMediumGrey,
                      fontSize: 48.nsp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
                FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    onPressed: () {
                      print("Edit");

                      showGeneralDialog(
                        barrierLabel: "Label",
                        barrierDismissible: true,
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionDuration: Duration(milliseconds: 600),
                        context: context,
                        pageBuilder: (context, anim1, anim2) {
                          return EditProfileOverlay(
                            userName: user.firstName,
                            userSurname: user.lastName,
                            phoneNumber: user.phoneNumber,
                            isoCode: user.country,
                          );
                        },
                        transitionBuilder: (context, anim1, anim2, child) {
                          return SlideTransition(
                            position:
                                Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                    .animate(anim1),
                            child: child,
                          );
                        },
                      ).then((value) => setState(() {
                            user = _sharedPrefService.loadProfileUser();
                            getImage();
                            print('setsttecalled');
                          }));
                    },
                    child: Container(
                        child: Text(
                      //"Edit Profile",
                      this.pageLanguageData["PRO-0-00"][0]
                          [this.userLanguage.language],
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColors.brandLightBlue,
                          fontSize: 43.nsp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Alata'),
                    ))),
              ],
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: MediaQuery.of(context).size.height * 0.12,
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: FlatButton(
                      onPressed: () {
                        print("Edit");

                        showGeneralDialog(
                          barrierLabel: "Label",
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: Duration(milliseconds: 600),
                          context: context,
                          pageBuilder: (context, anim1, anim2) {
                            return EditProfileOverlay(
                              userName: user.firstName,
                              userSurname: user.lastName,
                              phoneNumber: user.phoneNumber,
                              isoCode: user.country,
                            );
                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            return SlideTransition(
                              position:
                                  Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                      .animate(anim1),
                              child: child,
                            );
                          },
                        ).then((value) => setState(() {
                              user = _sharedPrefService.loadProfileUser();
                              getImage();
                              print('setsttecalled');
                            }));
                      },
                      child: Center(
                        child: imageFile == null
                            ? Text(
                                //"No Photo",
                                this.pageLanguageData["PRO-0-01"][0]
                                    [this.userLanguage.language],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.brandLightBlue,
                                    fontFamily: "Roboto",
                                    fontSize: 43.nsp),
                              )
                            : Text(''),
                      ),
                    ),
                    decoration: imageFile == null
                        ? BoxDecoration(
                            color: AppColors.brandLightGrey,
                            borderRadius: BorderRadius.circular(200))
                        : BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(imageFile), fit: BoxFit.cover),
                            color: AppColors.brandLightGrey,
                            borderRadius: BorderRadius.circular(200)),
                  )),
            ),
          ],
        ));
  }

  Widget get _centralContent {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.23,
      bottom: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: <Widget>[
          _confirmEmail == true
              ? Container(
                  padding: EdgeInsets.all(15),
                  color: AppColors.brandOrange,
                  width: MediaQuery.of(context).size.width * 2,
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
                              //"Verify your email",
                              this.pageLanguageData["PRO-0-80"][0]
                                  [this.userLanguage.language],
                              style: TextStyle(
                                color: AppColors.brandWhite,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 38.nsp,
                              ),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.height * 0.6,
                            child: Text(
                              // "Please confirm ${user.email}",
                              "${this.pageLanguageData["PRO-0-90"][0][this.userLanguage.language]} ${user.email}",
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
          //   contentPadding: EdgeInsets.only(
          //     left: MediaQuery.of(context).size.width * 0.08,
          //   ),
          //   onTap: () {},
          //   leading:
          //       Icon(PaynoteIcons.grid_outline, color: AppColors.brandBlue),
          //   title: Text(
          //     //"Web/Desktop",
          //     this.pageLanguageData["PRO-0-10"][0][this.userLanguage.language],
          //     style: TextStyle(
          //       color: AppColors.brandBlue,
          //       fontSize: 48.nsp,
          //     ),
          //   ),
          // ),
          ListTile(
            contentPadding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.08,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Settings(
                          user: user,
                          email: user.phoneNumber,
                          imagefile: imageFile,
                        )),
              );
            },
            leading:
                Icon(PaynoteIcons.settings_outline, color: AppColors.brandBlue),
            title: Text(
              //"Settings",
              this.pageLanguageData["PRO-0-20"][0][this.userLanguage.language],
              style: TextStyle(
                color: AppColors.brandBlue,
                fontSize: 48.nsp,
              ),
            ),
          ),
          // ListTile(
          //   contentPadding: EdgeInsets.only(
          //     left: MediaQuery.of(context).size.width * 0.08,
          //   ),
          //   leading: Icon(PaynoteIcons.gift_outline,
          //       color: AppColors.brandLightBlue),
          //   title: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         //"Premium",
          //         this.pageLanguageData["PRO-0-30"][0][this.userLanguage.language],
          //         style: TextStyle(
          //           color: AppColors.brandBlue,
          //           fontSize: 48.nsp,
          //         ),
          //       ),
          //       Text(
          //         //"Try 2 weeks for free!",
          //         this.pageLanguageData["PRO-0-40"][0][this.userLanguage.language],
          //         style: TextStyle(
          //           color: AppColors.brandDarkGrey,
          //           fontSize: 38.nsp,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          ListTile(
            onTap: () {
              //Navigator.of(context).push(FAQPage());
              showGeneralDialog(
                barrierLabel: "Label",
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: Duration(milliseconds: 600),
                context: context,
                pageBuilder: (context, anim1, anim2) {
                  return FAQPage();
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
            contentPadding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.08,
            ),
            leading: Icon(PaynoteIcons.question_mark_outline,
                color: AppColors.brandBlue),
            title: Text(
              //"FAQ",
              this.pageLanguageData["PRO-0-50"][0][this.userLanguage.language],
              style: TextStyle(
                color: AppColors.brandBlue,
                fontSize: 48.nsp,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              //Navigator.of(context).push(TermsOfUSePage());
              showGeneralDialog(
                barrierLabel: "Label",
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: Duration(milliseconds: 600),
                context: context,
                pageBuilder: (context, anim1, anim2) {
                  return TermsOfUsePage();
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
            contentPadding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.08,
            ),
            leading: Icon(PaynoteIcons.file_text_outline,
                color: AppColors.brandBlue),
            title: Text(
              //"Terms of use",
              this.pageLanguageData["PRO-0-60"][0][this.userLanguage.language],
              style: TextStyle(
                color: AppColors.brandBlue,
                fontSize: 48.nsp,
              ),
            ),
          ),

          // ==================================== FOR TEST ONLY
          // ListTile(
          //   onTap: () {
          //     // widget._navigationService.navigateTo(
          //     //     Routes.transactionsDetailView,
          //     //     arguments: TransactionsDetailViewArguments());
          //     widget._navigationService.navigateTo(
          //         Routes.recurringTransactionsView,
          //         arguments: RecurringTransactionsViewArguments());
          //   },
          //   contentPadding: EdgeInsets.only(
          //     left: MediaQuery.of(context).size.width * 0.08,
          //   ),
          //   leading: Icon(PaynoteIcons.smiling_face_outline,
          //       color: AppColors.brandBlue),
          //   title: Text(
          //     "Test page",
          //     style: TextStyle(
          //       color: AppColors.brandBlue,
          //       fontSize: 48.nsp,
          //     ),
          //   ),
          // ),
          // ==================================== FOR TEST ONLY [end]
        ],
      ),
    );
  }

  Widget get _bottomAppBar {
    File _image;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // RaisedButton(
          //     elevation: 0,
          //     color: AppColors.brandBlue,
          //     disabledColor: AppColors.brandLightGrey,
          //     onPressed: () {
          //       print("logout");
          //       _confirmEmail = !_confirmEmail;
          //       setState(() {});
          //     },
          //     child: Container(
          //       width: MediaQuery.of(context).size.width * 0.8,
          //       height: MediaQuery.of(context).size.height * 0.08,
          //       child: Center(
          //           child: Text(
          //         "Logout",
          //         style: TextStyle(
          //             color: AppColors.brandWhite,
          //             fontFamily: 'Alata',
          //             fontSize: 48.nsp),
          //       )),
          //     )),
          // Container(
          //   height: 15,
          // ),
          Menu(
            profile_: true,
          ),
        ],
      ),
    );
  }
}
