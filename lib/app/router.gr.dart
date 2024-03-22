// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../Api/AccountsModel.dart';
import '../Api/RecurringData.dart';
import '../Api/TransactionMainModel.dart';
import '../Api/TransactionSortedDateModel.dart';
import '../Api/User.dart';
import '../models/Settings/settings.dart';
import '../ui/views/NewBankAccount/NewBankAccountView.dart';
import '../ui/views/accessCode/AccessCodeView.dart';
import '../ui/views/accountMain/AccountMainView.dart';
import '../ui/views/accountsDetail/AccountsDetailView.dart';
import '../ui/views/checkStatus/CheckStatusView.dart';
import '../ui/views/dashboard/DashboardView.dart';
import '../ui/views/home/HomeView.dart';
import '../ui/views/login/LoginView.dart';
import '../ui/views/loginCode/LoginCodeView.dart';
import '../ui/views/manageYourAccess/ManageYourAccessView.dart';
import '../ui/views/otpVerification/OtpVerificationView.dart';
import '../ui/views/phoneVerification/PhoneVerificationView.dart';
import '../ui/views/recurringCosts/RecurringCostsView.dart';
import '../ui/views/recurringTransactions/RecurringTransactionsView.dart';
import '../ui/views/signup/SignupView.dart';
import '../ui/views/startup/StartupView.dart';
import '../ui/views/tinkAccountLink/TinkAccountLinkView.dart';
import '../ui/views/transactions/transactionDetail/transactionDetailView.dart';
import '../ui/views/transactions/transactionsAllAccView.dart';

