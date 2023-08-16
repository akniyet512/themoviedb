import 'dart:developer';

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
      } catch (e) {
        log(e.toString());
        _errorMessage = "Wrong login or password!";
        _isAuthProgress = false;
        notifyListeners();
        return;
      }
      _isAuthProgress = false;
      await _sessionDataProvider.setSessionId(sessionId).whenComplete(() async {
        await Navigator.of(context)
            .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
      });
    }
  }
}