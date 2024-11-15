import 'package:flutter/material.dart';
import 'package:presentasi/screens/product_page.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/navigation_provider.dart';
import 'home_login_page.dart'; // Home page after login
import 'profile_page.dart'; // Profile page

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Widget> _pages = [
    HomeLoginPage(),  // HomePage for the first tab
    ProfilePage(),    // ProfilePage for the second tab
    ProductPage(),  // HomePage for the first tab
  ];

  @override
  void initState() {
    super.initState();
    // Pengecekan status autentikasi setelah halaman pertama dirender
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (!authProvider.isAuthenticated) {
        // Jika tidak terautentikasi, arahkan ke halaman login
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: _pages[navigationProvider.selectedIndex],  // Display page based on selected index from provider
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationProvider.selectedIndex,
        onTap: (index) {
          navigationProvider.setIndex(index);  // Update index in provider
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Produk',
          ),
        ],
      ),
    );
  }
}
