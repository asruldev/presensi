import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:presentasi/providers/auth_provider.dart';
import 'package:presentasi/providers/navigation_provider.dart';
import 'package:presentasi/providers/product_provider.dart';
import 'package:presentasi/providers/profile_provider.dart';
import 'screens/product_page.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Logika untuk mengubah judul AppBar atau melakukan hal lainnya
    if (route.settings.name == '/profile') {
      // Misalnya, mengubah judul AppBar pada halaman Profile
      // AppBar(title: Text('Profile'));
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'Presensi',
        navigatorObservers: [MyNavigatorObserver()],
        initialRoute: '/', // Halaman awal setelah login
        routes: {
          '/': (context) => DashboardPage(),
          '/login': (context) => LoginPage(),
          '/profile': (context) => ProfilePage(),
          '/product': (context) => ProductPage(),
        },
        onGenerateRoute: (settings) {
          // Cek autentikasi untuk rute yang membutuhkan autentikasi
          if (settings.name == '/' || settings.name == '/profile') {
            final authProvider = Provider.of<AuthProvider>(context, listen: false);
            if (!authProvider.isAuthenticated) {
              // Jika pengguna tidak terautentikasi, arahkan ke halaman login
              return MaterialPageRoute(builder: (context) => LoginPage());
            }
          }
          return null;
        },
      ),
    );
  }
}
