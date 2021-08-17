// import 'package:cipher2/cipher2.dart';
import 'package:flutter/services.dart';

class EncryptionManager{
  String key = '1245714587458745'; //combination of 16 character
  String iv = 'e16ce913a20dadb8';


  Future<String> stringEncryption(String plainText) async {
    String encryptedString = '';
    try {
      // encrytion
      // encryptedString = await Cipher2.encryptAesCbc128Padding7(plainText, key, iv);
      // print("testEncrytion case2: success");
    } on PlatformException catch(e) {
      if(e.code == "ERROR_INVALID_KEY_OR_IV_LENGTH"){
        // print("testEncrytion ==${plainText}== case2: pass : ${e.toString()}");
      }else{
        // print("testEncrytion ==${plainText}== case2: failed : ${e.toString()}");
      }
    }

//      String encryptedString = await Cipher2.encryptAesCbc128Padding7(plainText, key, iv);

      // print('-----------------------------------------');
      // print('Plain Text: $plainText');
      // print('Encryption: $encryptedString'); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
      // print('-----------------------------------------\n\n');

      return encryptedString;
    }


    Future<String> stringDecryption(String cypherText) async {
      String decryptedString = "";
      try {
        // decryption
        // decryptedString = await Cipher2.decryptAesCbc128Padding7(cypherText, key, iv);
        // print("testDecrytion case2: success");
      } on PlatformException catch(e) {
        if(e.code == "ERROR_INVALID_KEY_OR_IV_LENGTH"){
          // print("testDecrytion ==${cypherText}== case2: pass : ${e.toString()}");
        }else{
          // print("testDecrytion ==${cypherText}== case2: failed : ${e.toString()}");
        }
      }
      // print('-----------------------------------------');
      // print('Cypher Text: $cypherText');
      // print('Decryption: $decryptedString'); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
      // print('-----------------------------------------\n\n');

      return decryptedString;
    }
}