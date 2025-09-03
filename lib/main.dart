import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';

// Import your new page files
import 'pages/home_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/land_data_page.dart';
import 'pages/land_location_page.dart';
import 'pages/login_page.dart';
import 'pages/cropping_page.dart';
import 'pages/add_crop_page.dart';
import 'pages/soil_data_page.dart';
import 'pages/water_data_page.dart';
import 'pages/analysis_page.dart';
import 'pages/settings_page.dart';
import 'pages/user_type_selection_page.dart';
import 'pages/farmer_registration_page.dart';
import 'pages/supervisor_registration_page.dart';
import 'pages/admin_registration_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: FarmerApp(),
    ),
  );
}

class FarmerApp extends StatelessWidget {
  const FarmerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'কৃষক ও জমি ব্যবস্থাপনা',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'BengaliFont',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => MainAppPage(),
        '/home': (context) => HomePage(),
        '/dashboard': (context) => DashboardPage(),
        '/land_data': (context) => LandDataPage(),
        '/add_land': (context) => LandLocationPage(),
        '/cropping': (context) => CroppingPage(),
        '/add_crop': (context) => AddCropPage(),
        '/soil_data': (context) => SoilDataPage(),
        '/water_data': (context) => WaterDataPage(),
        '/analysis': (context) => AnalysisPage(),
        '/settings': (context) => SettingsPage(),
        '/login': (context) => LoginPage(),
        '/user_type_selection': (context) => UserTypeSelectionPage(),
        '/farmer_registration': (context) => FarmerRegistrationPage(),
        '/supervisor_registration': (context) => SupervisorRegistrationPage(),
        '/admin_registration': (context) => AdminRegistrationPage(),
        // Add more routes as needed
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppColors {
  static const primary = Color(0xFF4CAF50);
  static const primaryDark = Color(0xFF45a049);
  static const secondary = Color(0xFF2196F3);
  static const background = Color(0xFFF8F9FA);
  static const gradient1 = Color(0xFF667eea);
  static const gradient2 = Color(0xFF764ba2);
}

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  @override
  _MainAppPageState createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    DashboardPage(),
    LandDataPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'হোম'),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'ড্যাশবোর্ড',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'তথ্য'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'সেটিংস'),
        ],
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // Move your LandingPage code here
  @override
  Widget build(BuildContext context) {
    return Container(); // Replace with your LandingPage widget tree
  }
}

// LandDataPage is already imported from pages/land_data_page.dart

class LandDataDetailPage extends StatelessWidget {
  const LandDataDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
