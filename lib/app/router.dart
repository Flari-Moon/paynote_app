import 'package:auto_route/auto_route_annotations.dart';
import 'package:paynote_app/models/Settings/settings.dart';

import 'package:paynote_app/ui/views/recurringCosts/RecurringCostsView.dart';
import 'package:paynote_app/ui/views/recurringTransactions/RecurringTransactionsView.dart';
import 'package:paynote_app/ui/views/transactions/transactionDetail/transactionDetailView.dart';
import 'package:paynote_app/ui/views/transactions/transactionsAllAccView.dart';
import '../ui/views/tinkAccountLink/TinkAccountLinkView.dart';
import '../ui/views/startup/StartupView.dart';
import '../ui/views/signup/SignupView.dart';
import '../ui/views/phoneVerification/PhoneVerificationView.dart';
import '../ui/views/otpVerification/OtpVerificationView.dart';
import '../ui/views/NewBankAccount/NewBankAccountView.dart';
import '../ui/views/manageYourAccess/ManageYourAccessView.dart';
import '../ui/views/loginCode/LoginCodeView.dart';
import '../ui/views/login/LoginView.dart';
//import '../ui/views/Homepage/HomepageView.dart';
import '../ui/views/home/HomeView.dart';
import '../ui/views/dashboard/DashboardView.dart';
import '../ui/views/checkStatus/CheckStatusView.dart';
import '../ui/views/accountsDetail/AccountsDetailView.dart';
import '../ui/views/accountMain/AccountMainView.dart';
import '../ui/views/accessCode/AccessCodeView.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: AccessCodeView),
    MaterialRoute(page: AccountMainView),
    MaterialRoute(page: AccountsDetailView),
    MaterialRoute(page: CheckStatusView),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: HomeView),
    //MaterialRoute(page: HomepageView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: LoginCodeView),
    MaterialRoute(page: ManageYourAccessView),
    MaterialRoute(page: NewBankAccountView),
    MaterialRoute(page: OtpVerificationView),
    MaterialRoute(page: PhoneVerificationView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: TinkAccountLinkView),
    MaterialRoute(page: RecurringCostsView),
    MaterialRoute(page: TransactionsAllAccView),
    MaterialRoute(page: TransactionsDetailView),
    MaterialRoute(page: RecurringTransactionsView),
    MaterialRoute(page: Settings),
  ],
)
class $Router {}
