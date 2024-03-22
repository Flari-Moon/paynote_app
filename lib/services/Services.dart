import 'package:injectable/injectable.dart';
import 'package:paynote_app/services/ThemeService.dart';
import 'package:stacked_services/stacked_services.dart';

import 'DynamicLinkService.dart';
import 'RequestService.dart';
import 'TwilioService.dart';
import 'OverlayService.dart';
import 'ApiClient.dart';
import 'HiveService.dart';
import 'FirebaseNotificationService.dart';
import 'SharedPrefService.dart';

@module
abstract class Services {
  @lazySingleton
  NavigationService get navigationService;

  @lazySingleton
  DialogService get dialogService;
  @lazySingleton
  DynamicLinkService get dynamicLinkService;
  @lazySingleton
  TwilioService get twilioService;
  @lazySingleton
  RequestService get requestService;
  @lazySingleton
  ThemeService get themeService;
  @lazySingleton
  OverlayService get overlayService;
  @lazySingleton
  ApiClient get apiClientService;
  @lazySingleton
  FirebaseNotificationService get firebaseNotificationService;
  @lazySingleton
  SharedPrefService get sharedPrefService;
 /* @lazySingleton
  HiveService get hiveService;*/

}