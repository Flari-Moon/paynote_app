import 'package:paynote_app/models/OverlayLoadingScreens/OverlaysForLoading.dart';
import 'package:flutter/cupertino.dart';

class OverlayService {


  void showOver(BuildContext context) {
    OverlaysForLoading(
      title: "WHOOT WOOT!",
      assetImagePath: 'Assets/Illustrations/Tech_loading.png',
      text: 'We are trying to make this super fast!',
    ).showScreen(context);
  }

  void hideOver() {
    OverlaysForLoading().dismissOverlay();
  }
}