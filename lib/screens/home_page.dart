import 'package:flutter/material.dart';
import 'package:presentasi/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: authProvider.isAuthenticated
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You are logged in!'),
                  ElevatedButton(
                    onPressed: () {
                      authProvider.logout();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text('Logout'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: Text('Dashboard'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You are not logged in!'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
      ),
    );
  }
}
