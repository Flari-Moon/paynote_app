import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paynote_app/ui/views/tinkAccountLink/TinkAccountLinkView.dart';
import 'package:flutter_screenutil/size_extension.dart';

class HomepageOverlay extends StatefulWidget {
  @override
  _HomepageOverlayState createState() => _HomepageOverlayState();
}

class _HomepageOverlayState extends State<HomepageOverlay> {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final Function onPostivePressed;
  final Function onNegativePressed;
  final double circularBorderRadius;
  NavigationService _navigationService = locator<NavigationService>();

  _HomepageOverlayState({
    this.title,
    this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    this.positiveBtnText,
    this.negativeBtnText,
    this.onPostivePressed,
    this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
                color: AppColors.brandWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Material(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Image.asset("Assets/Illustrations/Tech_3.png")),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text(
                      "Turn on notifications to get the most out of Paynote",
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontSize: 60.nsp,
                          fontFamily: "Alata"),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text(
                      "Enable notifications for Paynote so we can help you stay on track with badges, alerts or changes! \n\n Customize which notifications you want to recieve in your profile.",
                      style: TextStyle(
                          color: AppColors.brandDarkGrey,
                          fontSize: 42.nsp,
                          fontFamily: "Roboto"),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
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
                          "Allow notifications",
                          style: TextStyle(
                              color: AppColors.brandWhite,
                              fontFamily: 'Alata',
                              fontSize: 18),
                        )),
                      )),
                  RaisedButton(
                      elevation: 0,
                      color: AppColors.brandWhite,
                      disabledColor: AppColors.brandLightGrey,
                      onPressed: () {
                        //_navigationService.navigateWithTransition(TinkAccountLinkView(), transition: "leftToRight",);

                        /*showGeneralDialog(
                          barrierLabel: "Label",
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: Duration(milliseconds: 600),
                          context: context,
                          pageBuilder: (context, anim1, anim2) {
                            
                            return _navigationService.navigateWithTransition(TinkAccountLinkView());

                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            return SlideTransition(
                              position:
                                  Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                      .animate(anim1),
                              child: child,
                            );
                          },
                        );*/
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: Center(
                            child: Text(
                          "Not now",
                          style: TextStyle(
                              color: AppColors.brandBlue,
                              fontFamily: 'Alata',
                              fontSize: 18,
                              decoration: TextDecoration.underline),
                        )),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    // return https://paynote.de/api/tink/callback?code=bef5d3722c8e48f2bb9a2fac79c9a3f2&credentialsId=470603819a244ff8ac689306ec909b2e
    const url =
        'https://link.tink.com/1.0/authorize/?client_id=50668476399446f9b4ab062cb582a034&redirect_uri=https%3A%2F%2Fpaynote.de%2Fapi%2Ftink%2Fcallback&market=SE&locale=en_US&scope=investments:read,transactions:read,user:read,accounts:read&test=true';
  }
}
