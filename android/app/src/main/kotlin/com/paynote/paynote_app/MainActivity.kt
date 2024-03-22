package com.paynote.paynote_app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import android.view.WindowManager.LayoutParams

class MainActivity: FlutterActivity() {

    override fun onCreate(bundle: Bundle?)
    {
        super.onCreate(bundle)
       // getWindow().addFlags(LayoutParams.FLAG_SECURE);
    }

}
