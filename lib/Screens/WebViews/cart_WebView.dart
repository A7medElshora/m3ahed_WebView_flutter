import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m3ahed/About.dart';
import 'package:m3ahed/Screens/WebViews/Acount_WebView.dart';
import 'package:m3ahed/Screens/WebViews/Categories_WebView.dart';
import 'package:m3ahed/Screens/WebViews/Home_WebView.dart';
import 'package:m3ahed/galleryPages.dart';
import 'package:m3ahed/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:m3ahed/faq_screen.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> with WidgetsBindingObserver {
  late final WebViewController controller;
  var loadingPercentage = 0;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  late DragGesturePullToRefresh dragGesturePullToRefresh;

  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    controller = WebViewController() // Initialize controller first
      ..setBackgroundColor(const Color(0x00000000))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            dragGesturePullToRefresh.started();
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (String url) {
            dragGesturePullToRefresh.finished();
            setState(() {
              loadingPercentage = 100;
            });
          },
          onWebResourceError: (WebResourceError error) {
            dragGesturePullToRefresh.finished();
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://m3ahd.com/cart/'),
      );

    dragGesturePullToRefresh =
        DragGesturePullToRefresh(3000, 10)
            .setController(controller)
            .setDragHeightEnd(200)
            .setDragStartYDiff(10)
            .setWaitToRestart(3000);

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    dragGesturePullToRefresh.setDragHeightEnd(MediaQuery.of(context).size.height);
  }

  Future<void> _refresh() async {
    await controller.reload();
  }

  Future<bool> _onWillPop() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return false; // Stay in app
    } else {
      return true; // Leave app
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff292931),
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.greenAccent),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: Wrap(
                      children: <Widget>[
                        ///Home
                        ListTile(
                          leading: Icon(Icons.home_outlined,color: Colors.green,),
                          title: Container(padding: EdgeInsets.all(10),child: Text('الرئـيسـية',style: TextStyle(color: Colors.blueGrey,fontSize: 18,fontWeight: FontWeight.bold),),),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Home()),);
                          },
                        ),
                        ///Category
                        ListTile(
                          leading: Icon(Icons.category_outlined,
                              color: Colors.green),
                          title: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'فـئـات',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Categories()),
                            );
                          },
                        ),
                        ///Account
                        ListTile(
                          leading: Icon(Icons.shopping_cart,
                              color: Colors.green),
                          title: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'حـسـابى',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Acount()),
                            );
                          },
                        ),
                        ///About
                        ListTile(
                          leading: Icon(Icons.info_outline_rounded,
                              color: Colors.green),
                          title: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'عــنـا',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => AboutPage()),
                            );
                          },
                        ),
                        ///Faq
                        ListTile(
                          leading: Icon(Icons.question_mark_outlined,
                              color: Colors.green),
                          title: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'FAQ',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => FAQScreen()),
                            );
                          },
                        ),
                        ///Gallery
                        ListTile(
                          leading: Icon(Icons.browse_gallery_outlined,
                              color: Colors.green),
                          title: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'معرض الصور',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Gallery()),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () => _onWillPop(), // Call _onWillPop for go back
              icon: Icon(Icons.arrow_circle_left, color: Colors.greenAccent), // Change icon to arrow_back
            ),
          ],
        ),
        body: Stack(
          children: [
            RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refresh,
              child: Builder(
                builder: (context) {
                  dragGesturePullToRefresh.setContext(context);
                  return WebViewWidget(
                    controller: controller,
                    gestureRecognizers: {Factory(() => dragGesturePullToRefresh)},
                  );
                },
              ),
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              ),


          ],
        ),
      ),
    );
  }
}