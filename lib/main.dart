import 'package:flutter/material.dart';
import 'package:m3ahed/Login.dart';
import 'package:m3ahed/Splash.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(), 
              '/login':(context)=> LoginPage(),
              }
    );
  }
}
