import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class Encrypt {
  static String encrypt(String plainText, String email) {
    var ivmail = email.substring(1, 9);
    final iv = IV.fromUtf8(ivmail);

    Key key = Key.fromUtf8('+@rzf7>5(/pP`S4<K&.=*~6=;.~**Mm=');
    final encrypter = Encrypter(Salsa20(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final dncrypted = encrypter.decrypt(encrypted, iv: iv);
    print("encrypted: " + encrypted.base64);
    return encrypted.base64;
  }
}
