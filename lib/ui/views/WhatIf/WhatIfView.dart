import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:paynote_app/Api/Data.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/Api/BResponse.dart';
import 'package:paynote_app/models/profile/editProfileModel.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/DateTimePickers.dart';
import 'package:paynote_app/utils/paynote_icons.dart';

import 'dart:convert';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/app/locator.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/utils/Response.dart';
import 'package:paynote_app/utils/serverError.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:stacked/stacked.dart';

class WhatIfView extends StatelessWidget {
  WhatIfView({this.user});

  final User user;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileModel>.reactive(
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, true);
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _topBar(context, model),
                _centralContent(context, model),
                _bottomAppBar(context, model),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => EditProfileModel(),
      onModelReady: (model) => model.initUser(),
    );
  }

  Widget _topBar(BuildContext context, EditProfileModel model) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50.w, 120.w, 50.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Profile",
                  style: TextStyle(
                      color: AppColors.brandDarkGrey,
                      fontFamily: "Alata",
                      fontSize: 48.nsp)),
              Expanded(child: SizedBox()),
              IconButton(
                splashRadius: 60,
                focusColor: AppColors.brandDarkGrey,
                icon: Icon(PaynoteIcons.close_outline, size: 35),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              "Edit your profile",
              style: TextStyle(
                  color: AppColors.brandBlue,
                  fontSize: 60.nsp,
                  fontFamily: "Alata"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _centralContent(BuildContext context, EditProfileModel model) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.2,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Container(
                  width: 280.r,
                  height: 280.r,
                  child: FlatButton(
                    onPressed: () {
                      print("CURRENT PHOTO ${model.image_file}");
                      model.open_gallery();
                    },
                    child: Center(
                      child: model.image_file == null
                          ? Text(
                              "add photo",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.brandLightBlue,
                                  fontFamily: "Roboto",
                                  fontSize: 43.nsp),
                            )
                          : Text(''),
                    ),
                  ),
                  decoration: model.image_file == null
                      ? BoxDecoration(
                          color: AppColors.brandLightGrey,
                          borderRadius: BorderRadius.circular(200))
                      : BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(model.image_file),
                            fit: BoxFit.fill,
                          ),
                          color: AppColors.brandLightGrey,
                          borderRadius: BorderRadius.circular(200)),
                ),
                Container(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        color: AppColors.brandLightGrey,
                        child: TextFormField(
                          // initialValue:  model.userData.firstName ,
                          controller: model.textEditingControllerName,
                          decoration: InputDecoration(
                            labelText: "Name",
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        color: AppColors.brandLightGrey,
                        child: TextFormField(
                          //   initialValue: model.userData.lastName,
                          controller: model.textEditingControllerSurname,
                          decoration: InputDecoration(
                            labelText: "Surname",
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        //width: MediaQuery.of(context).size.width * 0.6,
                        color: AppColors.brandLightGrey,
                        child: TextFormField(
                          //  initialValue: model.userData.email,
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              contentPadding: EdgeInsets.only(left: 10)),
                          keyboardType: TextInputType.emailAddress,
                          controller: model.textEditingControllerEmail,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20.w),
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                            color: AppColors.brandLightGrey,
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColors.brandDarkGrey))),
                        child: BasicDateField(
                            //controller: controller,
                            date: model.inputBirth,
                            text: "Birth Day"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.055,
                ),
                Container(
                  //width: MediaQuery.of(context).size.width * 0.3,
                  width: 280.r,
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
                child: model.verificationEmail == false
                    ? Text("")
                    : Text(
                        "We will send you a verification Email",
                        style: TextStyle(fontSize: 32.nsp, color: Colors.red),
                      )),
            Container(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                Container(
                  //width: MediaQuery.of(context).size.width * 0.3,
                  width: 280.r,
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05, 0, 0, 0),
              width: MediaQuery.of(context).size.width * 0.9,
              child: RaisedButton(
                  elevation: 0,
                  color: AppColors.brandBlue,
                  disabledColor: AppColors.brandLightGrey,
                  onPressed: () {
                    model.editUserProfile(model.userData, context);
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
            Container(
              height: 40.h,
            ),
            model.verificationPending == false
                ? Container(
                    height: 20.h,
                  )
                : RaisedButton(
                    elevation: 0,
                    color: AppColors.brandWhite,
                    disabledColor: AppColors.brandLightGrey,
                    onPressed: () {
                      print("logout");
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.brandBlue)),
                      child: Center(
                          child: Text(
                        "Resend verification Email",
                        style: TextStyle(
                            color: AppColors.brandBlue,
                            fontFamily: 'Alata',
                            fontSize: 48.nsp),
                      )),
                    )),
            Container(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context, EditProfileModel model) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.05,
      left: 0,
      right: 0,
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 50.w,
            vertical: 30.h,
          ),
          child: Container()),
    );
  }
}
