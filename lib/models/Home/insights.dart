import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:flutter/services.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:stacked_services/stacked_services.dart';
import 'homepageOverlay.dart';
import 'package:paynote_app/ui/views/tinkAccountLink/TinkAccountLinkView.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paynote_app/ui/views/tinkAccountLink/TinkAccountLinkView.dart';
import 'package:flutter_screenutil/size_extension.dart';
//import 'package:pin_code_text_field/pin_code_text_field.dart';

class Insights extends StatefulWidget {
  Insights(
      {Key key,
      this.phoneNumber,
      this.userName,
      this.userSurname,
      this.email,
      this.image_file,
      this.user})
      : super(key: key);

  final String phoneNumber;
  final String userName;
  final String userSurname;
  final String email;
  final User user;

  final File image_file;

  @override
  _InsightsState createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  bool _confirmEmail = false;

  final NavigationService _navigationService = locator<NavigationService>();

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
        top: MediaQuery.of(context).size.height * 0.1,
        left: 10,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Insights",
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
                child: Image.asset("Assets/Illustrations/Tech_4.png")),
          ),
          Center(
              child: Text(
            "You have no accounts yet",
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
                "When you're ready, connect your first account to start with paynote!",
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
    );
  }

  Widget get _bottomAppBar {
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
                _navigationService.navigateWithTransition(
                  TinkAccountLinkView(user: widget.user),
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
                //       position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
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
                  "Add a new bank account",
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
          Menu(
            insights_: true,
          ),
        ],
      ),
    );
  }
}
