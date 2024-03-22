import 'package:flutter/material.dart' hide Router;
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/ui/views/dashboard/DashboardView.dart';
import 'package:paynote_app/utils/SharedPref.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'AppViewModel.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //FlutterUxcam.optIntoSchematicRecordings();
    //FlutterUxcam.startWithKey("mopuajsvo8nu4wt");
    return ViewModelBuilder<AppViewModel>.reactive(
      builder: (context, model, child) {
        return ScreenUtilInit(
          designSize: Size(1080, 2220),
          allowFontScaling: true,
          builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            //  theme: model.isDarkMode ? model.darkTheme : model.lightTheme,
            initialRoute: Routes.checkStatusView,
            // home: DashboardView(user: User()),
            onGenerateRoute: Router().onGenerateRoute,
            navigatorKey: locator<NavigationService>().navigatorKey,
          ),
        );
      },
      viewModelBuilder: () => AppViewModel(),
    );
  }
}
