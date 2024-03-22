import 'package:flutter/material.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'ManageYourAccessViewModel.dart';
import 'package:stacked/stacked.dart';
import 'dart:async';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:flutter/foundation.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';

import 'package:flutter_screenutil/size_extension.dart';

class ManageYourAccessView extends StatelessWidget {
  User user;
  ManageYourAccessView({@required this.user});

  final _formKey = GlobalKey<FormState>();

  final FocusNode _pinPutFocusNode = FocusNode();
  final PageController _pageController = PageController(initialPage: 1);

  StreamController<ErrorAnimationType> errorController2;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageYourAccessViewModel>.reactive(
      builder: (context, model, child) {
        final List<Widget> _pinPuts = [
          this.pinCreation(context, model),
          //darkRoundedPinPut(),
        ];
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              _topBar(context, model),
              Builder(
                builder: (context) {
                  return AnimatedContainer(
                    color: Color(0xffF8F8FA),
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(40.r),
                    child: PageView(
                      scrollDirection: Axis.vertical,
                      controller: _pageController,
                      onPageChanged: (index) {
                        model.setIndex(index);
                      },
                      children: _pinPuts.map((p) {
                        return FractionallySizedBox(
                          heightFactor: 1.0,
                          child: Center(child: p),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
              _bottomAppBar(context, model),
            ],
          ),
        );
      },
      viewModelBuilder: () => ManageYourAccessViewModel(),
      onModelReady: (model) => model.setPinPref(),
    );
  }

  Widget _topBar(BuildContext context, ManageYourAccessViewModel model) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 15,
        ),
        Container(
          height: 70,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            leading: Icon(
              PaynoteIcons.arrow_back,
              color: AppColors.brandBlue,
              size: 80.r,
            ),
            trailing: Container(
              width: 140,
              child: new LinearPercentIndicator(
                  width: 140,
                  animation: true,
                  lineHeight: 7.0,
                  animationDuration: 1500,
                  animateFromLastPercent: true,
                  percent: 0.99,
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
              //"Manage your access",
              model.pageLanguageData["SIN-3-00"][0]
                  [model.userLanguage.language],
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.brandBlue,
                  fontSize: 60.nsp,
                  fontFamily: 'Alata'),
            )),
        Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              //"Choose how you want to protect your account access and manage security settings.",
              model.pageLanguageData["SIN-3-10"][0]
                  [model.userLanguage.language],
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.brandMediumGrey,
                  fontSize: 38.nsp,
                  fontFamily: 'Alata'),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.051,
        ),
      ],
    ));
  }

  Widget _bottomAppBar(BuildContext context, ManageYourAccessViewModel model) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.r),
            child: RaisedButton(
                elevation: 0,
                color: AppColors.brandBlue,
                disabledColor: AppColors.brandLightGrey,
                onPressed: null,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Center(
                      child: Text(
                    //"Save access code",
                    model.pageLanguageData["SIN-3-40"][0]
                        [model.userLanguage.language],
                    style: TextStyle(
                        color: AppColors.brandWhite,
                        fontFamily: 'Alata',
                        fontSize: 48.nsp),
                  )),
                )),
          ),
          Container(
            height: 10,
          ),
          RaisedButton(
              elevation: 0,
              color: AppColors.brandWhite,
              onPressed: () {
                model.pinCodeSet = false;
                model.setPinPref();
                model.goToDashboard(user);
                //set user again with pincode
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                    child: Text(
                  //"I don't want to set an access restriction",
                  model.pageLanguageData["SIN-3-50"][0]
                      [model.userLanguage.language],
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.brandBlue,
                      fontFamily: 'Alata',
                      fontSize: 48.nsp),
                )),
              )),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  /* void _showSnackBar(String pin) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: TextStyle(fontSize: 60.nsp),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );

    if (pinCodeType == 1) {
      pinCodeType++;
      pincode1 = _pinPutController.text;

      _pinPutController.text = '';
    } else if (pinCodeType == 2) {
      pinCodeType++;
      pincode2 = _pinPutController.text;
      if (pincode1 != pincode2) {
        */ /* setState(() {
          pinError = !pinError;
          pinCodeType = 1;
        });*/ /*
      } else {
        print("success!");
      }
    }
    print("CODE 1 $pincode1");
    print("CODE 2 $pincode2");
  }*/

  /*Widget onlySelectedBorderPinPut() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(235, 236, 237, 1),
      //borderRadius: BorderRadius.circular(5.0),
    );
    return Form(
      key: _formKey,
      child: GestureDetector(
        onLongPress: () {
          //print(_formKey.currentState.validate());
        },
        child: PinPut(
          validator: (s) {
            if (s.contains('1')) return null;
            return 'NOT VALID';
          },
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          withCursor: true,
          fieldsCount: 5,
          fieldsAlignment: MainAxisAlignment.spaceAround,
          textStyle: const TextStyle(fontSize: 25.0, color: AppColors.brandBlue),
          eachFieldMargin: EdgeInsets.all(0),
          eachFieldWidth: 50.0,
          eachFieldHeight: 70.0,
          onSubmit: (String pin) => model.(pin),
          focusNode: _pinPutFocusNode,
          controller: _pinPutController,
          submittedFieldDecoration: pinPutDecoration,
          selectedFieldDecoration: pinPutDecoration.copyWith(
            color: Colors.white,
            border: Border.all(
              width: 2,
              color: const Color.fromRGBO(160, 215, 220, 1),
            ),
          ),
          followingFieldDecoration: pinPutDecoration,
          pinAnimationType: PinAnimationType.scale,
        ),
      ),
    );
  }
*/
  // Widget darkRoundedPinPut(BuildContext context) {

  //   final BoxDecoration pinPutDecoration = BoxDecoration(
  //     color: AppColors.brandWhite,
  //     border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
  //     //borderRadius: BorderRadius.circular(20.0),
  //   );
  //   return PinPut(
  //     eachFieldWidth: 50.0,
  //     eachFieldHeight: 70.0,
  //     fieldsCount: 5,
  //     focusNode: _pinPutFocusNode,
  //     controller: _pinPutController,
  //     onSubmit: (String pin) => _showSnackBar(pin),
  //     submittedFieldDecoration: pinPutDecoration,
  //     selectedFieldDecoration: pinPutDecoration,
  //     followingFieldDecoration: pinPutDecoration,
  //     pinAnimationType: PinAnimationType.scale,
  //     textStyle: const TextStyle(color: AppColors.brandBlue, fontSize: 20.0),
  //   );
  // }

  Widget PinScreenText(BuildContext context, ManageYourAccessViewModel model) {
    if (model.pinCodeType == 1) {
      return Text(
          //"Choose a Pincode",
          model.pageLanguageData["SIN-3-20"][0][model.userLanguage.language],
          style: TextStyle(color: AppColors.brandBlue, fontSize: 48.nsp));
    } else {
      // model._pinPutController.clear();
      return Text(
          //"Repeat your Pincode",
          model.pageLanguageData["SIN-3-21"][0][model.userLanguage.language],
          style: TextStyle(color: AppColors.brandBlue, fontSize: 48.nsp));
    }
  }

  Widget pinCreation(BuildContext context, ManageYourAccessViewModel model) {
    //_pinPutController.clear();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _topBar(context, model),
        Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: PinScreenText(context, model)),
        Container(
          child: PinCodeTextField(
            enablePinAutofill: false,
            keyboardAppearance: Brightness.dark,
            length: 5,
            obscureText: true,
            textStyle: TextStyle(color: AppColors.brandBlue),
            animationType: AnimationType.scale,
            keyboardType: TextInputType.numberWithOptions(),
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                //borderRadius: BorderRadius.circular(5),
                fieldHeight: MediaQuery.of(context).size.height * 0.08,
                fieldWidth: MediaQuery.of(context).size.width * 0.14,
                activeColor: AppColors.brandBlue,
                inactiveFillColor: Colors.transparent,
                inactiveColor: AppColors.brandDarkGrey,
                activeFillColor: AppColors.brandWhite,
                selectedColor: AppColors.brandLightBlue,
                selectedFillColor: Colors.transparent),
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: AppColors.brandWhite,
            autoDisposeControllers: true,
            enableActiveFill: true,
            errorAnimationController: errorController2,
            controller: model.pinPutController,
            onCompleted: (String pin) {
              //_pinPutController.clear();
              model.checkPin(pin, user, context);
            },
            onChanged: (value) {
              print(value);
              //setState(() {});
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
            appContext: context,
          ),
        ),
        Container(
          width: 330,
          child: model.pinError == false
              ? Text("", style: TextStyle(color: Colors.red, fontSize: 43.nsp))
              : Text("pin does not match, please repeat the process",
                  style: TextStyle(color: Colors.red, fontSize: 43.nsp)),
        ),
      ],
    );
  }
}
