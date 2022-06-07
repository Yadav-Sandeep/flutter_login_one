

import 'dart:convert';
import 'package:crypto/crypto.dart';

class CommonData
{
  //static int num;
  final url = "https://Jiffyuat.nsdlbank.co.in";
  final passkey = "yYxeaKPojTwCJdFMSSiGKmzkpJxgfDJSQETgglGteGguzFtLMLdJtwVnhvKFNZHzYPipOLGxYPAKrswBVbpYzeFyAemtKNtCVPjOQzJkbdUkpRoCXAeNDNyYuUjZYzAu";

  String getCheckSum(String checkSumSequence) {
    //Utf8Encoder:-This class converts strings to their UTF-8 code units (a list of unsigned 8-bit integers).
    List<int> messageBytes = Utf8Encoder().convert(checkSumSequence);
    List<int> key = Utf8Encoder().convert(passkey);
    Hmac hmac = Hmac(sha512, key);
    Digest digest = hmac.convert(messageBytes);
    String base64Mac = base64.encode(digest.bytes);
    return base64Mac;
  }

  //convert into byteArray using below three methods
  /*List<int> bytes = utf8.encode(passKey);
                          print(bytes11);*/

  /*List<int> bytes = passKey.codeUnits;
                          print(bytes);*/

  //List<int> bytes = passKey.runes.toList();


}