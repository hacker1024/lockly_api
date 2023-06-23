import 'dart:convert';
import 'dart:io';

import 'package:lockly_api/src/api/data/crypto.dart';

/// Decrypts an encrypted user key from an account query response.
void main(List<String> arguments) {
  if (arguments.isEmpty) {
    stderr.writeln('No key provided!');
    exit(2);
  }

  final encryptedUserKey = base64.decode(arguments[0]);
  final userKeyBase64 =
      utf8.decoder.convert(decryptAnonymousResponseData(encryptedUserKey));
  stdout.writeln(userKeyBase64);
}