class Routes {
  static const String accessCodeView = '/access-code-view';
  static const String accountMainView = '/account-main-view';
  static const String accountsDetailView = '/accounts-detail-view';
  static const String checkStatusView = '/check-status-view';
  static const String dashboardView = '/dashboard-view';
  static const String homeView = '/home-view';
  static const String loginView = '/login-view';
  static const String loginCodeView = '/login-code-view';
  static const String manageYourAccessView = '/manage-your-access-view';
  static const String newBankAccountView = '/new-bank-account-view';
  static const String otpVerificationView = '/otp-verification-view';
  static const String phoneVerificationView = '/phone-verification-view';
  static const String signupView = '/signup-view';
  static const String startupView = '/startup-view';
  static const String tinkAccountLinkView = '/tink-account-link-view';
  static const String recurringCostsView = '/recurring-costs-view';
  static const String transactionsAllAccView = '/transactions-all-acc-view';
  static const String transactionsDetailView = '/transactions-detail-view';
  static const String recurringTransactionsView =
      '/recurring-transactions-view';
  static const String settings = '/Settings';
  static const all = <String>{
    accessCodeView,
    accountMainView,
    accountsDetailView,
    checkStatusView,
    dashboardView,
    homeView,
    loginView,
    loginCodeView,
    manageYourAccessView,
    newBankAccountView,
    otpVerificationView,
    phoneVerificationView,
    signupView,
    startupView,
    tinkAccountLinkView,
    recurringCostsView,
    transactionsAllAccView,
    transactionsDetailView,
    recurringTransactionsView,
    settings,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.accessCodeView, page: AccessCodeView),
    RouteDef(Routes.accountMainView, page: AccountMainView),
    RouteDef(Routes.accountsDetailView, page: AccountsDetailView),
    RouteDef(Routes.checkStatusView, page: CheckStatusView),
    RouteDef(Routes.dashboardView, page: DashboardView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.loginCodeView, page: LoginCodeView),
    RouteDef(Routes.manageYourAccessView, page: ManageYourAccessView),
    RouteDef(Routes.newBankAccountView, page: NewBankAccountView),
    RouteDef(Routes.otpVerificationView, page: OtpVerificationView),
    RouteDef(Routes.phoneVerificationView, page: PhoneVerificationView),
    RouteDef(Routes.signupView, page: SignupView),
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.tinkAccountLinkView, page: TinkAccountLinkView),
    RouteDef(Routes.recurringCostsView, page: RecurringCostsView),
    RouteDef(Routes.transactionsAllAccView, page: TransactionsAllAccView),
    RouteDef(Routes.transactionsDetailView, page: TransactionsDetailView),
    RouteDef(Routes.recurringTransactionsView, page: RecurringTransactionsView),
    RouteDef(Routes.settings, page: Settings),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    AccessCodeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AccessCodeView(),
        settings: data,
      );
    },
    AccountMainView: (data) {
      final args = data.getArgs<AccountMainViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AccountMainView(
          user: args.user,
          imageFile: args.imageFile,
          accountDeleted: args.accountDeleted,
        ),
        settings: data,
      );
    },
    AccountsDetailView: (data) {
      final args = data.getArgs<AccountsDetailViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AccountsDetailView(
          account: args.account,
          user: args.user,
          imageFile: args.imageFile,
          accTransactionDetails: args.accTransactionDetails,
        ),
        settings: data,
      );
    },
    CheckStatusView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CheckStatusView(),
        settings: data,
      );
    },
    DashboardView: (data) {
      final args = data.getArgs<DashboardViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DashboardView(user: args.user),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    LoginCodeView: (data) {
      final args = data.getArgs<LoginCodeViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginCodeView(user: args.user),
        settings: data,
      );
    },
    ManageYourAccessView: (data) {
      final args = data.getArgs<ManageYourAccessViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ManageYourAccessView(user: args.user),
        settings: data,
      );
    },
    NewBankAccountView: (data) {
      final args = data.getArgs<NewBankAccountViewArguments>(
        orElse: () => NewBankAccountViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => NewBankAccountView(bankData: args.bankData),
        settings: data,
      );
    },
    OtpVerificationView: (data) {
      final args = data.getArgs<OtpVerificationViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => OtpVerificationView(
          phoneNumber: args.phoneNumber,
          title: args.title,
          isoCode: args.isoCode,
        ),
        settings: data,
      );
    },
    PhoneVerificationView: (data) {
      final args = data.getArgs<PhoneVerificationViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PhoneVerificationView(
          title: args.title,
          subTitle: args.subTitle,
        ),
        settings: data,
      );
    },
    SignupView: (data) {
      final args = data.getArgs<SignupViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignupView(
          phoneNumber: args.phoneNumber,
          isoCode: args.isoCode,
        ),
        settings: data,
      );
    },
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartupView(),
        settings: data,
      );
    },
    TinkAccountLinkView: (data) {
      final args = data.getArgs<TinkAccountLinkViewArguments>(
        orElse: () => TinkAccountLinkViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => TinkAccountLinkView(
          user: args.user,
          url: args.url,
        ),
        settings: data,
      );
    },
    RecurringCostsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RecurringCostsView(),
        settings: data,
      );
    },
    TransactionsAllAccView: (data) {
      final args = data.getArgs<TransactionsAllAccViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => TransactionsAllAccView(
          transactionList: args.transactionList,
          user: args.user,
        ),
        settings: data,
      );
    },
    TransactionsDetailView: (data) {
      final args = data.getArgs<TransactionsDetailViewArguments>(
        orElse: () => TransactionsDetailViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            TransactionsDetailView(transactionModel: args.transactionModel),
        settings: data,
      );
    },
    RecurringTransactionsView: (data) {
      final args = data.getArgs<RecurringTransactionsViewArguments>(
        orElse: () => RecurringTransactionsViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => RecurringTransactionsView(
            subscriptionModel: args.subscriptionModel),
        settings: data,
      );
    },
    Settings: (data) {
      final args = data.getArgs<SettingsArguments>(
        orElse: () => SettingsArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Settings(
          key: args.key,
          phoneNumber: args.phoneNumber,
          userName: args.userName,
          userSurname: args.userSurname,
          email: args.email,
          imagefile: args.imagefile,
          user: args.user,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// AccountMainView arguments holder class
class AccountMainViewArguments {
  final User user;
  final File imageFile;
  final bool accountDeleted;
  AccountMainViewArguments(
      {@required this.user,
      @required this.imageFile,
      this.accountDeleted = false});
}

/// AccountsDetailView arguments holder class
class AccountsDetailViewArguments {
  final AccountsModel account;
  final User user;
  final File imageFile;
  final List<dynamic> accTransactionDetails;
  AccountsDetailViewArguments(
      {@required this.account,
      @required this.user,
      @required this.imageFile,
      @required this.accTransactionDetails});
}

/// DashboardView arguments holder class
class DashboardViewArguments {
  final User user;
  DashboardViewArguments({@required this.user});
}

/// LoginCodeView arguments holder class
class LoginCodeViewArguments {
  final User user;
  LoginCodeViewArguments({@required this.user});
}

/// ManageYourAccessView arguments holder class
class ManageYourAccessViewArguments {
  final User user;
  ManageYourAccessViewArguments({@required this.user});
}

/// NewBankAccountView arguments holder class
class NewBankAccountViewArguments {
  final List<dynamic> bankData;
  NewBankAccountViewArguments({this.bankData});
}

/// OtpVerificationView arguments holder class
class OtpVerificationViewArguments {
  final String phoneNumber;
  final String title;
  final String isoCode;
  OtpVerificationViewArguments(
      {@required this.phoneNumber, this.title, this.isoCode});
}

/// PhoneVerificationView arguments holder class
class PhoneVerificationViewArguments {
  final String title;
  final String subTitle;
  PhoneVerificationViewArguments({@required this.title, this.subTitle});
}

/// SignupView arguments holder class
class SignupViewArguments {
  final String phoneNumber;
  final String isoCode;
  SignupViewArguments({@required this.phoneNumber, @required this.isoCode});
}

/// TinkAccountLinkView arguments holder class
class TinkAccountLinkViewArguments {
  final User user;
  final String url;
  TinkAccountLinkViewArguments({this.user, this.url});
}

/// TransactionsAllAccView arguments holder class
class TransactionsAllAccViewArguments {
  final List<TransactionMainModel> transactionList;
  final User user;
  TransactionsAllAccViewArguments({@required this.transactionList, this.user});
}

/// TransactionsDetailView arguments holder class
class TransactionsDetailViewArguments {
  final TransactionSortedDateModel transactionModel;
  TransactionsDetailViewArguments({this.transactionModel});
}

/// RecurringTransactionsView arguments holder class
class RecurringTransactionsViewArguments {
  final Subscriptions subscriptionModel;
  RecurringTransactionsViewArguments({this.subscriptionModel});
}

/// Settings arguments holder class
class SettingsArguments {
  final Key key;
  final String phoneNumber;
  final String userName;
  final String userSurname;
  final String email;
  final File imagefile;
  final User user;
  SettingsArguments(
      {this.key,
      this.phoneNumber,
      this.userName,
      this.userSurname,
      this.email,
      this.imagefile,
      this.user});
}
