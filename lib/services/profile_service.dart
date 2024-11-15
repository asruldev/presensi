// lib/services/profile_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:presentasi/models/profile_response.dart';
import 'package:presentasi/utils/storage_helper.dart';
import 'package:presentasi/services/auth_service.dart';

class ProfileService {
  final String _baseUrl = 'http://127.0.0.1:8888';
  final AuthService _authService = AuthService();

  Future<ProfileResponse> getProfile() async {
    try {
      final String? accessToken = await StorageHelper.getAccessToken();
      if (accessToken == null) {
        throw Exception("Token tidak ditemukan");
      }

      final Uri url = Uri.parse('$_baseUrl/me');
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        return ProfileResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        // Token kedaluwarsa, coba refresh token
        final String? refreshToken = await StorageHelper.getRefreshToken();
        if (refreshToken == null) {
          throw Exception("Refresh token tidak ditemukan");
        }

        // Coba refresh token
        final response = await _authService.refreshToken(refreshToken!);
          await StorageHelper.saveTokens(response.accessToken!, response.refreshToken!);

        // Ulangi request dengan access token yang baru
        return await getProfile(); // Rekursif untuk mencoba permintaan setelah mendapatkan token baru
      } else {
        throw Exception('Gagal memuat profile');
      }
    } catch (e) {
      rethrow;
    }
  }
}
