import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:flutter_screenutil/size_extension.dart';

class NotificationsOverlay extends StatefulWidget {
  NotificationsOverlay({this.notificationConfigStates});

  final List notificationConfigStates;

//mocked data
  bool _status1 = true;
  bool _status2 = true;
  bool _status3 = true;
  bool _status4 = false;
  bool _status5 = true;
  bool _status6 = true;
  bool _status7 = true;
  bool _status8 = true;

  @override
  __NotificationsOverlayState createState() => __NotificationsOverlayState();
}

class __NotificationsOverlayState extends State<NotificationsOverlay> {
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
                    "Notifications",
                    style: TextStyle(
                        color: AppColors.brandBlue,
                        fontSize: 60.nsp,
                        fontFamily: "Alata"),
                  ),
                  Container(
                    height: 60.h,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "New uncategorized expense",
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
                          setState(() {});
                        }),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "New expense without receipt",
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontFamily: "Roboto",
                          fontSize: 43.nsp),
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
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "New income",
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontFamily: "Roboto",
                          fontSize: 43.nsp),
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
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "A budget has reached 50%",
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontFamily: "Roboto",
                          fontSize: 43.nsp),
                    ),
                    trailing: FlutterSwitch(
                        value: widget._status4,
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
                          widget._status4 = val;
                          setState(() {});
                        }),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "A budget has reached 100%",
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontFamily: "Roboto",
                          fontSize: 43.nsp),
                    ),
                    trailing: FlutterSwitch(
                        value: widget._status5,
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
                          widget._status5 = val;
                          setState(() {});
                        }),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "Monthly income vs outgoing sum",
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontFamily: "Roboto",
                          fontSize: 43.nsp),
                    ),
                    trailing: FlutterSwitch(
                        value: widget._status6,
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
                          widget._status6 = val;
                          setState(() {});
                        }),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "Weekly expenses sum",
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontFamily: "Roboto",
                          fontSize: 43.nsp),
                    ),
                    trailing: FlutterSwitch(
                        value: widget._status7,
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
                          widget._status7 = val;
                          setState(() {});
                        }),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "Daily balance sum",
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontFamily: "Roboto",
                          fontSize: 43.nsp),
                    ),
                    trailing: FlutterSwitch(
                        value: widget._status8,
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
                          widget._status8 = val;
                          setState(() {});
                        }),
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
