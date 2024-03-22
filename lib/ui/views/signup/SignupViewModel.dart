import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/Api/BResponse.dart';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/models/OverlayLoadingScreens/OverlaysForLoading.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/services/SharedPrefService.dart';
import 'package:paynote_app/utils/Response.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:paynote_app/utils/serverError.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends BaseViewModel {
  final client =
      ApiClientService(Dio(BaseOptions(contentType: "application/json")));
  File _image;
  bool termAccepted = false;
  bool messageAccepted = false;
  NavigationService _navigationService = locator<NavigationService>();
  var img;
  User user = new User();
  User responseUser;
  DialogService _dialogService = locator<DialogService>();
  ImagePicker imagePicker = new ImagePicker();
  String base64Image;
  RequestService requestService = locator<RequestService>();
  BResponse baseResponse;
  bool validated = false;
  var _inputSurnameController = TextEditingController();

  var _inputNameController = TextEditingController();

  TextEditingController get inputNameController => _inputNameController;
  TextEditingController get inputSurnameController => _inputSurnameController;

  void updateButtonState(SignupViewModel model) {
    if (inputNameController.text.trim().length > 0 &&
        inputSurnameController.text.trim().length > 0 &&
        termAccepted) {
      setValidated(true);
    } else {
      setValidated(false);
    }
  }

  Language userLanguage;
  var pageLanguageData;
  SharedPrefService _sharedPrefService = locator<SharedPrefService>();

  initLanguage() {
    //userLanguage = _sharedPrefService.loadProfileLanguage();

    pageLanguageData = json.decode(SharedPref().getString('translationTag'));
    userLanguage = Language(language: SharedPref().getString('language'));

    // print(userLanguage.language);
    // print('USER LANGUAGE: ${(SharedPref().getString('language'))}');
    // print(
    //     "THIS PRINT" + pageLanguageData["SIN-0-30"][0][userLanguage.language]);
    notifyListeners();
  }

  Future<User> signUp(String name, String surName, String number,
      String isoCode, BuildContext context) async {
    String deviceToken = SharedPref().getString('firebaseToken');
    print('signup method $deviceToken');
    user.firstName = name;
    user.lastName = surName;
    user.phoneNumber = number;
    user.countryCode = isoCode;
    user.deviceToken = deviceToken;
    // user.typeOfRequest='set';
    print(user.toString());
    print(name);
    print(surName);
    print(number);
    print(isoCode);
    print(base64Image);
    setBusy(true);
    responseUser = await requestService.signUpApp(user, context);
    if (responseUser != null) {
      print(responseUser);
      goToPin();
    } else {
      // _dialogService.showDialog(title: 'Ops',description: 'Something went wrong');
      // goToPin();
      setBusy(false);
      notifyListeners();
    }
  }

  void updateTerms() {
    termAccepted = !termAccepted;
    notifyListeners();
  }

  void setValidated(bool validated) {
    this.validated = validated;
    notifyListeners();
  }

  void updateMessage() {
    messageAccepted = !messageAccepted;
    notifyListeners();
  }

  void openCamera() async {
    img = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 480,
      maxWidth: 640,
      imageQuality: 20,
    );
    _image = img;
    List<int> imageBytes = _image.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    user.picture = base64Image;
    notifyListeners();
  }

  void openGallery() async {
    img = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 20);
    _image = img;
    List<int> imageBytes = _image.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    user.picture = base64Image;
    notifyListeners();
  }

  File get image => _image;

  void goToPin() {
    _navigationService.replaceWith(Routes.manageYourAccessView,
        arguments: ManageYourAccessViewArguments(user: responseUser));
  }
}
