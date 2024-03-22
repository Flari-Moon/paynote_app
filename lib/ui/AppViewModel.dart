import 'package:flutter/material.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/services/ThemeService.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:paynote_app/services/DynamicLinkService.dart';

import 'package:stacked/stacked.dart';

class AppViewModel extends ReactiveViewModel {
  ThemeService themeService = locator<ThemeService>();
  bool get isDarkMode => themeService.isDarkMode;
  ThemeData get lightTheme => themeService.lightTheme;
  ThemeData get darkTheme => themeService.darkTheme;
  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();


  @override
  List<ReactiveServiceMixin> get reactiveServices => [themeService];

  initPref() async{
    await SharedPref().init();
    //await _dynamicLinkService.handleDynamicLinks();
  }
}
