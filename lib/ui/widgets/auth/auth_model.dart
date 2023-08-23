import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final TextEditingController loginTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  final ApiClient _apiClient = ApiClient();
  final SessionDataProvider _sessionDataProvider = SessionDataProvider();

  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    if (loginTextController.text.isEmpty &&
        passwordTextController.text.isEmpty) {
      _errorMessage = "Fill login and password";
      notifyListeners();
      return;
    } else {
      _errorMessage = null;
      _isAuthProgress = true;
      notifyListeners();
      String? sessionId;
      try {
        sessionId = await _apiClient.auth(
          username: loginTextController.text,
          password: passwordTextController.text,
        );
      } on ApiClientException catch (e) {
        switch (e.type) {
          case ApiClientExceptionType.network:
            _errorMessage =
                "Server is unavailable! Check your internet connection.";
            break;
          case ApiClientExceptionType.auth:
            _errorMessage = "Wrong login or password!";
            break;
          default:
            _errorMessage = "Server is unavailable!";
            break;
        }
      } 
      _isAuthProgress = false;
      if (_errorMessage != null) {
        notifyListeners();
        return;
      }
      await _sessionDataProvider.setSessionId(sessionId).whenComplete(() async {
        await Navigator.of(context)
            .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
      });
    }
  }
}
