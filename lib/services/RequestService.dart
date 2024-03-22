import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:paynote_app/Api/AccMod.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/Api/BResponse.dart';
import 'package:paynote_app/Api/Data.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/SubscriptionModel.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/TransactionSortedDateModel.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/models/OverlayLoadingScreens/OverlaysForLoading.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:paynote_app/Api/AccountsModel.dart';
import 'package:paynote_app/Api/TransactionModel.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'SharedPrefService.dart';

class RequestService {
  final client =
      ApiClientService(Dio(BaseOptions(contentType: "application/json")));
  BResponse baseResponse = new BResponse();
  User responseUser;
  Language responseLanguage;
  final _dialogService = locator<DialogService>();
  final _sharedPrefService = locator<SharedPrefService>();

  bool _confirmationResult;

  bool get confirmationResult => _confirmationResult;

  DialogResponse _dialogResponse;

  DialogResponse get customDialogResult => _dialogResponse;

  Future showErrorDialog(String error) async {
    DialogResponse response = await _dialogService.showDialog(
      title: 'Error',
      description: error,
      buttonTitle: 'Ok',
    );

    print('DialogResponse: ${response?.confirmed}');
  }

  Future showOverlayDialog(String title, String description) async {
    DialogResponse response = await _dialogService.showDialog(
      title: title,
      description: description,
      buttonTitle: 'Ok',
    );

    print('DialogResponse: ${response?.confirmed}');
  }

  void showOver(BuildContext context, String overlayTitle, String imagePath,
      String overlayText) {
    OverlaysForLoading(
      title: overlayTitle,
      assetImagePath: imagePath,
      text: overlayText,
    ).showScreen(context);
  }

  void hideOver() {
    OverlaysForLoading().dismissOverlay();
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);
    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }
