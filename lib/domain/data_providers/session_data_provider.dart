import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class Keys {
  static const sessionId = "sessionId";
}

class SessionDataProvider {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String?> sessionId() async =>
      await _secureStorage.read(key: Keys.sessionId);

  Future<void> setSessionId(String value) async => await _secureStorage.write(
        key: Keys.sessionId,
        value: value,
      );
}
