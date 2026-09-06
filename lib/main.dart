import 'package:flutter/material.dart';
import 'ui/theme/lcars_theme.dart';
import 'ui/screens/map_screen.dart';
import 'ui/screens/bucket_list_screen.dart';
import 'ui/screens/route_solver_screen.dart';
import 'ui/screens/solar_ar_screen.dart';
import 'ui/screens/school_trip_screen.dart';

void main() {
  runApp(const PhotoTrekFlutterApp());
}

class PhotoTrekFlutterApp extends StatelessWidget {
  const PhotoTrekFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhotoTrek Journey',
      debugShowCheckedModeBanner: false,
      theme: LcarsTheme.themeData,
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    MapScreen(),
    BucketListScreen(),
    RouteSolverScreen(),
    SolarArScreen(),
    SchoolTripScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        backgroundColor: LcarsTheme.surfaceDark,
        indicatorColor: LcarsTheme.amberPrimary.withValues(alpha: 0.3),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'Map'),
          NavigationDestination(icon: Icon(Icons.checklist_outlined), selectedIcon: Icon(Icons.checklist), label: 'Bucket List'),
          NavigationDestination(icon: Icon(Icons.alt_route_outlined), selectedIcon: Icon(Icons.alt_route), label: 'VRP Solver'),
          NavigationDestination(icon: Icon(Icons.wb_sunny_outlined), selectedIcon: Icon(Icons.wb_sunny), label: 'Solar HUD'),
          NavigationDestination(icon: Icon(Icons.directions_bus_outlined), selectedIcon: Icon(Icons.directions_bus), label: 'Field Trip'),
        ],
      ),
    );
  }
}
