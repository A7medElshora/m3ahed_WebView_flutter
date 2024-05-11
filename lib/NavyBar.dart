// import 'package:flutter/material.dart';
// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:m3ahed/About.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'WebView.dart';
//
// class NavScreen extends StatefulWidget {
//   @override
//   _NavScreenState createState() => _NavScreenState();
// }
//
// class _NavScreenState extends State<NavScreen> {
//   int _currentIndex = 0;
//   late SharedPreferences _prefs;
//
//   final List<Widget> _screens = [
//     Home(),
//     Courses(),
//     Account(),
//     Cart(),
//     AboutPage(),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCurrentIndex();
//   }
//
//   Future<void> _loadCurrentIndex() async {
//     _prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _currentIndex = _prefs.getInt('currentIndex') ?? 0;
//     });
//   }
//
//   Future<void> _saveCurrentIndex(int index) async {
//     await _prefs.setInt('currentIndex', index);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomNavyBar(
//         selectedIndex: _currentIndex,
//         backgroundColor: Colors.green,
//         showElevation: true, // use this to hide shadow
//         itemCornerRadius: 24,
//         curve: Curves.easeIn,
//         onItemSelected: (int index) {
//           setState(() {
//             _currentIndex = index;
//             _saveCurrentIndex(index); // Save the current index
//           });
//         },
//         items: [
//           BottomNavyBarItem(
//             icon: Icon(Icons.home),
//             title: Text('الرئيسية'),
//             activeColor: Colors.white,
//             inactiveColor: Colors.white,
//           ),
//           BottomNavyBarItem(
//             icon: Icon(Icons.apps),
//             title: Text('فئـات'),
//             activeColor: Colors.white,
//             inactiveColor: Colors.white,
//           ),
//           BottomNavyBarItem(
//             icon: Icon(Icons.person),
//             title: Text('حســابي'),
//             activeColor: Colors.white,
//             inactiveColor: Colors.white,
//           ),
//           BottomNavyBarItem(
//             icon: Icon(Icons.shopping_cart),
//             title: Text('سلة التسوق '),
//             activeColor: Colors.white,
//             inactiveColor: Colors.white,
//           ),
//           BottomNavyBarItem(
//             icon: Icon(Icons.info_outline),
//             title: Text('عــنا'),
//             activeColor: Colors.white,
//             inactiveColor: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }
