import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:lockly_api/src/api/data/crypto.dart';
import 'package:lockly_api/src/api/data/device_id.dart';
import 'package:lockly_api/src/api/entities/lockly_api_request_body.dart';
import 'package:lockly_api/src/errors/entities/errors.dart';
import 'package:lockly_api/src/lock/entities/door_lock.dart';

class LocklyApi {
  final _httpClient = http.Client();
  final _deviceId = generateDeviceId();

  String? _username;
  String? _authHeader;
  Uint8List? _userKey;

  bool get authenticated => _username != null;

  String get username {
    assert(authenticated, 'Not authenticated!');
    return _username!;
  }

  void close() => _httpClient.close();

  Future<Map<String, dynamic>> _makeApiRequest(
    String endpoint,
    String body, {
    String contentType = 'text/plain',
  }) async {
    final response = await _httpClient.post(
      Uri(
        scheme: 'https',
        host: 'apiserv03c.lockly.com',
        path: '/pgsmtlkv2/api/$endpoint',
      ),
      headers: {
        HttpHeaders.contentTypeHeader: contentType,
        if (_authHeader != null) HttpHeaders.authorizationHeader: _authHeader!,
      },
      body: body,
    );

    final responseJson = json.decode(response.body) as Map<String, dynamic>;
    if (responseJson['cod'].toString() != '200') {
      throw LocklyApiException.fromJson(responseJson);
    }
    if (response.headers.containsKey(HttpHeaders.authorizationHeader)) {
      _authHeader = response.headers[HttpHeaders.authorizationHeader];
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> makeJsonApiRequest(
    String endpoint, {
    bool userEncryption = true,
    required Map<String, dynamic> parameters,
    String? token,
  }) async =>
      _makeApiRequest(
        endpoint,
        contentType: 'application/json',
        json.encoder.convert(
          DecryptedLocklyApiRequestBody(
            encryption: userEncryption
                ? LocklyApiRequestEncryption.user
                : LocklyApiRequestEncryption.anonymous,
            country: 'AU',
            deviceId: _deviceId,
            locale: 'EN',
            os: 'android',
            parameters: parameters,
            token: token,
            versionName: '237',
            versionCode: '2.3.7',
          ).encrypt(_userKey),
        ),
      );

  Future<List<DoorLock>> login(String username, String password) async {
    await makeJsonApiRequest(
      'login',
      userEncryption: false,
      parameters: {'acct': username, 'pw': hashPassword(password)},
    );
    _username = username;

    final accountQueryResponse = await makeJsonApiRequest(
      'qrylknew',
      userEncryption: false,
      parameters: {'acct': username},
    );

    final encryptedUserKey =
        base64.decode(accountQueryResponse['key'] as String);
    _userKey = base64.decoder.convert(
      utf8.decoder.convert(decryptAnonymousResponseData(encryptedUserKey)),
    );

    final doorLocks =
        ((accountQueryResponse['dl'] as List<dynamic>?) ?? const [])
            .cast<String>()
            .map(base64.decoder.convert)
            .map((data) => decryptUserRequestData(_userKey!, data))
            .map(utf8.decoder.fuse(json.decoder).convert)
            .cast<Map<String, dynamic>>()
            .map(DoorLock.fromJson)
            .toList(growable: false);

    return doorLocks;
  }

  void logout() {
    _username = null;
    _authHeader = null;
    _userKey = null;
  }

  Future<void> checkOtaUpdate() async {
    final response = await _makeApiRequest(
      'lockly/syspara',
      'firmware_ver',
    );
  }

  Future<void> getStatus(DoorLock doorLock) async {
    final response = await makeJsonApiRequest(
      'getstatus',
      parameters: {
        'acct': username,
        'hubid': doorLock.hubId,
      },
    );
  }
}
