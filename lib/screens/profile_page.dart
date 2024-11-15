// lib/screens/profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:presentasi/providers/profile_provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    // Memuat profile jika belum ada
    if (profileProvider.profile == null && !profileProvider.isLoading) {
      profileProvider.loadProfile();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: profileProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : profileProvider.error != null
              ? Center(child: Text('Error: ${profileProvider.error}'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username: ${profileProvider.profile?.username ?? 'N/A'}'),
                      Text('Email: ${profileProvider.profile?.email ?? 'N/A'}'),
                    ],
                  ),
                ),
    );
  }
}
