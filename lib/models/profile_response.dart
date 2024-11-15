// lib/models/profile_response.dart
class ProfileResponse {
  final int id;
  final String email;
  final String username;

  ProfileResponse({
    required this.id,
    required this.email,
    required this.username,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      id: json['id'],
      email: json['email'],
      username: json['username'],
    );
  }
}
