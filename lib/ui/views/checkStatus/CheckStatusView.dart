import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'CheckStatusViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

class CheckStatusView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckStatusViewModel>.nonReactive(
      builder: (context, model, child) {
        return Scaffold(
          body: checkStatusMainView(context, model),
        );
      },
      viewModelBuilder: () => CheckStatusViewModel(),
      onModelReady: (model) async => await model.handleStartupLogic(),
    );
  }

  Widget checkStatusMainView(BuildContext context, CheckStatusViewModel model) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColors.brandBlue,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 120.w,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Text(
              //   'Click here for a first time user',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 24.nsp,
              //   ),
              // ),
              Column(
                children: [
                  /// Title Text
                  Text(
                    'paynote',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.nsp,
                    ),
                  ),

                  // SizedBox(height: 30.h),

                  /// Description Text
                  // Text(
                  //   "Note: The 'click here' text will disappear when the app can recognize these users and guide them to the proper starting screen.",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 38.nsp,
                  //     fontWeight: FontWeight.w200,
                  //   ),
                  // ),
                ],
              ),
              // Text(
              //   'Click here for a returning user',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 24.nsp,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
