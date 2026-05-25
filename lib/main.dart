import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/articulo_detalle_screen.dart';
import 'theme/app_theme.dart';
import 'models/review.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const FeedScreen(),    // 0: Explore (Feed)
      const HomeScreen(),    // 1: Home
      const ProfileScreen(), // 2: Profile
    ];

    return Scaffold(
      backgroundColor: CondorAppTheme.darkBg,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: _buildFloatingNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF242424),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, Icons.location_on, 'Explore'),
          _buildNavItem(1, Icons.calendar_today, 'Home', isActiveFilled: true),
          _buildNavItem(2, Icons.person_outline, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, {bool isActiveFilled = false}) {
    final isSelected = _currentIndex == index;
    
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: isSelected && isActiveFilled
            ? BoxDecoration(
                color: CondorAppTheme.filterIconBg,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 10,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Condor App',
      theme: CondorAppTheme.lightTheme(),
      darkTheme: CondorAppTheme.darkTheme(),
      themeMode: ThemeMode.light,
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainNavigationScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/articulo_detalle') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ArticuloDetalleScreen(
              articulo: args['articulo'],
              reviews: args['reviews'] != null ? List<Review>.from(args['reviews']) : <Review>[],
            ),
          );
        }
        return null;
      },
    );
  }
}
