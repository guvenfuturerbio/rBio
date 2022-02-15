import 'package:encrypt/encrypt.dart' as encrypt;

import '../../../../core/core.dart';

String encryptWithSalsa20(String plainText, String email) {
  //final key = encrypt.Key.fromLength(32);
  final ivMail = email.substring(0, 8);
  final key = encrypt.Key.fromUtf8("+@rzf7>5(/pP`S4<K&.=*~6=;.~**Mm=");
  final iv = encrypt.IV.fromUtf8(ivMail);
  final encrypter = encrypt.Encrypter(encrypt.Salsa20(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  LoggerUtils.instance
      .i(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  LoggerUtils.instance.i(encrypted
      .base64); // CR+IAWBEx3sA/dLkkFM/orYr9KftrGa7lIFSAAmVPbKIOLDOzGwEi9ohstDBqDLIaXMEeulwXQ==
  return encrypted.base64;
  //String text = "{\"Id\":\"RiHgVRsWeNVZhpX3u9ZvZBgyD0n1\",\"NameSurname\":\"Can Avcı\",\"ElectronicMail\":\"canavci95@hotmail.com\"}"
}
