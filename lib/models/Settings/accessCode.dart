import 'package:flutter/material.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:paynote_app/utils/paynote_icons.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/size_extension.dart';

class AccessCodeOverlay extends StatefulWidget {
  AccessCodeOverlay({this.appearenceStates});

  final List appearenceStates;

  bool _status1 = true;
  bool _status2 = true;

  bool _pincodeSet = false;

   TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  BuildContext _context;
  final PageController _pageController = PageController(initialPage: 1);
  int _pageIndex = 0;
  StreamController<ErrorAnimationType> errorController2;

  var pinCodeType = 1;
  String pincode1 = '';
  String pincode2 = '';
  bool pinError = false;
  @override
  _AccessCodeOverlayState createState() => _AccessCodeOverlayState();
}

class _AccessCodeOverlayState extends State<AccessCodeOverlay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.95,
            decoration: BoxDecoration(
                color: AppColors.brandWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Material(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.028,
                      ),
                      Center(
                          child: Text("Settings",
                              style: TextStyle(
                                  color: AppColors.brandDarkGrey,
                                  fontFamily: "Alata",
                                  fontSize: 48.nsp))),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
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
                      "Appearance",
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
                        "Pincode",
                        style: TextStyle(
                            color: AppColors.brandBlue,
                            fontFamily: "Roboto",
                            fontSize: 43.nsp),
                      ),
                      trailing: FlutterSwitch(
                          value: widget._status1,
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
                            widget._status1 = val;
                            setState(() {
                            if (widget._pincodeSet == false &&
                                widget._status1 == false) {
                              widget._pincodeSet = true;
                              print("Pincode Set: ${widget._pincodeSet}");
                            }
                            });
                          }),
                    ),
                  ),
                  widget._pincodeSet == true
                      ? Column(
                          children: [
                            Container(
                              width: 330,
                              child: widget.pinCodeType == 1
                                  ? Text("Choose a Pincode",
                                      style: TextStyle(
                                          color: AppColors.brandBlue,
                                          fontSize: 48.nsp))
                                  : Text("Repeat your Pincode",
                                      style: TextStyle(
                                          color: AppColors.brandBlue,
                                          fontSize: 48.nsp)),
                            ),
                            PinCodeTextField(
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
                              autoDisposeControllers: true,
                              enableActiveFill: true,
                              errorAnimationController: widget.errorController2,
                              controller: widget._pinPutController,
                              onCompleted: (String pin) => _showSnackBar(pin),
                              onChanged: (value) {
                                print(value);
                                setState(() {});
                              },
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
                              child: widget.pinError == false
                                  ? Text("",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 43.nsp))
                                  : Text(
                                      "pin does not match, please repeat the process",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 43.nsp)),
                            ),
                          ],
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    widget._status1=SharedPref().getBool('pinCodeSet');
  }

  void _showSnackBar(String pin) {
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

    if (widget.pinCodeType == 1) {
      widget.pinCodeType++;
      widget.pincode1 = widget._pinPutController.text;

      widget._pinPutController.text = '';
    } else if (widget.pinCodeType == 2) {
      widget.pinCodeType++;
      widget.pincode2 = widget._pinPutController.text;
      if (widget.pincode1 != widget.pincode2) {
        widget.pinError = !widget.pinError;
        widget.pinCodeType = 1;

        setState(() {});
      } else {
        widget._pincodeSet = !widget._pincodeSet;
        print("success!");
        setState(() {});
      }
    }
    print("CODE 1 ${widget.pincode1}");
    print("CODE 2 ${widget.pincode2}");
  }
}
