import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_login_one/model/LoginResponse.dart';
import 'package:flutter_login_one/presentor/presentor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements LoginContract{

  LoginScreenPresenter? _loginScreenPresenter;

  _MyAppState() {
    _loginScreenPresenter = LoginScreenPresenter(this);
  }

  void showSnackBar(BuildContext context){
    final snackBar = SnackBar(content: Text('Test Hello'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
          backgroundColor: Color(0xFFEFC227),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder()),
                        onChanged: (String value) {},
                        validator: (value) {
                          return value!.isEmpty ? 'PLease enter email' : null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter Password',
                            prefixIcon: Icon(Icons.password),
                            border: OutlineInputBorder()),
                        onChanged: (String value) {},
                        validator: (value) {
                          return value!.isEmpty ? 'PLease enter email' : null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: () {
                          var plainJsonRequestSuccess = {
                            "channelid": "dPSKuBsjasTaMQjPdZjP",
                            "appid": "com.nsdl.mfino",
                            "partnerid": "NSDLAGENCY0001",
                            "mobileno": "918108968981",
                            "type": "PARTNER",
                            "emailid": "saurabha@nsdlbank.co.in",
                            "password": "12345@Uat",
                            "token": "NA",
                            "signcs": "iTK0BHmO9JZldBUeKOdLrmdDVGekP8UvTnLGRfoHBABGyL27voaHbnILD5InEwVS56hKyNzsw33zfx6Z9C1LDw=="
                          };
                          var plainJsonRequestInvalidCred = {
                            "channelid": "dPSKuBsjasTaMQjPdZjP",
                            "appid": "com.nsdl.mfino",
                            "partnerid": "NSDL543581325114",
                            "mobileno": "918108968981",
                            "type": "PARTNER",
                            "emailid": "saurabha@nsdlbank.co.in",
                            "password": "123fgh",
                            "token": "NA",
                            "signcs": "cbUEdWmKxDomAgXTzVoT1sBxKvwIFx4iZ5BqdqiaMinI20v2KOY02YgQStmbOh52PirZ+HfbPmEroY1iiZUmwQ=="
                          };
                          var plainJsonRequestChecksumIssue = {
                            "channelid": "dPSKuBsjasTaMQjPdZjP",
                            "appid": "com.nsdl.mfinoooo",
                            "partnerid": "NSDL543581325114",
                            "mobileno": "918108968981",
                            "type": "PARTNER",
                            "emailid": "saurabha@nsdlbank.co.in",
                            "password": "123fgh",
                            "token": "NA",
                            "signcs": "cbUEdWmKxDomAgXTzVoT1sBxKvwIFx4iZ5BqdqiaMinI20v2KOY02YgQStmbOh52PirZ+HfbPmEroY1iiZUmwQ=="
                          };
                          String plainJsonEncode = jsonEncode(plainJsonRequestSuccess);
                          print("Request- " + plainJsonEncode);
                          _loginScreenPresenter?.postLogin(plainJsonEncode);
                        },
                        child: Text('Login'),
                        color: Colors.teal,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onLoginError(String errorTxt) {
    print("Error Text- " + errorTxt);
  }

  @override
  void onLoginSuccess(LoginResponse response) {
    print("Response :- " + jsonEncode(response));
  }
}

