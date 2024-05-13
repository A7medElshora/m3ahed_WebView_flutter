import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:m3ahed/Notification_screen.dart';
import 'package:m3ahed/Splash.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:m3ahed/conections.dart';
import 'package:m3ahed/firebase_api.dart';
import 'package:m3ahed/firebase_options.dart'; // Import kReleaseMode

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifivations();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Use kReleaseMode here
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isConnected;

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: DevicePreview.appBuilder(context, child), // Use DevicePreview
        );
      },
      navigatorKey: navigatorKey,
      home: isConnected ? SplashScreen() : NoConnectionPage(),
      routes: {
        '/splash_screen': (context) =>  SplashScreen(),
      },
    );
  }
}
