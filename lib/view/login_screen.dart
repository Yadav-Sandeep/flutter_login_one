import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  //const LoginScreen({Key? key}) : super(key: key);
  String name;

  LoginScreen(String name) : this.name = name;

  static const channel = MethodChannel("nativeCall");

  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Multi Page Application"),
        ),
        body: Center(
            child: InkWell(
          onTap: () {
            //print('Text Clicked');
            showNativeToast();
          },
          child: Text(
            name.toString(),
            style: TextStyle(fontSize: 25, color: Colors.blue),
          ),
        )));
  }

  Future<void> showNativeToast() async{
      final int showToast = await channel.invokeMethod('showMyToast',{"text":name.toString()});
  }

}