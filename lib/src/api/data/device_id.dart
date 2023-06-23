import 'package:uuid/uuid.dart';

String generateDeviceId() =>
    const Uuid().v4().replaceAll('-', '').toLowerCase();
