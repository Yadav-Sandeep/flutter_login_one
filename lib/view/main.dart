import 'package:flutter/material.dart';
import 'package:flutter_login_one/model/LoginResponse.dart';
import 'package:flutter_login_one/presentor/presentor.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements LoginContract{

  LoginScreenPresenter? _loginScreenPresenter;
  final TextEditingController emailIdText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();

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
                        controller: emailIdText,
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
                        controller: passwordText,
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

                          String channelId, appId, partnerId, mobileNo, type, email, password, token, signcs = "" ;
                          email = emailIdText.text;
                          password = passwordText.text;
                          bool isValidEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

                          if(email.isEmpty){
                            Fluttertoast.showToast(
                                msg: "Enter Email Id!!",
                                toastLength: Toast.LENGTH_SHORT
                            );
                          }else if(email.isNotEmpty && !isValidEmail){
                            Fluttertoast.showToast(
                                msg: "Enter Valid Email Id!!",
                                toastLength: Toast.LENGTH_SHORT
                            );
                          }else if(password.isEmpty){
                            Fluttertoast.showToast(
                                msg: "Enter Password!!",
                                toastLength: Toast.LENGTH_SHORT
                            );
                          }else{
                            FocusScope.of(context).unfocus();
                            showLoaderDialog(context);
                            channelId = "dPSKuBsjasTaMQjPdZjP";
                            appId = "com.nsdl.mfino";
                            partnerId = "NSDLAGENCY0001";
                            mobileNo = "918108968981";
                            type = "PARTNER";
                            token = "NA";
                            signcs = "";

                            String passKey = 'yYxeaKPojTwCJdFMSSiGKmzkpJxgfDJSQETgglGteGguzFtLMLdJtwVnhvKFNZHzYPipOLGxYPAKrswBVbpYzeFyAemtKNtCVPjOQzJkbdUkpRoCXAeNDNyYuUjZYzAu';
                            String checksumSeq = channelId + appId + partnerId + mobileNo + type +
                                email + password + token;

                            //convert into byteArray using below three methods
                            /*List<int> bytes = utf8.encode(passKey);
                          print(bytes11);*/

                            /*List<int> bytes = passKey.codeUnits;
                          print(bytes);*/

                            List<int> bytes = passKey.runes.toList();
                            print(bytes);

                            //Utf8Encoder:-This class converts strings to their UTF-8 code units (a list of unsigned 8-bit integers).
                            List<int> messageBytes = Utf8Encoder().convert(checksumSeq);
                            List<int> key = Utf8Encoder().convert(passKey);
                            Hmac hmac = Hmac(sha512, key);
                            Digest digest = hmac.convert(messageBytes);

                            String base64Mac = base64.encode(digest.bytes);
                            print("Seq- " + checksumSeq);
                            var plainJsonRequest = {
                              "channelid": channelId,
                              "appid": appId,
                              "partnerid": partnerId,
                              "mobileno": mobileNo,
                              "type": type,
                              "emailid": email,
                              "password": password,
                              "token": token,
                              "signcs": base64Mac
                            };
                            print("TEST- " + base64Mac);
                            String plainJsonEncode = jsonEncode(plainJsonRequest);
                            print("Request- " + plainJsonEncode);
                            _loginScreenPresenter?.postLogin(plainJsonEncode);
                          }
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

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 20),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  @override
  void onLoginError(String errorTxt) {
    print("Error Text- " + errorTxt);
    Fluttertoast.showToast(
        msg: "Failed: "+ errorTxt,
        toastLength: Toast.LENGTH_SHORT
    );
    Navigator.pop(context);
  }

  @override
  void onLoginSuccess(LoginResponse response) {
    print("Response :- " + jsonEncode(response));
    Fluttertoast.showToast(
        msg: "Succcess: "+ response.fullName.toString(),
        toastLength: Toast.LENGTH_SHORT
    );
    Navigator.pop(context);
  }
}

