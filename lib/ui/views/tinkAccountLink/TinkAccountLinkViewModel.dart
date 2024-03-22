import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:convert';
import 'dart:convert' as JSON;
import 'package:paynote_app/services/DynamicLinkService.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:paynote_app/models/OverlayLoadingScreens/OverlaysForLoading.dart';
import 'package:flutter/material.dart';


class TinkAccountLinkViewModel extends FutureViewModel<String> {
  NavigationService _navigationService = locator<NavigationService>();
  RequestService requestService = locator<RequestService>();
  DynamicLinkService dynamicLinkService = locator<DynamicLinkService>();
  User user = new User();
  String url;
  String userId;
  BuildContext context;



  void getUserFromPref() async {
    String phoneNumber = SharedPref().getString("phoneNumber");
    if (phoneNumber != null) {
      Map<String, dynamic> userMap;
      final String userStr = SharedPref().getString('user');
      if (userStr != null) {
        userMap = jsonDecode(userStr) as Map<String, dynamic>;
      }
      if (userMap != null) {
        user = User.fromJson(userMap);
        print(user);
      }
    }
  }

  handleDeepLink(String link) {
    // https://paynote.page.link/accounts?status=200&userId=3aa81eeff2164280a3c699e5236a1487
    final Uri deepLink = Uri.parse(link);
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');

      var isLoggedIn = deepLink.pathSegments.contains('accounts');
      if (isLoggedIn) {
        var userId = deepLink.queryParameters['userId'];
        print('print user id $userId');
        if (userId != null) {
          user.userId=userId;
          SharedPref().setString('userId',userId);
          _navigationService.clearStackAndShow(Routes.accountMainView,arguments: AccountMainViewArguments(user: user,imageFile:null));
        }
      }
    }
  }

  /*void addBank(String userId) async {
    url = await requestService.addBank({'userId': userId});
   // _launchURL();
    notifyListeners();
  }*/



  //// tryinig with over lay
  Future<String> addBank(String userId, BuildContext context) async {
    print(userId);
    url = await requestService.addBank({'userId': userId},context);
    print(url);
    // url= SharedPref().getString("tinkUrl");
   /* setBusy(true);
    showOver(context);
    setBusy(false);
    hideOver();*/
  //  _launchURL();
    return url;
  }

  /*void _launchURL() async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    setBusy(false);
    hideOver();
    //_launchURL();
    notifyListeners();
  }

  */
  void _launchURL() async=> await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Future<String> futureToRun() {
    return  addBank(userId, context);
  }

  TinkAccountLinkViewModel(this.userId,this.context);
}



