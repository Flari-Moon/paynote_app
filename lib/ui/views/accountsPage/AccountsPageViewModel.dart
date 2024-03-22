import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/services/SharedPrefService.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:paynote_app/Api/AccountsModel.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'dart:convert';
import 'package:paynote_app/Api/User.dart';

class AccountsPageViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  RequestService requestService = locator<RequestService>();
  List<AccountsModel> accounts = new List<AccountsModel>();
  double totalBalance = 0.0;

  /* void getUserAccounts(String userId) async{
     var acc = SharedPref().getString("accounts");
     accounts= jsonDecode(acc);
     if(accounts!=null){
       accounts= await requestService.getUserAccounts(userId);
       if(accounts.length>0) {
         totalAmount();
         notifyListeners();
       }
     }
     else{
       totalAmount();
       notifyListeners();
     }

  }

  void totalAmount() {
    var value = totalBalance;
    for (var i in accounts) {
      value = i.balance + value;
    }
    totalBalance = value;
  }
*/
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
    notifyListeners();
  }

  viewAccountDetails(int i) {
    AccountsModel accountModel = accounts[i];
    Map<String, dynamic> userMap;
    final String userStr = SharedPref().getString('user');
    if (userStr != null) {
      userMap = jsonDecode(userStr) as Map<String, dynamic>;
    }
    final User user = User.fromJson(userMap);
    _navigationService.navigateTo(Routes.accountsDetailView,
        arguments:
            AccountsDetailViewArguments(account: accountModel, user: user));
  }
}
