import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'package:flutter/services.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:paynote_app/Api/ApiClientService.dart';

import 'package:paynote_app/ui/views/Homepage/HomepageView.dart';

import 'homepageOverlay.dart';

//import 'package:pin_code_text_field/pin_code_text_field.dart';

class Homepage extends StatefulWidget {
  Homepage(
      {Key key,
      this.phoneNumber,
      this.userName,
      this.userSurname,
      this.email,
      this.user,
      this.image_file})
      : super(key: key);

  final User user;

  final String phoneNumber;
  final String userName;
  final String userSurname;
  final String email;
  final bool bankAccounts = false;

  final File image_file;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _confirmEmail = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
      ),
      home: Scaffold(
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
        top: MediaQuery.of(context).size.height * 0.051,
        left: 30,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Welcome",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.brandMediumGrey,
                      fontSize: 38.nsp,
                      fontFamily: 'Alata'),
                ),
                Text(
                  "${widget.userName}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.brandBlue,
                      fontSize: 60.nsp,
                      fontFamily: 'Alata'),
                ),
              ],
            ),
          ],
        ));
  }

  Widget get _centralContent {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.2,
      bottom: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset("Assets/Illustrations/Tech_5.png")),
          ),
          Center(
              child: Text(
            "You have no accounts yet",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColors.brandBlue,
                fontSize: 68.nsp,
                fontFamily: 'Alata'),
          )),
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "When you're ready, connect your first account to start with paynote!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.brandMediumGrey,
                        fontSize: 38.nsp,
                        fontFamily: 'Alata'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get _bottomAppBar {
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
              onPressed: () {
                showGeneralDialog(
                  barrierLabel: "Label",
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: Duration(milliseconds: 600),
                  context: context,
                  pageBuilder: (context, anim1, anim2) {
                    return HomepageOverlay();
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
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                    child: Text(
                  "Add a new bank account",
                  style: TextStyle(
                      color: AppColors.brandWhite,
                      fontFamily: 'Alata',
                      fontSize: 48.nsp),
                )),
              )),
          Container(
            height: 15,
          ),
          Menu(
            home_: true,
          ),
        ],
      ),
    );
  }
}
