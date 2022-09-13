package com.example.flutter_login_one

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.util.GeneratedPluginRegister
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterFragmentActivity() {

    private lateinit var fResult: MethodChannel.Result
    private lateinit var  methodCall: MethodCall

    private val CHANNEL = "nativeCall";
    private val CHANNELNEW = "nsdlpbPlatformChannel"

    var textFromFlutter: String = ""

    private lateinit var channel: MethodChannel

    /*override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
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
    }*/

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegister.registerGeneratedPlugins(FlutterEngine(this))

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNELNEW).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
                call, result ->
            fResult = result
            methodCall = call
            if (call.method == "callSetPINSdk") {

            }
            else if (call.method == "callForgotPINSdk") {

            }
            else if(call.method == "callAadhaarSdk"){
                val list: List<String>? = call.arguments()

                val intent = Intent(
                    applicationContext,
                    com.karza.aadhaarsdk.AadharActivity::class.java
                )
                intent.putExtra("KARZA-TOKEN", list?.get(0))
                intent.putExtra("ENV", list?.get(1))
                startActivityForResult(intent, 200)
            }
            else if(call.method == "callDebitCardSdk"){

            }
            else if(call.method == "callFundTransferSdk"){

            }
            else {
                result.notImplemented()
            }
        }
    }
}
