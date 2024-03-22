import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'PhoneVerificationViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

// =================================================

class PhoneVerificationView extends StatelessWidget {
  PhoneVerificationView({@required this.title, this.subTitle});
  final String title, subTitle;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PhoneVerificationViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              _topBar(context, model),
              _centralContent(context, model),
              _bottomAppBar(context, model),
            ],
          ),
        );
      },
      viewModelBuilder: () => PhoneVerificationViewModel(),
      onModelReady: (model) => model.initLanguage(),
      //onModelReady: (model) => model.imageCreate(user.picture),
    );
  }

  Widget _topBar(BuildContext context, PhoneVerificationViewModel model) {
    return Positioned(
        width: MediaQuery.of(context).size.width * 0.9,
        top: MediaQuery.of(context).size.height * 0.051,
        left: 30,
        child: Column(
          children: [
            Container(
              height: 70,
              child: ListTile(
                trailing: Container(
                  width: 140,
                  child: new LinearPercentIndicator(
                      width: 140,
                      animation: true,
                      lineHeight: 7.0,
                      animationDuration: 1500,
                      animateFromLastPercent: true,
                      percent: 0.55,
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: AppColors.brandLightBlue,
                      backgroundColor: AppColors.brandLightGrey),
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.1,
                child: Text(
                  //title,
                  model.pageLanguageData["SIN-5-00"][0]
                      [model.userLanguage.language],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.brandBlue,
                      fontSize: 70.nsp,
                      fontFamily: 'Alata',
                      fontWeight: FontWeight.w400),
                )),
            SizedBox(height: 20.h),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  //subTitle,
                  model.pageLanguageData["SIN-6-10"][0]
                      [model.userLanguage.language],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.brandMediumGrey,
                      fontSize: 42.nsp,
                      fontFamily: 'Roboto'),
                )),
          ],
        ));
  }

  Widget _centralContent(
      BuildContext context, PhoneVerificationViewModel model) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      bottom: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: InternationalPhoneNumberInput(
              countries: ['NL', 'BE', 'BR'],
              hintText: model.pageLanguageData["SIN-6-20"][0]
                  [model.userLanguage.language],
              onInputChanged: (PhoneNumber number) {
                model.phoneNumber = number.phoneNumber;
                model.phoneIsoCode = number.dialCode;
              },
              onInputValidated: (bool value) {
                print(value);
                model.validNumber = value;
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,

              selectorTextStyle: TextStyle(color: Colors.black),
              textStyle: TextStyle(
                  color: AppColors.brandDarkGrey, fontFamily: 'Roboto'),
              //initialValue: 1254,
              textFieldController: controller,
              //inputBorder: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context, PhoneVerificationViewModel model) {
    Animation<double> animation;
    Animation<double> secondaryAnimation;
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.035,
      left: 0,
      right: 0,

      // top: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.r),
            child: RaisedButton(
                elevation: 0,
                color: AppColors.brandBlue,
                disabledColor: AppColors.brandLightGrey,
                onPressed: (model.phoneNumber == null)
                    ? null
                    : () {
                        model.sendSMS(context, title);
                      },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Center(
                      child: Text(
                    //"Send Code",
                    model.pageLanguageData["SIN-6-30"][0]
                        [model.userLanguage.language],
                    style: TextStyle(
                        color: AppColors.brandWhite,
                        fontFamily: 'Alata',
                        fontSize: 44.nsp,
                        fontWeight: FontWeight.w400),
                  )),
                )),
          ),
        ],
      ),
    );
  }
}
