import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_des/dart_des.dart';
import 'package:lockly_api/src/api/data/keys.dart';
import 'package:lockly_api/src/api/entities/lockly_api_request_body.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/digests/sha256.dart';

String hashPassword(String password) =>
    hex.encoder.convert(SHA256Digest().process(utf8.encoder.convert(password)));

final _anonymousEncryptEngine = RSAEngine()
  ..init(true, PublicKeyParameter<RSAPublicKey>(anonymousEncryptKey));

final _anonymousDecryptEngine = RSAEngine()
  ..init(false, PrivateKeyParameter<RSAPrivateKey>(anonymousDecryptKey));

Uint8List encryptAnonymousRequestData(Uint8List data) =>
    _processRsaChunked(_anonymousEncryptEngine, 64, data);

Uint8List decryptAnonymousResponseData(Uint8List data) =>
    _processRsaChunked(_anonymousDecryptEngine, 128, data);

Uint8List _processRsaChunked(RSAEngine engine, int chunkSize, Uint8List input) {
  final inputBlockSize = chunkSize;
  final outputBlockSize = engine.outputBlockSize;
  final inputBlockCount = (input.length ~/ inputBlockSize) +
      (input.length % inputBlockSize == 0 ? 0 : 1);
  final output = Uint8List(inputBlockCount * outputBlockSize);
  var lastChunkSize = 0;
  for (var i = 0; i < inputBlockCount; ++i) {
    final offset = i * inputBlockSize;
    lastChunkSize = engine.processBlock(
      input,
      offset,
      min(inputBlockSize, input.length - offset),
      output,
      i * outputBlockSize,
    );
  }
  return lastChunkSize == outputBlockSize
      ? output
      : output.sublist(0, output.length - (outputBlockSize - lastChunkSize));
}

Uint8List encryptUserRequestData(Uint8List key, Uint8List data) {
  final output = Uint8List.fromList(
    DES3(key: key, paddingType: DESPaddingType.PKCS7).encrypt(data),
  );
  return output;
}

Uint8List decryptUserRequestData(Uint8List key, Uint8List data) {
  final output = Uint8List.fromList(
    DES3(key: key, paddingType: DESPaddingType.PKCS7).decrypt(data),
  );
  return output;
}

extension LocklyApiRequestEncrypionExtension on DecryptedLocklyApiRequestBody {
  EncryptedLocklyApiRequestBody encrypt([Uint8List? userKey]) {
    final parameterData =
        utf8.encoder.convert(json.encoder.convert(parameters));
    final Uint8List encryptedParameterData;
    switch (encryption) {
      case LocklyApiRequestEncryption.unknown:
        throw const LocklyApiRequestUnknownCryptoException();
      case LocklyApiRequestEncryption.anonymous:
        encryptedParameterData = encryptAnonymousRequestData(parameterData);
      case LocklyApiRequestEncryption.user:
        encryptedParameterData = encryptUserRequestData(
          userKey ?? (throw const LocklyApiRequestUserKeyMissingException()),
          parameterData,
        );
    }
    return EncryptedLocklyApiRequestBody(
      encryption: LocklyApiRequestEncryption.anonymous,
      country: country,
      deviceId: deviceId,
      locale: locale,
      os: os,
      parameters: base64.encoder.convert(encryptedParameterData),
      fcmToken: fcmToken,
      miPushToken: miPushToken,
      token: token,
      versionCode: versionCode,
      versionName: versionName,
    );
  }
}

extension LocklyApiRequestDecryptionExtension on EncryptedLocklyApiRequestBody {
  DecryptedLocklyApiRequestBody decrypt(Uint8List userKey) {
    final encryptedParameterData = base64.decoder.convert(parameters);
    final Uint8List parameterData;
    switch (encryption) {
      case LocklyApiRequestEncryption.unknown:
        throw const LocklyApiRequestUnknownCryptoException();
      case LocklyApiRequestEncryption.anonymous:
        throw const LocklyApiRequestAnonymousCryptoException();
      case LocklyApiRequestEncryption.user:
        parameterData = decryptUserRequestData(userKey, encryptedParameterData);
    }
    final Map<String, dynamic> decryptedParameterData;
    try {
      decryptedParameterData = (utf8.decoder
          .fuse(json.decoder)
          .convert(parameterData) as Map<String, dynamic>?)!;
    } on FormatException {
      throw const LocklyApiRequestUserCryptoException();
    }
    return DecryptedLocklyApiRequestBody(
      encryption: encryption,
      country: country,
      deviceId: deviceId,
      locale: locale,
      os: os,
      parameters: decryptedParameterData,
      fcmToken: fcmToken,
      miPushToken: miPushToken,
      token: token,
      versionCode: versionCode,
      versionName: versionName,
    );
  }
}

abstract class LocklyApiRequestCryptoException implements Exception {
  String get message;

  const LocklyApiRequestCryptoException();

  @override
  String toString() => 'LocklyApiRequestDecryptionException(message: $message)';
}

class LocklyApiRequestAnonymousCryptoException
    extends LocklyApiRequestCryptoException {
  const LocklyApiRequestAnonymousCryptoException();

  @override
  String get message => 'Cannot decrypt anonymously encrypted data!';
}

class LocklyApiRequestUserCryptoException
    extends LocklyApiRequestCryptoException {
  const LocklyApiRequestUserCryptoException();

  @override
  String get message => 'User decryption failed!';
}

class LocklyApiRequestUserKeyMissingException
    extends LocklyApiRequestCryptoException {
  const LocklyApiRequestUserKeyMissingException();

  @override
  String get message => 'User key missing!';
}

class LocklyApiRequestUnknownCryptoException
    extends LocklyApiRequestCryptoException {
  const LocklyApiRequestUnknownCryptoException();

  @override
  String get message => 'Encryption method is unknown!';
}
