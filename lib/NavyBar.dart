import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:m3ahed/About.dart';
import 'WebView.dart';


class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _currentIndex = 4;

  final List<Widget> _screens = [
    AboutPage(),
    Cart(),
    Account(),
    Courses(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.white,
        color: Colors.green,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          Icon(Icons.info_outline, size: 30),
          Icon(Icons.shopping_cart, size: 30),
          Icon(Icons.person, size: 30),
          Icon(Icons.apps, size: 30),
          Icon(Icons.home, size: 30),
        ],
      ),
    );
  }
}
