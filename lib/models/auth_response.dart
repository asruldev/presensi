class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String username;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.username,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      username: json['username'],
    );
  }
}

class AuthRefreshResponse {
  final String accessToken;
  final String refreshToken;

  AuthRefreshResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthRefreshResponse.fromJson(Map<String, dynamic> json) {
    return AuthRefreshResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
