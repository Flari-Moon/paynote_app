import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:flutter_screenutil/size_extension.dart';


class PrivacyOverlay extends StatefulWidget {
  PrivacyOverlay({this.privacySettings});

  final List privacySettings;

  bool _status1 = true;
  bool _status2 = true;
  bool _status3 = true;
  @override
  _PrivacyOverlayState createState() => _PrivacyOverlayState();
}

class _PrivacyOverlayState extends State<PrivacyOverlay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            height: MediaQuery.of(context).size.height * 0.95,
            decoration: BoxDecoration(
                color: AppColors.brandWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Settings",
                          style: TextStyle(
                              color: AppColors.brandDarkGrey,
                              fontFamily: "Alata",
                              fontSize: 48.nsp)),
                      Expanded(child: SizedBox()),
                      IconButton(
                        splashRadius: 60,
                        focusColor: AppColors.brandDarkGrey,
                        icon: Icon(PaynoteIcons.close_outline, size: 35),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Text(
                    "Privacy",
                    style: TextStyle(
                        color: AppColors.brandBlue,
                        fontSize: 60.nsp,
                        fontFamily: "Alata"),
                  ),
                  Container(
                    height: 60.h,
                  ),
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              "Marketing emails",
                              style: TextStyle(
                                  color: AppColors.brandBlue,
                                  fontFamily: "Roboto",
                                  fontSize: 43.nsp),
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              "I want to recieve marketing emails that interest me.",
                              style: TextStyle(
                                  color: AppColors.brandDarkGrey,
                                  fontFamily: "Roboto",
                                  fontSize: 43.nsp),
                            ),
                          )
                        ],
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
                            setState(() {});
                          }),
                    ),
                  ),
                  Container(
                    height: 40.h,
                  ),
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              "Social media & advertising",
                              style: TextStyle(
                                  color: AppColors.brandBlue,
                                  fontFamily: "Roboto",
                                  fontSize: 43.nsp),
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              "I allow paynote to share my information such as my name, email, address and app events with social media so Paynote can advertise to me and others like me.",
                              style: TextStyle(
                                  color: AppColors.brandDarkGrey,
                                  fontFamily: "Roboto",
                                  fontSize: 43.nsp),
                            ),
                          )
                        ],
                      ),
                      trailing: FlutterSwitch(
                          value: widget._status2,
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
                            widget._status2 = val;
                            setState(() {});
                          }),
                    ),
                  ),
                  Container(
                    height: 40.h,
                  ),
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              "Updates",
                              style: TextStyle(
                                  color: AppColors.brandBlue,
                                  fontFamily: "Roboto",
                                  fontSize: 43.nsp),
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              "I want to get updates about new features or a change in features",
                              style: TextStyle(
                                  color: AppColors.brandDarkGrey,
                                  fontFamily: "Roboto",
                                  fontSize: 43.nsp),
                            ),
                          )
                        ],
                      ),
                      trailing: FlutterSwitch(
                          value: widget._status3,
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
                            widget._status3 = val;
                            setState(() {});
                          }),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                            elevation: 0,
                            color: AppColors.brandBlue,
                            disabledColor: AppColors.brandLightGrey,
                            onPressed: () {
                              print("Save Changes");
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Center(
                                  child: Text(
                                "Save Changes",
                                style: TextStyle(
                                    color: AppColors.brandWhite,
                                    fontFamily: 'Alata',
                                    fontSize: 48.nsp),
                              )),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
