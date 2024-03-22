// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/ApiClient.dart';
import '../services/DynamicLinkService.dart';
import '../services/HiveService.dart';
import '../services/OverlayService.dart';
import '../services/RequestService.dart';
import '../services/Services.dart';
import '../services/ThemeService.dart';
import '../services/TwilioService.dart';
import '../services/FirebaseNotificationService.dart';
import '../services/SharedPrefService.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final services = _$Services();
  gh.lazySingleton<ApiClient>(() => services.apiClientService);
  gh.lazySingleton<DialogService>(() => services.dialogService);
  gh.lazySingleton<DynamicLinkService>(() => services.dynamicLinkService);
  gh.lazySingleton<HiveService>(() => HiveService());
  gh.lazySingleton<NavigationService>(() => services.navigationService);
  gh.lazySingleton<OverlayService>(() => services.overlayService);
  gh.lazySingleton<RequestService>(() => services.requestService);
  gh.lazySingleton<ThemeService>(() => services.themeService);
  gh.lazySingleton<TwilioService>(() => services.twilioService);
  gh.lazySingleton<FirebaseNotificationService>(() => services.firebaseNotificationService);
  gh.lazySingleton<SharedPrefService>(() => services.sharedPrefService);

  return get;
}

class _$Services extends Services {
  @override
  ApiClient get apiClientService => ApiClient();
  @override
  DialogService get dialogService => DialogService();
  @override
  DynamicLinkService get dynamicLinkService => DynamicLinkService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  OverlayService get overlayService => OverlayService();
  @override
  RequestService get requestService => RequestService();
  @override
  ThemeService get themeService => ThemeService();
  @override
  TwilioService get twilioService => TwilioService();
  @override
  FirebaseNotificationService get firebaseNotificationService => FirebaseNotificationService();
  @override
  SharedPrefService get sharedPrefService => SharedPrefService();
}
