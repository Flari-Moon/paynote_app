import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:stacked/stacked.dart';

import 'SignupViewModel.dart';

class SignupView extends StatelessWidget {
  SignupView({@required this.phoneNumber, @required this.isoCode});

  final String phoneNumber, isoCode;

  static String _inputName = '';

  static String _inputSurname = '';

  bool buttonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              _topBar(context, model),
              Expanded(
                child: _centralContent(context, model),
              ),
              _bottomAppBar(context, model),
            ],
          ),
        );
      },
      viewModelBuilder: () => SignupViewModel(),
      onModelReady: (model) => model.initLanguage(),
      //onModelReady: (model) => model.imageCreate(user.picture),
    );
  }

  Widget _topBar(BuildContext context, SignupViewModel model) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.035,
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListTile(
                trailing: Container(
                  width: 140,
                  child: new LinearPercentIndicator(
                      width: 140,
                      animation: true,
                      lineHeight: 7.0,
                      animationDuration: 2500,
                      percent: 0.75,
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: AppColors.brandLightBlue,
                      backgroundColor: AppColors.brandLightGrey),
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.051,
                child: Text(
                  //"Get started with Paynote",
                  model.pageLanguageData["SIN-5-00"][0]
                      [model.userLanguage.language],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.brandBlue,
                      fontSize: 65.nsp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Alata'),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  //"Create your profile by entering your name and  add an optional profile picture.",
                  model.pageLanguageData["SIN-5-10"][0]
                      [model.userLanguage.language],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.brandMediumGrey,
                      fontSize: 42.nsp,
                      fontFamily: 'Roboto'),
                )),
            SizedBox(height: 40.h),
          ],
        ));
  }

  Widget _centralContent(BuildContext context, SignupViewModel model) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          //height: MediaQuery.of(context).size.height * 0.2,
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: MediaQuery.of(context).size.width * 0.23,
                    child: FlatButton(
                      onPressed: model.openGallery,
                      child: Center(
                        child: model.image == null
                            ? Text(
                                //"add photo",
                                model.pageLanguageData["SIN-5-20"][0]
                                    [model.userLanguage.language],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.brandLightBlue,
                                    fontFamily: "Roboto",
                                    fontSize: 43.nsp),
                              )
                            : Text(''),
                      ),
                    ),
                    decoration: model.image == null
                        ? BoxDecoration(
                            color: AppColors.brandLightGrey,
                            borderRadius: BorderRadius.circular(200))
                        : BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(model.image),
                                fit: BoxFit.fill),
                            color: AppColors.brandLightGrey,
                            borderRadius: BorderRadius.circular(200)),
                  ),
                  Text(
                    //"Optional",
                    model.pageLanguageData["SIN-5-23"][0]
                        [model.userLanguage.language],
                    style: TextStyle(
                      color: AppColors.brandDarkGrey,
                      fontSize: 38.nsp,
                    ),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Column(
                children: [
                  Container(
                    color: AppColors.brandLightGrey,
                    width: MediaQuery.of(context).size.width * 0.6,
                    //height: MediaQuery.of(context).size.height * 0.08,
                    child: TextFormField(
                      controller: model.inputNameController,
                      onChanged: (value) {
                        print(value);
                        _inputName = value;
                        model.updateButtonState(model);
                      },
                      style: TextStyle(color: AppColors.brandBlue),
                      decoration: InputDecoration(
                        //labelText: "Name",
                        labelText: model.pageLanguageData["SIN-5-21"][0]
                            [model.userLanguage.language],
                        labelStyle: TextStyle(color: AppColors.brandDarkGrey),
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    color: AppColors.brandLightGrey,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      controller: model.inputSurnameController,
                      onChanged: (value) {
                        _inputSurname = value;
                        model.updateButtonState(model);
                      },
                      style: TextStyle(color: AppColors.brandBlue),
                      decoration: InputDecoration(
                        //labelText: "Surname",
                        labelText: model.pageLanguageData["SIN-5-22"][0]
                            [model.userLanguage.language],
                        labelStyle: TextStyle(color: AppColors.brandDarkGrey),
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottomAppBar(BuildContext context, SignupViewModel model) {
    Animation<double> animation;
    Animation<double> secondaryAnimation;
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Checkbox(
                  checkColor: AppColors.brandWhite,
                  activeColor: AppColors.brandLightBlue,
                  value: model.termAccepted,
                  onChanged: (bool value) {
                    value = true;
                    model.updateTerms();
                    model.updateButtonState(model);
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.78,
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 40.nsp),
                      children: [
                        TextSpan(
                          //text: "By creating an account I accept the ",
                          text: model.pageLanguageData["SIN-5-30"][0]
                              [model.userLanguage.language],
                        ),
                        // TextSpan(
                        //   text: "terms of use",
                        //   style:
                        //       TextStyle(decoration: TextDecoration.underline),
                        // ),
                        // TextSpan(
                        //   text: " and ",
                        // ),
                        // TextSpan(
                        //   text: "privacy policy",
                        //   style:
                        //       TextStyle(decoration: TextDecoration.underline),
                        // ),
                        // TextSpan(
                        //   text: " for paynote",
                        // ),
                      ]),
                ),
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: new BoxConstraints(maxHeight: 200, maxWidth: 300),
          child: SizedBox(),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: model.messageAccepted == false
              ? null
              : Text(
                  //"Please accept the terms of use",
                  model.pageLanguageData["SIN-5-50"][0]
                      [model.userLanguage.language],
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Roboto',
                      fontSize: 43.nsp),
                ),
        ),
        // Container(
        //   height: MediaQuery.of(context).size.width * 0.56,
        // ),
        /*model.isBusy
            ? CircularProgressIndicator()
            :*/
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 80.r,
            vertical: 40.r,
          ),
          child: RaisedButton(
              elevation: 0,
              color: AppColors.brandBlue,
              disabledColor: AppColors.brandLightGrey,
              onPressed: (model.validated)
                  ? () {
                      if (model.termAccepted == true) {
                        model.signUp(_inputName, _inputSurname, phoneNumber,
                            isoCode, context);
                      } else if (model.termAccepted == false) {
                        model.updateMessage();
                      }
                      print("AAAA");
                    }
                  : null,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                    child: Text(
                  //"Next",
                  model.pageLanguageData["SIN-5-40"][0]
                      [model.userLanguage.language],
                  style: TextStyle(
                    color: AppColors.brandWhite,
                    fontFamily: 'Alata',
                    fontSize: 48.nsp,
                  ),
                )),
              )),
        ),
      ],
    );
  }

  // void updateButtonState(SignupViewModel model) {
  //   if (_inputName.trim().length > 0 &&
  //       _inputSurname.trim().length > 0 &&
  //       model.termAccepted) {
  //     model.setValidated(true);
  //   } else {
  //     model.setValidated(false);
  //   }
  // }
}
