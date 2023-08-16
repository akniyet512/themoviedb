import 'package:themoviedb/domain/data_providers/session_data_provider.dart';

class MyAppModel {
  final SessionDataProvider _sessionDataProvider = SessionDataProvider();
  bool _isAuth = false;

  bool get isAuth => _isAuth;

  Future<void> checkOut() async {
    final String? sessionId = await _sessionDataProvider.getSessionId();
    _isAuth = sessionId != null;
  }
}
