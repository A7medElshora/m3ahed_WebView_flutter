import 'package:flutter/material.dart';
import 'package:m3ahed/About.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://m3ahd.com/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      //     appBar: AppBar(
      //       backgroundColor: Color(0xFF292931),
      //  automaticallyImplyLeading: false,
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.info,),
      //       color: Colors.lightGreen,
      //       iconSize: 38.5,
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => AboutPage()),
      //         );
      //       },
      //     ),
      //   ],
      // ),

        body: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}

