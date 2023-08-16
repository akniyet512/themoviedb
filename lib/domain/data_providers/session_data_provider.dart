import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class Keys {
  static const sessionId = "sessionId";
}

class SessionDataProvider {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String?> getSessionId() async =>
      await _secureStorage.read(key: Keys.sessionId);

  Future<void> setSessionId(String? value) async {
    if (value != null) {
      await _secureStorage.write(
        key: Keys.sessionId,
        value: value,
      );
    } else {
      await _secureStorage.delete(key: Keys.sessionId);
    }
  }
}
