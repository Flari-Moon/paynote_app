import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:paynote_app/Api/AccountsModel.dart';
import 'package:paynote_app/Api/Buffer.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/RecurringData.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/TransactionModel.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/utils/SharedPref.dart';

class SharedPrefService {
  Map<String, dynamic> userMap;
  User profileUser;
  Language profileLanguage;
  File profilePicture;

  Language loadProfileLanguage() {
    final String userStr = SharedPref().getString('language');
    print(userStr);
    if (userStr != null) {
      userMap = jsonDecode(userStr) as Map<String, dynamic>;
    }
    profileLanguage = Language.fromJson(userMap);
    print('getting user...');
    return profileLanguage;
  }

  User loadProfileUser() {
    final String userStr = SharedPref().getString('user');
    print(userStr);
    if (userStr != null) {
      userMap = jsonDecode(userStr) as Map<String, dynamic>;
    }
    profileUser = User.fromJson(userMap);
    print('getting user...');
    return profileUser;
  }

  Future<File> loadProfilePicture() async {
    if (profileUser.picture != null && profileUser.picture.isNotEmpty) {
      final decodedBytes = base64Decode(profileUser.picture);
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      profilePicture = new File(
          tempPath + DateTime.now().toString() + "decodcccccceduserrr.png");
      profilePicture.writeAsBytesSync(decodedBytes);
      print('image gwtting');
      return profilePicture;
    } else {
      return null; //getImageFileFromAssets('Assets/Illustrations/default.jpg');
    }
    //   }
  }

  List<AccountsModel> userAccountsFromPrefs() {
    List<String> acc = SharedPref().getStringList("accounts");
    List<AccountsModel> accounts = [];

    ///print(acc.single);
    if (acc != null) {
      for (String s in acc) {
        Map<String, dynamic> accMap;
        accMap = jsonDecode(s) as Map<String, dynamic>;
        final AccountsModel accMod = AccountsModel.fromJson(accMap);
        accounts.add(accMod);
        print('hello');
      }
      return accounts;
    } else {
      print('ahhh');
      return null;
    }
  }

  Buffer getBufferFromShared() {
    final String bufferstr = SharedPref().getString('buffer');
    Map bufferMap;
    if (bufferstr != null) {
      bufferMap = jsonDecode(bufferstr) as Map<String, dynamic>;
    }
    if (bufferMap != null) {
      final Buffer buffer = Buffer.fromJson(bufferMap);
      return buffer;
    }
    return null;
  }

  List<TransactionMainModel> getTransFromPref() {
    List<TransactionMainModel> transactionList = [];
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
    print(transactionList);
    return transactionList;
  }

  List<Subscriptions> getSubscriptionFromShared() {
    List<Subscriptions> subList;
    List<String> acc = SharedPref().getStringList("subscriptionList");
    if (acc != null) {
      for (String s in acc) {
        Map<String, dynamic> accMap;
        accMap = jsonDecode(s) as Map<String, dynamic>;
        final Subscriptions accMod = Subscriptions.fromJson(accMap);

        subList.add(accMod);
      }
      //return subList;
    }
    return subList;
  }
}
