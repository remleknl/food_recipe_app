import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  Future<void> login(String email, String password) async {
    _user = await _authService.login(email, password);
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    _user = await _authService.register(email, password);
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}
