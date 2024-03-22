import 'package:flutter/material.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:stacked/stacked.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'LoginViewModel.dart';

// class LoginView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<LoginViewModel>.reactive(
//       builder: (context, model, child) {
//         return Scaffold(
//           resizeToAvoidBottomInset: false,
//           resizeToAvoidBottomPadding: false,
//           //persistentFooterButtons: [],

//           body: Container(
//               child: Container(
//             padding: EdgeInsets.all(15),
//             color: AppColors.brandWhite,
//             child: ListView(
//               children: [
//                 Container(
//                   height: 85,
//                 ),

//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.051,
//                 ),

//                 //Form fields

//                 //Form fields end

//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.2,
//                 ),
//               ],
//             ),
//           )),
//         );
//       },
//       viewModelBuilder: () => LoginViewModel(),
//     );
//   }
// }

class LoginView extends StatelessWidget {
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';
  bool validNumber = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _topBar(context, model),
              _centralContent(context, model),
              _bottomAppBar(context, model),
            ],
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => model.initLanguage(),
    );
  }

  Widget _topBar(BuildContext context, LoginViewModel model) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50.w, 120.w, 50.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.1,
              child: Text(
                //"Welcome Back!",
                model.pageLanguageData["SIN-9-00"][0]
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
              child: Text(
                //"Enter your registered phone number.",
                model.pageLanguageData["SIN-9-10"][0]
                    [model.userLanguage.language],
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AppColors.brandMediumGrey,
                    fontSize: 48.nsp,
                    fontFamily: 'Roboto'),
              )),
        ],
      ),
    );
  }

  Widget _centralContent(BuildContext context, LoginViewModel model) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InternationalPhoneNumberInput(
              countries: ['NL', 'BE', 'BR'],
              hintText: model.pageLanguageData["SIN-9-20"][0]
                  [model.userLanguage.language],
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);

                model.phoneNumber = number.phoneNumber;
              },
              onInputValidated: (bool value) {
                print(value);
                validNumber = value;
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,

              selectorTextStyle: TextStyle(color: Colors.black),
              textStyle: TextStyle(
                  color: AppColors.brandDarkGrey, fontFamily: 'Roboto'),
              //initialValue: 1254,
              // textFieldController: model.controller,
              //inputBorder: OutlineInputBorder(),
            ),
            // Row(
            //   children: [
            //     Container(
            //       width: MediaQuery.of(context).size.width * 0.15,
            //     ),
            //     Container(
            //       width: MediaQuery.of(context).size.width * 0.7,
            //       child: InternationalPhoneInput(
            //         decoration:
            //             InputDecoration.collapsed(hintText: '(123) 123-1234'),
            //         //onPhoneNumberChange: onPhoneNumberChange,
            //         initialPhoneNumber: phoneNumber,
            //         initialSelection: phoneIsoCode,
            //         enabledCountries: ['+32', '+31'],
            //         showCountryCodes: true,
            //         showCountryFlags: true,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context, LoginViewModel model) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.05,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 50.w,
          vertical: 30.h,
        ),
        child: RaisedButton(
            elevation: 0,
            color: AppColors.brandBlue,
            disabledColor: AppColors.brandLightGrey,
            onPressed: (model.phoneNumber == null)
                ? null
                : () {
                    //print();
                    model.getUserByPhoneNumber(context);
                  },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Center(
                  child: Text(
                //"Send Code",
                model.pageLanguageData["SIN-9-30"][0]
                    [model.userLanguage.language],
                style: TextStyle(
                    color: AppColors.brandWhite,
                    fontFamily: 'Alata',
                    fontSize: 48.nsp),
              )),
            )),
      ),
    );
  }
}
