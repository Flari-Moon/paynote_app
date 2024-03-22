import 'dart:convert';
import 'dart:io';
import 'package:paynote_app/Api/Language.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:stacked/stacked.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paynote_app/services/SharedPrefService.dart';

class EditProfileModel extends BaseViewModel {
  User userData;
  RequestService requestService = locator<RequestService>();
  String base64Image;
  File image_file;
  SharedPreferences prefs;
  //File image;

  List<TransactionMainModel> transactionList = <TransactionMainModel>[];
  String userId;
  NavigationService _navigationService = locator<NavigationService>();

  bool verificationEmail = false;
  bool verificationPending = false;
/*
  String inputName;
  String inputSurname;
  String inputEmail;*/
  String inputBirth;
  TextEditingController textEditingControllerName;
  TextEditingController textEditingControllerSurname;
  TextEditingController textEditingControllerEmail;
  TextEditingController textEditingControllerBirth;
  SharedPrefService _sharedPrefService = locator<SharedPrefService>();

  Language userLanguage;
  var pageLanguageData;

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

  initUser() {
    userData = _sharedPrefService.loadProfileUser();
    textEditingControllerName = TextEditingController(text: userData.firstName);
    textEditingControllerSurname =
        TextEditingController(text: userData.lastName);
    textEditingControllerEmail = TextEditingController(text: userData.email);
    //textEditingControllerBirth = TextEditingController(text: userData.dateOfBirth);
    inputBirth = userData.dateOfBirth;
    print('prof ${textEditingControllerEmail.text}');
    print(userData);
    getImage();
  }

  Future<void> getImage() async {
    image_file = await _sharedPrefService.loadProfilePicture();
    print('image loaded');
    notifyListeners();
  }

  void open_gallery() async {
    //userImage = File(user.picture);
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 20);
    List<int> imageBytes = image.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    print('wr gorgrfbrn ezd');
    image_file = image;
    notifyListeners();
  }

  void open_camera() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 20);
    List<int> imageBytes = image.readAsBytesSync();
    base64Image = base64Encode(imageBytes);

    image_file = image;
    notifyListeners();
  }

  Future<User> editUserProfile(User currentUser, BuildContext context) async {
    User responseUser;
    // print("USER BING SENT: $currentUser");
    //  print(textEditingControllerBirth.text);
    print('current user being sent $currentUser');
    print('newimage   $base64Image');
    print('new birth   $inputBirth');
    if (base64Image != null) {
      print('newimage  changed');
      currentUser.picture = base64Image;
    }
    currentUser.firstName = textEditingControllerName.text;
    currentUser.lastName = textEditingControllerSurname.text;
    currentUser.email = textEditingControllerEmail.text;
    currentUser.dateOfBirth = inputBirth;
    /* BResponse baseResponse = new BResponse();
    var temp = user.toString();*/
    print("trest USER being sent: $currentUser");
    responseUser = await requestService.updateUser(currentUser, context);
    /* userData.firstName= responseUser.firstName;
    userData.lastName= responseUser.lastName;
    userData.dateOfBirth=responseUser.dateOfBirth;
    userData.picture= responseUser.picture;
    userData.phoneNumber=responseUser.phoneNumber;*/
    userData = responseUser;
    /* final decodedBytes = base64Decode(userData.picture);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    image_file = new File(tempPath + "decodeduserrr.png");
    image_file.writeAsBytesSync(decodedBytes);*/
    print("RESPONSE USER: $responseUser");
    userData = _sharedPrefService.loadProfileUser();
    getImage();
    notifyListeners();
  }
}
