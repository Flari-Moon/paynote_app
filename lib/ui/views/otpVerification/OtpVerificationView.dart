import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'OtpVerificationViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

//===============================================================

class OtpVerificationView extends StatelessWidget {
  final String phoneNumber, isoCode, title;

  OtpVerificationView({@required this.phoneNumber, this.title, this.isoCode});

  final TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  final StreamController<ErrorAnimationType> errorController =
      StreamController();
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();

  //Locale myLocale = Localizations.localeOf(context);
  final List myLocale = Platform.localeName.split('_');
  String secureYourAccountText = "Secure your account";

  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpVerificationViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              _topBar(context, model),
              _centralContent(context, model),
              _BottomAppBar(model, phoneNumber),
            ],
          ),
        );
      },
      viewModelBuilder: () => OtpVerificationViewModel(),
      onModelReady: (model) => model.inIt(),
    );
  }

  Widget _topBar(BuildContext context, OtpVerificationViewModel model) {
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
                      percent: 0.66,
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
                  //secureYourAccountText,
                  model.pageLanguageData["SIN-7-00"][0]
                      [model.userLanguage.language],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.brandBlue,
                      fontSize: 70.nsp,
                      fontFamily: 'Alata',
                      fontWeight: FontWeight.w400),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      style: TextStyle(
                        color: AppColors.brandMediumGrey,
                        fontSize: 38.nsp,
                        fontFamily: 'Roboto',
                      ),
                      children: [
                        TextSpan(
                          text:
                              //"Enter the 7 digit code we sent you in an SMS message to $phoneNumber. ",
                              "${model.pageLanguageData["SIN-7-10"][0][model.userLanguage.language]} $phoneNumber. ",
                        ),
                        TextSpan(
                          //text: "Wrong number?",
                          text: model.pageLanguageData["SIN-7-20"][0]
                              [model.userLanguage.language],
                          style: TextStyle(
                            color: AppColors.brandBlue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => model.goBack(),
                        ),
                      ]),
                )),
          ],
        ));
  }

  Widget _centralContent(BuildContext context, OtpVerificationViewModel model) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: PinCodeTextField(
                      length: 7,
                      obscureText: false,
                      textStyle:
                          TextStyle(color: AppColors.brandBlue, fontSize: 18),
                      animationType: AnimationType.scale,
                      keyboardType: TextInputType.numberWithOptions(),
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          //borderRadius: BorderRadius.circular(5),
                          activeColor: AppColors.brandBlue,
                          inactiveFillColor: Colors.transparent,
                          inactiveColor: AppColors.brandDarkGrey,
                          activeFillColor: Colors.transparent,
                          selectedColor: AppColors.brandLightBlue,
                          selectedFillColor: Colors.transparent),
                      animationDuration: Duration(milliseconds: 200),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      onCompleted: (v) {
                        model.phoneNumber = phoneNumber;
                        model.phoneIsoCode = isoCode;

                        model.verify(context, v);
                        print("OnCompleted: $v");

                        //handle case for the sucess and failure if needed here ...
                        /*if (v != "1111111") {
                                  print("LOCALE INFO ${myLocale}");
                                  setState(() {*/
                        /*  });*/
                        /* } else {
                                  print("Completed");
                                  setState(() {
                                    hasError = false;
                                  });*/
                        /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ManageYourAccess()),
                                  );*/
                      },
                      /* onChanged: (value) {
                                print(value);
                                setState(() {
                                  currentText = value;
                                });
                              },*/
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      appContext: context,
                      onChanged: (String value) {},
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      errorText,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 38.nsp,
                      ),
                    ))
              ]);
            }),
          ),
        ],
      ),
    );
  }
}

class _BottomAppBar extends StatefulWidget {
  _BottomAppBar(
    this.model,
    this.number,
  );

  final OtpVerificationViewModel model;
  final String number;

  @override
  _BottomAppBarState createState() =>
      _BottomAppBarState(this.model, this.number);
}

class _BottomAppBarState extends State<_BottomAppBar> {
  Animation<double> animation;
  Animation<double> secondaryAnimation;
  final OtpVerificationViewModel model;
  final String number;

  _BottomAppBarState(this.model, this.number);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.03,
      left: 0,
      right: 0,

      // top: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 55.w),
            child: OutlinedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) {
                      return AppColors.brandLightGrey;
                    }
                    return AppColors.brandBlue;
                  }),
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.white;
                    }
                    return AppColors.brandLightGrey;
                  }),
                  side: MaterialStateProperty.resolveWith((states) {
                    Color _borderColor;

                    if (states.contains(MaterialState.disabled)) {
                      _borderColor = AppColors.brandLightGrey;
                    } else {
                      _borderColor = AppColors.brandBlue;
                    }

                    return BorderSide(color: _borderColor, width: 1);
                  }),
                ),
                onPressed: () => model.enableResend
                    ? model.resendOtp(context, number)
                    : null,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Center(
                      child:  model.secondsRemaining>0 ? Text(
                    //"Resend Code in ${model.secondsRemaining}",
                   "${model.pageLanguageData["SIN-7-40"][0][model.userLanguage.language]}  ${model.secondsRemaining}",
                    style: TextStyle(
                      fontFamily: 'Alata',
                      fontSize: 48.nsp,
                      fontWeight: FontWeight.w400,
                    ),
                  ):Text(
                //"Resend Code in ${model.secondsRemaining}",
                "${model.pageLanguageData["SIN-7-40"][0][model.userLanguage.language]}",
                  style: TextStyle(
                    fontFamily: 'Alata',
                    fontSize: 48.nsp,
                    fontWeight: FontWeight.w400,
                  ),
                )) ,
                )),
          ),
        ],
      ),
    );
    ;
  }
}
