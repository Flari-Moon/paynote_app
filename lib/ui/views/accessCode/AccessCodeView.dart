import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'AccessCodeViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

class AccessCodeView extends StatelessWidget {
  AccessCodeView();

  StreamController<ErrorAnimationType> errorController2;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccessCodeViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                      color: AppColors.brandWhite,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Material(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.028,
                            ),
                            Center(
                                child: Text(
                                    //"Settings",
                                    model.pageLanguageData["PRO-5-00"][0]
                                        [model.userLanguage.language],
                                    style: TextStyle(
                                        color: AppColors.brandDarkGrey,
                                        fontFamily: "Alata",
                                        fontSize: 48.nsp))),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                            ),
                            IconButton(
                              splashRadius: 60,
                              focusColor: AppColors.brandDarkGrey,
                              icon: Icon(PaynoteIcons.close_outline, size: 35),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Text(
                            //"Appearance",
                            model.pageLanguageData["PRO-8-00"][0]
                                [model.userLanguage.language],
                            style: TextStyle(
                                color: AppColors.brandBlue,
                                fontSize: 60.nsp,
                                fontFamily: "Alata"),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ListTile(
                            title: Text(
                              //"Pincode",
                              model.pageLanguageData["PRO-A-10"][0]
                                  [model.userLanguage.language],
                              style: TextStyle(
                                  color: AppColors.brandBlue,
                                  fontFamily: "Roboto",
                                  fontSize: 43.nsp),
                            ),
                            trailing: FlutterSwitch(
                                value: model.isPinSet,
                                width: 70.0,
                                height: 30.0,
                                valueFontSize: 15.0,
                                toggleSize: 20.0,
                                activeText: "Yes",
                                inactiveText: "No",
                                inactiveColor: AppColors.brandDarkGrey,
                                showOnOff: true,
                                activeTextColor: AppColors.brandWhite,
                                activeColor: AppColors.brandOrange,
                                onToggle: (val) {
                                  model.setToggle(val);
                                }),
                          ),
                        ),
                        model.isPinSet == true
                            ? Column(
                                children: [
                                  Container(
                                    width: 330,
                                    child: model.pinCodeType == 1
                                        ? Text(
                                            //"Choose a Pincode",
                                            model.pageLanguageData["PRO-A-40"]
                                                    [0]
                                                [model.userLanguage.language],
                                            style: TextStyle(
                                                color: AppColors.brandBlue,
                                                fontSize: 48.nsp))
                                        : Text(
                                            //"Repeat your Pincode",
                                            model.pageLanguageData["PRO-A-50"]
                                                    [0]
                                                [model.userLanguage.language],
                                            style: TextStyle(
                                                color: AppColors.brandBlue,
                                                fontSize: 48.nsp)),
                                  ),
                                  PinCodeTextField(
                                    enablePinAutofill: false,
                                    keyboardAppearance: Brightness.dark,
                                    length: 5,
                                    obscureText: true,
                                    textStyle:
                                        TextStyle(color: AppColors.brandBlue),
                                    animationType: AnimationType.scale,
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.underline,
                                        //borderRadius: BorderRadius.circular(5),
                                        fieldHeight: 80,
                                        fieldWidth: 60,
                                        activeColor: AppColors.brandBlue,
                                        inactiveFillColor: Colors.transparent,
                                        inactiveColor: AppColors.brandDarkGrey,
                                        activeFillColor: AppColors.brandWhite,
                                        selectedColor: AppColors.brandLightBlue,
                                        selectedFillColor: Colors.transparent),
                                    animationDuration:
                                        Duration(milliseconds: 300),
                                    backgroundColor: AppColors.brandWhite,
                                    autoDisposeControllers: true,
                                    enableActiveFill: true,
                                    errorAnimationController: errorController2,
                                    controller: model.pinPutController,
                                    onCompleted: (String pin) =>
                                        model.checkPin(pin, context),
                                    onChanged: (value) {},
                                    beforeTextPaste: (text) {
                                      print("Allowing to paste $text");
                                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                      return true;
                                    },
                                    appContext: context,
                                  ),
                                  Container(
                                    width: 330,
                                    child: model.pinError == false
                                        ? Text("",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 43.nsp))
                                        : Text(
                                            //"pin does not match, please repeat the process",
                                            model.pageLanguageData["PRO-A-51"]
                                                    [0]
                                                [model.userLanguage.language],
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 43.nsp)),
                                  ),
                                ],
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => AccessCodeViewModel(),
      onModelReady: (model) => {model.getPinStatus(), model.initLanguage()},
    );
  }
}
