import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:presentasi/models/auth_response.dart';

class AuthService {
  final String _baseUrl = 'http://127.0.0.1:8888';

  Future<AuthResponse> login(String username, String password) async {
    final Uri url = Uri.parse('$_baseUrl/token');
    final Map<String, String> headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final Map<String, String> body = {
      'grant_type': 'password',
      'username': username,
      'password': password,
      'scope': '',
      'client_id': 'string',
      'client_secret': 'string',
    };

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception('Login failed: ${error['detail'] ?? 'Unknown error'}');
    }
  }

  Future<AuthRefreshResponse> refreshToken(String refreshToken) async {
    final Uri url = Uri.parse('$_baseUrl/refresh-token?refresh_token=$refreshToken');
    final Map<String, String> headers = {
      'accept': 'application/json',
    };

    try {
      
      final response = await http.post(url, headers: headers);
      
      if (response.statusCode == 200) {
        return AuthRefreshResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      throw Exception('Error refreshing token: $e');
    }
  }
}
