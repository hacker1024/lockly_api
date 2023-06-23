import 'package:freezed_annotation/freezed_annotation.dart';

part 'door_lock.freezed.dart';
part 'door_lock.g.dart';

@freezed
class DoorLock with _$DoorLock {
  const factory DoorLock({
    @JsonKey(name: 'propertyId') required int propertyId,
    @JsonKey(name: 'roomId') required int roomId,
    @JsonKey(name: 'ID') required String id,
    @JsonKey(name: 'na') required String name,
    @JsonKey(name: 'tz') required String timezone,
    @JsonKey(name: 'hubver') required String hubver,
    @JsonKey(name: 'mod') required String model,
    @JsonKey(name: 'blename') required String blename,
    @JsonKey(name: 'lockingMode') required String lockingMode,
    @JsonKey(name: 'hubid') required String hubId,
    @JsonKey(name: 'iotdm') required String iotDMName,
    @JsonKey(name: 'iotsecret') required String iotDMSecret,
    @JsonKey(name: 'iotprodkey') required String iotDMProdKey,
    @JsonKey(name: 'iothost') required String iotHost,
  }) = _DoorLock;

  factory DoorLock.fromJson(Map<String, dynamic> json) =>
      _$DoorLockFromJson(json);
}
