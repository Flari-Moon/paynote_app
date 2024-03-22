import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:paynote_app/Api/Buffer.dart';
import 'package:http/http.dart' as http;
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:stacked/stacked.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:paynote_app/models/OverlayLoadingScreens/OverlaysForLoading.dart';
import 'package:paynote_app/ui/views/tinkAccountLink/TinkAccountLinkView.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:http/http.dart' as http;

class InsightDashboardViewModel extends BaseViewModel {
  File image;
  User userShow;
  bool bankAccounts = false;
  int limit = 10;
  int skip = 0;
  String url2;
  List<TransactionMainModel> transactionList = <TransactionMainModel>[];
  String userId;
  NavigationService _navigationService = locator<NavigationService>();
  RequestService requestService = locator<RequestService>();

  Future imageCreate(String pic, User user, BuildContext context) async {
    /// enable bank accounts for testing
    // SharedPref().setBool('bankAccounts', true);
    userShow = user;

    bankAccounts = SharedPref().getBool('bankAccounts');

    if (bankAccounts == null) {
      bankAccounts = false;
    }
    if (pic != null && pic.isNotEmpty) {
      final decodedBytes = base64Decode(pic);
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      image = new File(tempPath + "decodeduserrr.png");
      image.writeAsBytesSync(decodedBytes);
      notifyListeners();
    }
    // bankAccounts=true;
    if (bankAccounts == true) {
      getTransactions(context);
    }
  }

  getTransactions(BuildContext context) async {
    //userId = SharedPref().getString("userId");
    //userId = '82f461bc3aa441c69b539f354449b35e';
    //getTransFromPref();
    if (userId != null && transactionList.isEmpty) {
      await requestService
          .getUserTransactions(userId, skip, limit, 'date', context,'')
          .then((value) => transactionList.addAll(value));
      //limit = limit + 10;
      notifyListeners();
    }
  }

  getTransFromPref() {
    List<String> acc = SharedPref().getStringList("transactionList");
    if (acc != null) {
      for (String s in acc) {
        Map<String, dynamic> accMap;
        accMap = jsonDecode(s) as Map<String, dynamic>;
        final TransactionMainModel accMod =
            TransactionMainModel.fromJson(accMap);
        transactionList.add(accMod);
      }
    }
  }

  /* //// tryinig with over lay
  Future<void> addBank( BuildContext context) async {
    setBusy(true);
    url2 = await requestService.addBank({'userId': userShow.id},context);

    setBusy(false);
    OpenTinkList();
    //  _launchURL();

  }
  */
  OpenTinkList() {
    _navigationService.navigateWithTransition(
      TinkAccountLinkView(user: userShow, url: null),
      transition: "leftToRight",
    );
  }
}
