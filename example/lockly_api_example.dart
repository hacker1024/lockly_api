import 'package:lockly_api/lockly_api.dart';

void main(List<String> arguments) async {
  final api = LocklyApi();
  final doorLocks = await api.login(arguments[0], arguments[1]);
  await api.getStatus(doorLocks[0]);
  api.close();
}
