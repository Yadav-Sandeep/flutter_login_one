package com.example.flutter_login_one

import android.content.Intent
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private val CHANNEL = "nativeCall";

    var textFromFlutter: String = ""

    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //textFromFlutter = call.argument("text");

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL)
        
        channel.setMethodCallHandler { call, result ->

            if(call.method == "showMyToast"){
                textFromFlutter = call.argument<String>("text").toString()
                Toast.makeText(this,textFromFlutter + "..From Native..",Toast.LENGTH_SHORT).show()

                val intent1 = Intent(this,NativeActivity::class.java)

                startActivityForResult(intent1, 200)
            }
        }
    }
}
