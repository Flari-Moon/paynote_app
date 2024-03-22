import 'package:flutter/material.dart';
import 'package:paynote_app/models/OverlayLoadingScreens/OverlaysForLoading.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';

class TwilioService {


  TwilioPhoneVerify _twilioPhoneVerify = new TwilioPhoneVerify(
      accountSid: 'key',
      // replace with Account SID
      authToken: 'key',
      // replace with Auth Token
      serviceSid: 'key' // replace with Service SID
  );

  void showOver(BuildContext context,) {
    OverlaysForLoading(
      title: "Connecting!",
      assetImagePath: 'Assets/Illustrations/Tech_loading.png',
      text: 'We are trying to make this super fast!',
    ).showScreen(context);
  }

  void hideOver() {
    OverlaysForLoading().dismissOverlay();
  }

  Future<bool> sendOTPService(BuildContext context, String phoneNumber) async {
    showOver(context);
    var result = await _twilioPhoneVerify.sendSmsCode(phoneNumber);
    hideOver();
    if (result.successful) {
      return true;
    }
    // code sent
    else {
      return false;
      // error
      //print('${result['statusCode']} : ${result['message']}');
    }
  }

  Future<bool> verifyOTPService(BuildContext context, String phoneNumber,
      String code) async {
    showOver(context);
    var result = await _twilioPhoneVerify.verifySmsCode(
        phone: phoneNumber, code: code);
    hideOver();

    if (result.successful) {
      if (result.verification.status == VerificationStatus.approved) {
        // phone number verified
        return true;
      } else {
        return false;
        // error
        //print('${result['statusCode']} : ${result['message']}');
      }
    }
  }
}