// lib/providers/profile_provider.dart
import 'package:flutter/material.dart';
import 'package:presentasi/models/profile_response.dart';
import 'package:presentasi/services/profile_service.dart';

class ProfileProvider with ChangeNotifier {
  ProfileResponse? _profile;
  bool _isLoading = false;
  String? _error;

  ProfileResponse? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final ProfileService _profileService = ProfileService();

  Future<void> loadProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _profileService.getProfile();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
