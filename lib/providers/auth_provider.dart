import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:presentasi/services/auth_service.dart';
import 'package:presentasi/utils/storage_helper.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _accessToken;
  String? _refreshToken;
  String? _username;

  bool get isAuthenticated => _isAuthenticated;
  String? get accessToken => _accessToken;
  String? get username => _username;

  final AuthService _authService = AuthService();

  AuthProvider() {
    _loadAuthStatus(); // Muat status autentikasi saat provider diinisialisasi
  }

  Future<void> _loadAuthStatus() async {
    try {
      _accessToken = await StorageHelper.getAccessToken();
      _refreshToken = await StorageHelper.getRefreshToken();
      _username = await StorageHelper.getUsername();
      _isAuthenticated = _accessToken != null && _refreshToken != null;
    } catch (e) {
      debugPrint('Gagal memuat status autentikasi: $e');
      _isAuthenticated = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> refreshAccessToken() async {
    if (_refreshToken != null) {
      try {
        final response = await _authService.refreshToken(_refreshToken!);
          _accessToken = response.accessToken;
          _refreshToken = response.refreshToken;
          await StorageHelper.saveTokens(_accessToken!, _refreshToken!);
          notifyListeners();
      } catch (e) {
        debugPrint('Gagal melakukan refresh token: $e');
        await logout();  // Logout jika refresh token gagal
      }
    }
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await _authService.login(username, password);
      _isAuthenticated = true;
      _accessToken = response.accessToken;
      _refreshToken = response.refreshToken;
      _username = response.username;

      await StorageHelper.saveTokens(_accessToken!, _refreshToken!);
      notifyListeners();
    } catch (e) {
      debugPrint('Login gagal: $e');
      rethrow; // Lempar kembali untuk ditangani di UI
    }
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _accessToken = null;
    _refreshToken = null;
    _username = null;

    await StorageHelper.clearTokens();
    notifyListeners();
  }
}
