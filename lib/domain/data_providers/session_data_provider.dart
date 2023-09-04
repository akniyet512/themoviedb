import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class Keys {
  static const String sessionId = "session_id";
  static const String accountId = "account_id";
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

  Future<int?> getAccountId() async {
    final String? id = await _secureStorage.read(key: Keys.accountId);
    return id != null ? int.tryParse(id) : null;
  }

  Future<void> setAccountId(int? value) async {
    if (value != null) {
      await _secureStorage.write(
        key: Keys.accountId,
        value: value.toString(),
      );
    } else {
      await _secureStorage.delete(key: Keys.accountId);
    }
  }
}

