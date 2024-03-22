import 'package:flutter/material.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';

//usage example
/*

OverlaysForLoading(
                      title: "WHOOT WOOT!",
                      assetImagePath: 'Assets/Illustrations/Tech_loading.png',
                      text: 'We are trying to make this super fast!',
                    ).showScreen(context);

*/
//to dismiss the code:
/*
OverlaysForLoading().dismissOverlay();


 */

//it will show the overlay for loading
class OverlaysForLoading extends StatelessWidget {
  OverlaysForLoading({this.title, this.text, this.assetImagePath});

  final String title;
  final String text;
  final String assetImagePath;

  showScreen(context) {
    OverlayScreen().saveScreens({
      'overlayDesign': CustomOverlayScreen(
        backgroundColor: AppColors.brandWhite.withOpacity(0.9),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image(image: AssetImage(this.assetImagePath))),
            Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Text(
                  this.title,
                  style: TextStyle(
                      fontSize: 26,
                      color: AppColors.brandBlue,
                      fontFamily: 'Alata'),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  this.text,
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.brandDarkGrey,
                      fontFamily: 'Roboto'),
                )),
          ],
        ),
      ),
    });

    OverlayScreen().show(
      context,
      identifier: 'overlayDesign',
    );
  }

  dismissOverlay() {
   if (OverlayScreen().state==Screen.showing)
    {OverlayScreen().pop();}
  }

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
