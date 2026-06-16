import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/culture_page.dart';
import 'pages/inheritor_page.dart';
import 'pages/interactive_page.dart';
import 'pages/about_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  String _cultureQuery = '';

  void _onTabChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _openCultureSearch(String query) {
    setState(() {
      _cultureQuery = query.trim();
      _currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '云南非遗文化',
      theme: ThemeData(
        primaryColor: const Color(0xFF8B4513),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B4513),
          primary: const Color(0xFF8B4513),
          secondary: const Color(0xFFB7462A),
          surface: const Color(0xFFFFFCF5),
        ),
        fontFamily: 'PingFang SC, Microsoft YaHei, STKaiti, serif',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F1E5),
        cardTheme: const CardThemeData(color: Color(0xFFFFFCF5), elevation: 0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF55291C),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF9C3F26),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFFFCF5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFD9C09B)),
          ),
        ),
      ),
      home: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          final pages = <Widget>[
            HomePage(onTabChange: _onTabChange, onSearch: _openCultureSearch),
            CulturePage(
              key: ValueKey(_cultureQuery),
              initialQuery: _cultureQuery,
            ),
            const InheritorPage(),
            const InteractivePage(),
            const AboutPage(),
          ];

          return Scaffold(
            body: Row(
              children: [
                if (isWide) _buildNavigationRail(),
                Expanded(child: pages[_currentIndex]),
              ],
            ),
            bottomNavigationBar: isWide ? null : _buildBottomNavigationBar(),
          );
        },
      ),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: _currentIndex,
      onDestinationSelected: _onTabChange,
      extended: true,
      minExtendedWidth: 210,
      backgroundColor: Colors.white,
      selectedIconTheme: const IconThemeData(color: Color(0xFF8B4513)),
      selectedLabelTextStyle: const TextStyle(
        color: Color(0xFF8B4513),
        fontWeight: FontWeight.bold,
      ),
      leading: const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Icon(Icons.castle, color: Color(0xFF8B4513), size: 40),
            SizedBox(height: 8),
            Text(
              '云南非遗',
              style: TextStyle(
                color: Color(0xFF5D3A1A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'STKaiti',
              ),
            ),
          ],
        ),
      ),
      destinations: const [
        NavigationRailDestination(icon: Icon(Icons.home), label: Text('首页')),
        NavigationRailDestination(
          icon: Icon(Icons.collections),
          label: Text('非遗项目'),
        ),
        NavigationRailDestination(icon: Icon(Icons.person), label: Text('传承人')),
        NavigationRailDestination(
          icon: Icon(Icons.gamepad),
          label: Text('互动体验'),
        ),
        NavigationRailDestination(icon: Icon(Icons.info), label: Text('关于我们')),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabChange,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFE65100),
        unselectedItemColor: Colors.grey[500],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 24,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.collections), label: '非遗项目'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '传承人'),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: '互动体验'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: '关于我们'),
        ],
      ),
    );
  }
}
