import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/models/Home/homepageOverlay.dart';
import 'package:paynote_app/models/Menu/menu.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/ui/views/Homepage/HomepageView.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'DashboardViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/ui/views/tinkAccountLink/TinkAccountLinkView.dart';

class DashboardView extends StatelessWidget {
  final User user;

  NavigationService _navigationService = locator<NavigationService>();

  DashboardView({@required this.user});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              _topBar(context, model),
              model.bankAccounts
                  ? Expanded(
                      child: HomepageView(
                        user: user,
                        //imagefile: null,
                        email: '',
                        phoneNumber: '',
                        userName: '',
                        userSurname: '',
                        transactionList: model.transactionList,
                      ),
                    )
                  : _centralContent(context, model),
              _bottomAppBar(context, model),
            ],
          ),
        );
      },
      viewModelBuilder: () => DashboardViewModel(),
      onModelReady: (model) => {
        model.imageCreate(user.picture, user, context),
        model.initLanguage()
      },
    );
  }

  Widget _topBar(BuildContext context, DashboardViewModel model) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30.w,
        right: 80.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 200.h),

          Text(
            //"Goodafternoon",
            model.pageLanguageData["HOM-0-00"][0][model.userLanguage.language],
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColors.brandMediumGrey,
                fontSize: 43.nsp,
                fontFamily: 'Alata'),
          ),

          /// User Name and Filter Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${user.firstName}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.brandBlue,
                  fontSize: 70.nsp,
                  fontFamily: 'Alata',
                ),
              ),
              Icon(
                PaynoteIcons.options_outline,
                size: 80.r,
                color: AppColors.brandLightBlue,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _centralContent(BuildContext context, DashboardViewModel model) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image(
                    image: AssetImage("Assets/Illustrations/Tech_5.png"))),
          ),
          Center(
              child: Text(
            //"You have no accounts yet",
            model.pageLanguageData["HOM-0-10"][0][model.userLanguage.language],
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
                //"When you're ready, connect your first account to start with paynote!",
                model.pageLanguageData["HOM-0-20"][0]
                    [model.userLanguage.language],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.brandMediumGrey,
                    fontSize: 48.nsp,
                    fontFamily: 'Roboto'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context, DashboardViewModel model) {
    Animation<double> animation;
    Animation<double> secondaryAnimation;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        model.bankAccounts
            ? Container()
            : RaisedButton(
                elevation: 0,
                color: AppColors.brandBlue,
                disabledColor: AppColors.brandLightGrey,
                onPressed: () {
                  model.OpenTinkList();
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
                    //"Add a new bank account",
                    model.pageLanguageData["HOM-0-30"][0]
                        [model.userLanguage.language],
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
    );
  }
}
