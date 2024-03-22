import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'LoginCodeViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

class LoginCodeView extends StatelessWidget {
  User user;
  LoginCodeView({@required this.user});
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  StreamController<ErrorAnimationType> errorController2;
  bool biometricStatus = true;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginCodeViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.brandWhite,
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.all(15),
            color: AppColors.brandWhite,
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: Text(
                      //'Welcome Back ${user.firstName},',
                      '${model.pageLanguageData["SIN-A-10"][0][model.userLanguage.language]} ${user.firstName},',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontSize: 60.nsp,
                          fontFamily: 'Alata'),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      //"Log in with your security code.",
                      model.pageLanguageData["SIN-A-10"][0]
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

                //Form fields
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    children: [
                      Container(
                          height: 90,
                          width: 330,
                          child: PinCodeTextField(
                            enablePinAutofill: false,
                            keyboardAppearance: Brightness.dark,
                            length: 5,
                            obscureText: true,
                            textStyle: TextStyle(color: AppColors.brandBlue),
                            animationType: AnimationType.scale,
                            keyboardType: TextInputType.numberWithOptions(),
                            autoDisposeControllers: true,
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                fieldHeight: 80,
                                fieldWidth: 60,
                                activeColor: AppColors.brandBlue,
                                inactiveFillColor: Colors.transparent,
                                inactiveColor: AppColors.brandDarkGrey,
                                activeFillColor: AppColors.brandWhite,
                                selectedColor: AppColors.brandLightBlue,
                                selectedFillColor: Colors.transparent),
                            animationDuration: Duration(milliseconds: 300),
                            backgroundColor: AppColors.brandWhite,
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            onCompleted: (v) {
                              model.verifyPin(v, user);
                            },
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                            appContext: context,
                          )),
                      Container(
                        width: 330,
                        child: !model.pinError
                            ? Text("",
                                style: TextStyle(
                                    color: AppColors.brandBlue,
                                    fontSize: 48.nsp))
                            : Text("Incorrect code. Please try again.",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 48.nsp)),
                      ),
                      // Container(
                      //   width: 300,
                      //   child: pinCodeType >= 5
                      //       ? Text(
                      //           "Too many wrong tries, try again in ${widget.wrongTriesCooldown} seconds.",
                      //           style: TextStyle(color: Colors.red, fontSize: 18))
                      //       : Text("",
                      //           style: TextStyle(color: Colors.red, fontSize: 18)),
                      // ),
                    ],
                  );
                }),

                //Form fields end

                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),

                //note: this format is not very usable for mobile, recommend changing format
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginCodeViewModel(),
      onModelReady: (model) => model.initLanguage(),
    );
  }
}
