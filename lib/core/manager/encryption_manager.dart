import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt_pac;
import 'package:tuple/tuple.dart';


abstract class EncryptManager {
  String encrypt(String plainText);
  String decrypt(String encrypted);
}

class EncryptManagerImpl extends EncryptManager {
  final String _ =
      'a30d435ff5af328dc9a9c5a77066d8c9473e443187989e44fd88b22b9d1e0b5491c9d386e0bd956f5ac9e7bba6f2cd7ce07663b87e0fccd36998d2089dcc750e';

  @override
  String encrypt(String plainText) {
    try {
      final salt = _genRandomWithNonZero(8);
      final keyndIV = _deriveKeyAndIV(_, salt);
      final key = encrypt_pac.Key(keyndIV.item1);
      final iv = encrypt_pac.IV(keyndIV.item2);

      final encrypter = encrypt_pac.Encrypter(encrypt_pac.AES(key,
          mode: encrypt_pac.AESMode.cbc, padding: 'PKCS7'));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      final encryptedBytesWithSalt = Uint8List.fromList(
          _createUint8ListFromString('Salted__') + salt + encrypted.bytes);

      return base64.encode(encryptedBytesWithSalt);
    } catch (error) {
      rethrow;
    }
  }

  @override
  String decrypt(String encrypted) {
    try {
      final encryptedBytesWithSalt = base64.decode(encrypted);
      final encryptedBytes =
          encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
      final salt = encryptedBytesWithSalt.sublist(8, 16);
      var keyndIV = _deriveKeyAndIV(_, salt);
      final key = encrypt_pac.Key(keyndIV.item1);
      final iv = encrypt_pac.IV(keyndIV.item2);

      final encrypter = encrypt_pac.Encrypter(encrypt_pac.AES(key,
          mode: encrypt_pac.AESMode.cbc, padding: 'PKCS7'));
      final decrypted =
          encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);

      return decrypted;
    } catch (error) {
      rethrow;
    }
  }

  // #region Private Funcs
  Tuple2<Uint8List, Uint8List> _deriveKeyAndIV(
      String passphrase, Uint8List salt) {
    var password = _createUint8ListFromString(passphrase);
    var concatenatedHashes = Uint8List(0);
    var currentHash = Uint8List(0);
    var enoughBytesForKey = false;
    var preHash = Uint8List(0);

    while (!enoughBytesForKey) {
      // int preHashLength = currentHash.length + password.length + salt.length;
      if (currentHash.isNotEmpty) {
        preHash = Uint8List.fromList(currentHash + password + salt);
      } else {
        preHash = Uint8List.fromList(password + salt);
      }

      currentHash = md5.convert(preHash).bytes as Uint8List;
      concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
      if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
    }

    var keyBtyes = concatenatedHashes.sublist(0, 32);
    var ivBtyes = concatenatedHashes.sublist(32, 48);

    return Tuple2(keyBtyes, ivBtyes);
  }

  Uint8List _createUint8ListFromString(String s) {
    var ret = Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }

    return ret;
  }

  Uint8List _genRandomWithNonZero(int seedLength) {
    final random = Random.secure();
    const randomMax = 245;
    final uint8list = Uint8List(seedLength);
    for (var i = 0; i < seedLength; i++) {
      uint8list[i] = random.nextInt(randomMax) + 1;
    }

    return uint8list;
  }
  // #endregion
}
