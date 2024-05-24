import 'package:flutter/material.dart';
import 'package:nexa_test/services/auth_service.dart';
import 'package:nexa_test/shared/preference_manager.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  AuthProvider() {
    checkLoginStatus();
  }
  bool get isAuthenticated => _isAuthenticated;
  Future<bool> login(String username, String password) async {
    try {
      final result = await AuthService.authenticate(username, password);
      if (result) {
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Login failed: $e');
      return false;
    }
  }

  Future<void> checkLoginStatus() async {
    String? token = await PreferenceManager.getToken();
    if (token != null) {
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  void logOut() async {
    await PreferenceManager.clearToken();
    _isAuthenticated = false;
    notifyListeners();
  }
}
