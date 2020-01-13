package com.mt.flutter_flip_clock

import android.os.Bundle
import android.view.View
import android.view.Window
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.icu.lang.UCharacter.GraphemeClusterBreak.T
import android.view.WindowManager


class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {

        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}
