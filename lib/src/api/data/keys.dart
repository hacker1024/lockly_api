import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/asn1.dart';
import 'package:pointycastle/asymmetric/api.dart';

final anonymousEncryptKey = _parseAnonymousEncryptKey();

final anonymousDecryptKey = _parseAnonymousDecryptKey();

const _anonymousEncryptKeyX509 =
    'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCZtiijnvRo5EEI0n2I7shxljMXb7mZ/FpjuS98MHGWuYYUrsiJQVgfPn29lmI/MDkhVc7oVTsg5BIyC0TUpZKTgxyFDZw08AdWKe9JZvzyGB00AGkRxcem2J64xJJ04o9FW6PDLF0gSvblZAvUdHU1YyfB7DgJhikP7lPrFNdGwwIDAQAB';

const _anonymousDecryptKeyPKCS8 =
    'MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAMBZug0p9CRIsZI+o3rMj1dlKt7AE52Ql44dSgVvaTVZ3ZWB2vRpvA80cF/QQXVbODgaU3xD0ZTkeGY6EP3lQaxLwGbQC1xrfLl4rVJPBt2qk0EtSQt729rOYBzMJSp0r5fPMmVDPogp3neMlFhP2xFlkp+yy+hsbkvXmsT9kpZjAgMBAAECgYAy0cIBJlt1lqsrq1b/47nfakA4V+EW2RPhnUVoSDYwvUx46rURrDnefolOFzSkL/SbhgEWrMhboT1aLO8+VWrTCF3BL2BPK0+G0QGYh8l56qk0dyoJiAz6Qus4OSlypNO01VIZGhNfayYlPjVlrZtDRTZF1kPbnUjcUwEKsrHXcQJBAOZbj4zopmYTfB7xFsbyP/K7nMOREjANLilie1Fkl8RZ8xSRwdz6s7r1Vx3JuUZbwyyNMG27NO+tZgdvF0u3pskCQQDVwxYUyuF+iIH9Ia2qQ1c1Al5fIBBUY8o7BT4tviLpQEjL2lZeJBvlRRzCyiZZISR+KXq8Id4+OKVpix6FoC3LAkB9z0niannezAuBFqka9NmKJ38hrEyjo78vaRLyzB67ZWkGNekMWHvqwu3WXgLrc1hwL5hghdsOf8R2kOzHNMFJAkA7xh+olMrVbSqcNAyx7b63DgCBrR+j2Xu1YVPvyplMjDNO/bDlBkfepqLSPWDXz5K6zLKLZRUWZRSsHMDeMNpdAkB1CAvpgzVt/OYbGvUDDK9VFbKtprN0hyFxuaX/pYaQL8hz7l+wkSvAd6lQgNlW5qLfYog06XUexrOFRvMjIhMm';

RSAPublicKey _parseAnonymousEncryptKey() =>
    _rsaPublicKeyFromDERBytes(base64Decode(_anonymousEncryptKeyX509));

RSAPrivateKey _parseAnonymousDecryptKey() =>
    _rsaPrivateKeyFromDERBytes(base64Decode(_anonymousDecryptKeyPKCS8));

RSAPublicKey _rsaPublicKeyFromDERBytes(Uint8List bytes) {
  final asn1Parser = ASN1Parser(bytes);
  final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

  final ASN1Sequence publicKeySeq;
  if (topLevelSeq.elements![1].runtimeType == ASN1BitString) {
    final publicKeyBitString = topLevelSeq.elements![1] as ASN1BitString;

    final publicKeyAsn =
        ASN1Parser(publicKeyBitString.stringValues as Uint8List?);
    publicKeySeq = publicKeyAsn.nextObject() as ASN1Sequence;
  } else {
    publicKeySeq = topLevelSeq;
  }

  final modulus = publicKeySeq.elements![0] as ASN1Integer;
  final exponent = publicKeySeq.elements![1] as ASN1Integer;

  final rsaPublicKey = RSAPublicKey(modulus.integer!, exponent.integer!);

  return rsaPublicKey;
}

RSAPrivateKey _rsaPrivateKeyFromDERBytes(Uint8List bytes) {
  var asn1Parser = ASN1Parser(bytes);
  final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;
  final privateKey = topLevelSeq.elements![2];

  asn1Parser = ASN1Parser(privateKey.valueBytes);
  final pkSeq = asn1Parser.nextObject() as ASN1Sequence;

  final modulus = pkSeq.elements![1] as ASN1Integer;
  final privateExponent = pkSeq.elements![3] as ASN1Integer;
  final p = pkSeq.elements![4] as ASN1Integer;
  final q = pkSeq.elements![5] as ASN1Integer;

  final rsaPrivateKey = RSAPrivateKey(
    modulus.integer!,
    privateExponent.integer!,
    p.integer,
    q.integer,
  );

  return rsaPrivateKey;
}
