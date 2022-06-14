import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  //const LoginScreen({Key? key}) : super(key: key);
  String name;

  LoginScreen(String name):
        this.name = name
  ;

  @override
  Widget build (BuildContext ctxt) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Multi Page Application"),
        ),
        body: Center(child: Text(name.toString()))
    );
  }
}