/*

  Future<void> getPrefs() async {
    prefs = SharedPref.
  }
*/

  Future<User> signUpApp(
    User user,
    BuildContext context,
  ) async {
    // user.typeOfRequest='setUser';
    showOver(context, "WHOOT WOOT!", 'Assets/Illustrations/Tech_loading.png',
        'We are trying to make this super fast!');
    baseResponse = await client.signUpUser(user);
    if (baseResponse.status == 1) {
      processUser(baseResponse);
      if (responseUser != null) {
        SharedPref().setString("user", jsonEncode(responseUser));
        SharedPref().setString("phoneNumber", responseUser.phoneNumber);
        hideOver();
        return responseUser;
      }
    } else {
      hideOver();
      showErrorDialog(baseResponse.message);
      return null;
    }
  }

  Future<User> getUserByPhoneNumber(
    String phoneNumber,
    BuildContext context,
  ) async {
    showOver(context, "Fetching...", 'Assets/Illustrations/Tech_loading.png',
        'We are getting your details!');
    phoneNumber = phoneNumber.substring(1);
    print(' sent phone number s $phoneNumber');
    await client.getUser(phoneNumber, 'object').then((value) {
      if (value.status == 1) {
        print(value.status);
        processUser(value);
        // responseUser = baseResponse.data.user;
        if (responseUser != null) {
          SharedPref().setString("user", jsonEncode(responseUser));
          SharedPref().setString("phoneNumber", responseUser.phoneNumber);
          hideOver();
          return responseUser;
          //goToLoginCode();
        }
      } else {
        print('response from server $value');
        showErrorDialog(baseResponse.message);
        hideOver();
        return responseUser = null;
      }
    });
    return responseUser;
  }

  Future<double> getAccountBalance(
    String userId,
    String accountId,
    BuildContext context,
  ) async {
    if (context != null) {
      showOver(
          context,
          "please wait !",
          'Assets/Illustrations/Tech_loading.png',
          'We are getting your latest balance!');
    }
    var responseBalance;
    await client.getAccountBalance(accountId, userId).then((value) {
      if (value.status == 1) {
        responseBalance = baseResponse.data.balance;
        if (responseBalance != null) {
          hideOver();
          return responseBalance;
        }
      } else {
        hideOver();
        return null;
      }
    });
    return responseBalance;
  }

  Future<User> setUpPin(User user, BuildContext context) async {
    showOver(context, "WHOOT WOOT!", 'Assets/Illustrations/Tech_loading.png',
        'We are trying to make this super fast!');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String base64Pin = stringToBase64.encode(user.pinCode);
    User requestUser = user;
    requestUser.pinCode = base64Pin;
    print(requestUser);
    await client.updateUser(requestUser).then((value) {
      if (value != null && value.status == 1) {
        processUser(value);
        SharedPref().setString("user", jsonEncode(responseUser));
        SharedPref().setString("phoneNumber", responseUser.phoneNumber);
      } else {
        hideOver();
        showErrorDialog(baseResponse.message);
      }
    });
    hideOver();
    return responseUser;
  }

  processUser(BResponse baseResponse) {
    responseUser = new User();
    responseUser.phoneNumber = baseResponse.data.phoneNumber;
    responseUser.id = baseResponse.data.id;
    responseUser.email = baseResponse.data.email;
    responseUser.dateOfBirth = baseResponse.data.dateOfBirth;
    responseUser.firstName = baseResponse.data.firstName;
    responseUser.lastName = baseResponse.data.lastName;
    responseUser.picture = baseResponse.data.picture;
    responseUser.createdAt = baseResponse.data.createdAt;
    responseUser.updatedAt = baseResponse.data.updatedAt;
    responseUser.pinCode = baseResponse.data.pinCode;
  }

  Future<User> updateUser(User user, BuildContext context) async {
    try {
      showOver(context, "WHOOT WOOT!", 'Assets/Illustrations/Tech_loading.png',
          'We are trying to make this super fast!');
      baseResponse = await client.updateUser(user);
      if (baseResponse != null && baseResponse.status == 1) {
        processUser(baseResponse);
        print('response update user received');
        SharedPref().setString("user", jsonEncode(responseUser));
        SharedPref().setString("phoneNumber", responseUser.phoneNumber);
        hideOver();
        return responseUser;
      } else {
        //
        hideOver();
        print('response update user fail');
        //showErrorDialog(baseResponse.message);
        return null;
      }
    } catch (error, stacktrace) {
      hideOver();
      showErrorDialog(baseResponse.message);
      print('response update failedddd $error');
      return null;
      // return BaseModel()..setException(ServerError.withError(error: error));
    }
  }


  // processLanguage(BResponse baseResponse) {
  //   responseLanguage = new Language();
  //   responseLanguage.language = baseResponse.;

  // }

  // Future<User> updateLanguage(Language language, BuildContext context) async {
  //   try {
  //     showOver(context, "WHOOT WOOT!", 'Assets/Illustrations/Tech_loading.png',
  //         'We are trying to make this super fast!');
  //     baseResponse = await client.updateLanguage(language);
  //     if (baseResponse != null && baseResponse.status == 1) {
  //       processUser(baseResponse);
  //       print('response update user received');
  //       SharedPref().setString("user", jsonEncode(responseUser));
  //       SharedPref().setString("phoneNumber", responseUser.phoneNumber);
  //       hideOver();
  //       return responseUser;
  //     } else {
  //       //
  //       hideOver();
  //       print('response update user fail');
  //       //showErrorDialog(baseResponse.message);
  //       return null;
  //     }
  //   } catch (error, stacktrace) {
  //     hideOver();
  //     showErrorDialog(baseResponse.message);
  //     print('response update failedddd $error');
  //     return null;
  //     // return BaseModel()..setException(ServerError.withError(error: error));
  //   }
  // }

  Future<List<AccountsModel>> getUserAccounts(
      String userId, BuildContext context) async {
    // user.typeOfRequest='setUser';
    /* showOver(context, "WHOOT WOOT!",
        'Assets/Illustrations/Tech_loading.png',
        'We are trying to make this super fast!');*/
    //  showErrorDialog("hello");
    List<AccountsModel> accounts = <AccountsModel>[];
    baseResponse = await client.getAccountList(userId);
    print('debug : $baseResponse');
    if (baseResponse.status == 1) {
      accounts = baseResponse.data.accounts;

      List<String> savedPrefsJson = [];
      for (AccountsModel savedPref in accounts) {
        String savedPrefJson = jsonEncode(savedPref);
        savedPrefsJson.add(savedPrefJson);
      }
      SharedPref().setBool('bankAccounts', true);
      SharedPref().setStringList("accounts", savedPrefsJson);
      //hideOver();
      return accounts;
    } else if (baseResponse.status == 0 &&
        baseResponse.message == 'No data found') {
      showErrorDialog('no accounts found');
      SharedPref().setBool('bankAccounts', false);
      return null;
    } else {
      //hideOver();
      showErrorDialog(baseResponse.message);
      return null;
    }
  }

  Future<String> deleteUserAccount(
      String userId, String accountId, BuildContext context) async {
    // user.typeOfRequest='setUser';
    print('account to be deleted$accountId');
    showOver(context, "wait..!", 'Assets/Illustrations/Tech_loading.png',
        'We are making sure everything is smooth..!');
    baseResponse = await client.deleteUserAccount({
      'userId': userId,
      'accountId': accountId,
    });
    if (baseResponse.status == 1) {
      // SharedPref().setBool('bankAccountDeleted', true);
      SharedPref().remove('${accountId}monthSubscription');
      SharedPref().remove('${accountId}yearSubscription');
      SharedPref().remove('${accountId}subscription');
      SharedPref().remove("${accountId}transactionList");
      SharedPref().remove('buffer');
      SharedPref().remove('transactionList');
      SharedPref().remove('subscriptionList');
      SharedPref().remove('balance');
      SharedPref().remove("accounts");
      print('all pref cleared');
      print(baseResponse.message.toString());
      /*List<AccountsModel> accounts = [];
      accounts= _sharedPrefService.userAccountsFromPrefs();
      if(accounts!=null){
        accounts.removeWhere((element)=> element.accountId==accountId);
        SharedPref().remove('${accountId}monthSubscription');
        SharedPref().remove('${accountId}yearSubscription');
        SharedPref().remove('${accountId}subscription');
        SharedPref().remove("${accountId}transactionList");
        SharedPref().remove('buffer');
        SharedPref().remove('transactionList');
        SharedPref().remove('subscriptionList');
        SharedPref().remove('balance');
        print('frece');
      }
      if(accounts.isNotEmpty) {
        print('suppp');
      List<String> savedPrefsJson = [];
      for (AccountsModel savedPref in accounts) {
        String savedPrefJson = jsonEncode(savedPref);
        savedPrefsJson.add(savedPrefJson);
        print('suppp2');

      }
        SharedPref().setBool('bankAccounts', true);
        SharedPref().setStringList("accounts", savedPrefsJson);
      }
      else{
        print('suppp3');

        SharedPref().setBool('bankAccounts', false);
        SharedPref().remove('accounts');

      }
     */
      hideOver();
      return baseResponse.data.message;
    } else {
      hideOver();
      showErrorDialog(baseResponse.message);
      return null;
    }
  }

  Future<List<TransactionMainModel>> getUserTransactions(
      String userId,
      int skip,
      int limit,
      String filter,
      BuildContext context,
      String accountId) async {
    // user.typeOfRequest='setUser';
    /* showOver(context, "WHOOT WOOT!",
        'Assets/Illustrations/Tech_loading.png',
        'We are trying to make this super fast!');*/
    List<TransactionMainModel> transactionList = List<TransactionMainModel>();
    baseResponse = await client.getUserTransactions(
        userId, skip, limit, filter, accountId);

    if (baseResponse.status == 1) {
      (baseResponse.data.transactions).forEach((v) {
        // var date = DateTime.fromMillisecondsSinceEpoch(v.date);
        // var formattedDate = DateFormat.d('dd/mm/yyyy').format(date);
        // v.date=formattedDate as int;
        print(' trasactions found $v.date');
        transactionList.add(v);
      });
      List<String> savedPrefsJson = [];
      for (TransactionMainModel savedPref in transactionList) {
        String savedPrefJson = jsonEncode(savedPref);
        savedPrefsJson.add(savedPrefJson);
      }
      if (accountId.contains('')) {
        SharedPref().setStringList("transactionList", savedPrefsJson);
      } else {
        SharedPref()
            .setStringList("${accountId}transactionList", savedPrefsJson);
      }
      hideOver();
      return transactionList;
    } else if (baseResponse.status == 0) {
      hideOver();
      print(' no data found $baseResponse.message');
      showErrorDialog(baseResponse.message);
      return null;
    } else {
      hideOver();
      print(' response error is $baseResponse.message');

      showErrorDialog(baseResponse.message);
      return null;
    }
  }

  Future<List<SubscriptionModel>> getUserSubscriptions(
      String userId, int size, int pageNo, BuildContext context) async {
    // user.typeOfRequest='setUser';
    /* showOver(context, "WHOOT WOOT!",
        'Assets/Illustrations/Tech_loading.png',
        'We are trying to make this super fast!');*/
    List<SubscriptionModel> subscriptionList = List<SubscriptionModel>();
    baseResponse = await client.userSubscriptions(userId, size, pageNo);

    if (baseResponse.status == 1) {
      (baseResponse.data.subscriptions).forEach((v) {
        // var date = DateTime.fromMillisecondsSinceEpoch(v.date);
        // var formattedDate = DateFormat.d('dd/mm/yyyy').format(date);
        // v.date=formattedDate as int;
        subscriptionList.add(v);
      });
      List<String> savedPrefsJson = [];
      for (SubscriptionModel savedPref in subscriptionList) {
        String savedPrefJson = jsonEncode(savedPref);
        savedPrefsJson.add(savedPrefJson);
      }
      SharedPref().setStringList("subscriptionList", savedPrefsJson);
      hideOver();
      return subscriptionList;
    } else if (baseResponse.status == 0) {
      baseResponse.message.contains('No data found');
      hideOver();
      return null;
    } else {
      hideOver();
      showErrorDialog(baseResponse.message);
      return null;
    }
  }

  Future<Data> getAccountBuffer(AccMod body, BuildContext context) async {
    /* showOver(context, "WHOOT WOOT!",
        'Assets/Illustrations/Tech_loading.png',
        'We are trying to make this super fast!');*/
    baseResponse = await client.userBuffer(body);
    if (baseResponse.status == 1) {
      hideOver();
      return baseResponse.data;
    } else if (baseResponse.status == 0) {
      hideOver();
      baseResponse.message.contains('No data found');
      return null;
    } else {
      hideOver();
      showErrorDialog(baseResponse.message);
      return null;
    }
  }

  Future<String> addBank(
      Map<String, dynamic> body, BuildContext context) async {
    try {
      /* showOver(context, "WHOOT WOOT!",
          'Assets/Illustrations/Tech_loading.png',
          'We are trying to make this super fast!');*/
      baseResponse = await client.addBank(body);
      // if (baseResponse != null && baseResponse.status == 1) {
      if (baseResponse != null) {
        processUser(baseResponse);
        // hideOver();
        SharedPref().setString('url', baseResponse.data.deeplink);
        return baseResponse.data.deeplink;
      } else {
        //hideOver();
        showErrorDialog(baseResponse.message);
        return null;
      }
    } catch (error, stacktrace) {
      // hideOver();
      print(stacktrace.toString());
      return null;
    }
  }
}
