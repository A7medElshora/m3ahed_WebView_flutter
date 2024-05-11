import 'dart:async';
import 'package:flutter/material.dart';
import 'package:m3ahed/About.dart';
import 'package:m3ahed/galleryPages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:m3ahed/faq_screen.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final WebViewController controller;
  var loadingPercentage = 0;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setBackgroundColor(const Color(0x00000000))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse('https://m3ahd.com/'),
      );
  }

  Future<void> _refresh() async {
    await controller.reload();
  }

  Future<bool> _onWillPop() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return false; // Stay in app
    } else {
      // Exiting the app
      DateTime now = DateTime.now();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final storedTime = prefs.getInt('lastBackPressTime') ?? 0;
      if (now.millisecondsSinceEpoch - storedTime > 3000) {
        prefs.setInt('lastBackPressTime', now.millisecondsSinceEpoch);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
            padding: EdgeInsets.only(right: 25),
            child: Text(
              'اضغط مجدداََ للخروج',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          duration: Duration(seconds: 2),
        ));
        return false; // Stay in app
      }
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
                        ListTile(
                          leading: Icon(Icons.info_outline_rounded,color: Colors.green),
                          title: Container(padding: EdgeInsets.all(10),child: Text('عــنـا',style: TextStyle(color: Colors.blueGrey,fontSize: 18,fontWeight: FontWeight.bold),),),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => AboutPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.question_mark_outlined,color: Colors.green,),
                          title: Container(padding: EdgeInsets.all(10),child: Text('FAQ',style: TextStyle(color: Colors.blueGrey,fontSize: 18,fontWeight: FontWeight.bold),),),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => FAQScreen()),);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.question_mark_outlined,color: Colors.green,),
                          title: Container(padding: EdgeInsets.all(10),child: Text('معرض الصور',style: TextStyle(color: Colors.blueGrey,fontSize: 18,fontWeight: FontWeight.bold),),),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Gallery()),);
                          },
                        ),


                        // ListTile(
                        //   leading: Icon(Icons.screen_share),
                        //   title: Text('Screen 4'),
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //     // Navigate to Screen 4
                        //   },
                        // ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () => _refresh(),
              icon: Icon(Icons.refresh_outlined, color: Colors.greenAccent),
            ),
          ],
        ),
        body: Stack(
          children: [
            RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refresh,
              child: WebViewWidget(
                controller: controller,
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

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class Home extends StatefulWidget {
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   late final WebViewController controller;
//   var loadingPercentage = 0;
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(NavigationDelegate(
//         onPageStarted: (url) {
//           setState(() {
//             loadingPercentage = 0;
//           });
//         },
//         onProgress: (progress) {
//           setState(() {
//             loadingPercentage = progress;
//           });
//         },
//         onPageFinished: (url) {
//           setState(() {
//             loadingPercentage = 100;
//           });
//         },
//       ))
//       ..loadRequest(
//         Uri.parse('https://m3ahd.com/'),
//       );
//   }
//
//   Future<void> _refresh() async {
//     await controller.reload();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (await controller.canGoBack()) {
//           controller.goBack();
//           return false; // Stay in app
//         } else {
//           return true; // Leave app
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color(0xff292931),
//           leading: IconButton(
//             icon: Icon(Icons.menu, color: Colors.greenAccent),
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return Container(
//                     child: Wrap(
//                       children: <Widget>[
//                         ListTile(
//                           leading: Icon(Icons.screen_share),
//                           title: Text('Screen 1'),
//                           onTap: () {
//                             Navigator.pop(context);
//                             // Navigate to Screen 1
//                           },
//                         ),
//                         ListTile(
//                           leading: Icon(Icons.screen_share),
//                           title: Text('Screen 2'),
//                           onTap: () {
//                             Navigator.pop(context);
//                             // Navigate to Screen 2
//                           },
//                         ),
//                         ListTile(
//                           leading: Icon(Icons.screen_share),
//                           title: Text('Screen 3'),
//                           onTap: () {
//                             Navigator.pop(context);
//                             // Navigate to Screen 3
//                           },
//                         ),
//                         ListTile(
//                           leading: Icon(Icons.screen_share),
//                           title: Text('Screen 4'),
//                           onTap: () {
//                             Navigator.pop(context);
//                             // Navigate to Screen 4
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           actions: [
//             IconButton(
//               onPressed: () => _refresh(),
//               icon: Icon(Icons.refresh_outlined, color: Colors.greenAccent),
//             ),
//           ],
//         ),
//         body: Stack(
//           children: [
//             RefreshIndicator(
//               key: _refreshIndicatorKey,
//               onRefresh: _refresh,
//               child: WebViewWidget(
//                 controller: controller,
//               ),
//             ),
//             if (loadingPercentage < 100)
//               LinearProgressIndicator(
//                 value: loadingPercentage / 100.0,
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// leading: PopupMenuButton(
// itemBuilder: (BuildContext context) {
// return [
// PopupMenuItem(
// child: Text('Menu'),
// value: 'menu',
// ),
// ];
// },
// onSelected: (value) {
// if (value == 'menu') {
// showModalBottomSheet(
// context: context,
// builder: (BuildContext context) {
// return Container(
// child: Wrap(
// children: <Widget>[
// ListTile(
// leading: Icon(Icons.screen_share),
// title: Text('Screen 1'),
// onTap: () {
// Navigator.pop(context);
// // Navigate to Screen 1
// },
// ),
// ListTile(
// leading: Icon(Icons.screen_share),
// title: Text('Screen 2'),
// onTap: () {
// Navigator.pop(context);
// // Navigate to Screen 2
// },
// ),
// ListTile(
// leading: Icon(Icons.screen_share),
// title: Text('Screen 3'),
// onTap: () {
// Navigator.pop(context);
// // Navigate to Screen 3
// },
// ),
// ListTile(
// leading: Icon(Icons.screen_share),
// title: Text('Screen 4'),
// onTap: () {
// Navigator.pop(context);
// // Navigate to Screen 4
// },
// ),
// ],
// ),
// );
// },
// );
// }
// },
// icon: Icon(Icons.menu, color: Colors.greenAccent),
// ),

//
//
// class Search extends StatefulWidget {
//   @override
//   State<Search> createState() => _SearchState();
// }
//
// class _SearchState extends State<Search> {
//   late final WebViewController controller;
//   var loadingPercentage = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(NavigationDelegate(
//         onPageStarted: (url) {
//           setState(() {
//             loadingPercentage = 0;
//           });
//         },
//         onProgress: (progress) {
//           setState(() {
//             loadingPercentage = progress;
//           });
//         },
//         onPageFinished: (url) {
//           setState(() {
//             loadingPercentage = 100;
//           });
//         },
//       ))
//
//       ..loadRequest(
//         Uri.parse('https://m3ahd.com/cart/'),
//       );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (await controller.canGoBack()) {
//           controller.goBack();
//
//           ///Stay in app
//           return false;
//         } else {
//           ///Leave App
//           return true;
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color(0xff292931),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_sharp,color: Colors.greenAccent,),
//             onPressed: () async {
//               if (await controller.canGoBack()) {
//                 controller.goBack();
//               }
//             },
//           ),
//           actions: [
//             IconButton(
//               onPressed: () => controller.reload(),
//               icon: Icon(Icons.refresh_outlined,color: Colors.greenAccent,),
//             ),
//           ],
//         ),
//         body:Stack(
//           children: [
//             WebViewWidget(
//               controller: controller,
//             ),
//             if (loadingPercentage < 100)
//               LinearProgressIndicator(
//                 value: loadingPercentage / 100.0,
//
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
// class Cart extends StatefulWidget {
//   @override
//   State<Cart> createState() => _CartState();
// }
//
// class _CartState extends State<Cart> {
//   late final WebViewController controller;
//   var loadingPercentage = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//
//       ..setNavigationDelegate(NavigationDelegate(
//         onPageStarted: (url) {
//           setState(() {
//             loadingPercentage = 0;
//           });
//         },
//         onProgress: (progress) {
//           setState(() {
//             loadingPercentage = progress;
//           });
//         },
//         onPageFinished: (url) {
//           setState(() {
//             loadingPercentage = 100;
//           });
//         },
//       ))
//
//       ..loadRequest(
//         Uri.parse('https://m3ahd.com/cart/'),
//       );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (await controller.canGoBack()) {
//           controller.goBack();
//
//           ///Stay in app
//           return false;
//         } else {
//           ///Leave App
//           return true;
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//
//           backgroundColor: Color(0xff292931),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_sharp,color: Colors.greenAccent,),
//             onPressed: () async {
//               if (await controller.canGoBack()) {
//                 controller.goBack();
//               }
//             },
//           ),
//           actions: [
//             IconButton(
//               onPressed: () => controller.reload(),
//               icon: Icon(Icons.refresh_outlined,color: Colors.greenAccent,),
//             ),
//           ],
//         ),
//         body: Stack(
//           children: [
//             WebViewWidget(
//               controller: controller,
//             ),
//             if (loadingPercentage < 100)
//               LinearProgressIndicator(
//                 value: loadingPercentage / 100.0,
//
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class Account extends StatefulWidget {
//   @override
//   State<Account> createState() => _AccountState();
// }
//
// class _AccountState extends State<Account> {
//   late final WebViewController controller;
//   var loadingPercentage = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(NavigationDelegate(
//         onPageStarted: (url) {
//           setState(() {
//             loadingPercentage = 0;
//           });
//         },
//         onProgress: (progress) {
//           setState(() {
//             loadingPercentage = progress;
//           });
//         },
//         onPageFinished: (url) {
//           setState(() {
//             loadingPercentage = 100;
//           });
//         },
//       ))
//
//       ..loadRequest(
//         Uri.parse('https://m3ahd.com/my-account/'),
//       );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (await controller.canGoBack()) {
//           controller.goBack();
//
//           ///Stay in app
//           return false;
//         } else {
//           ///Leave App
//           return true;
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//
//           backgroundColor: Color(0xff292931),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_sharp,color: Colors.greenAccent,),
//             onPressed: () async {
//               if (await controller.canGoBack()) {
//                 controller.goBack();
//               }
//             },
//           ),
//           actions: [
//             IconButton(
//               onPressed: () => controller.reload(),
//               icon: Icon(Icons.refresh_outlined,color: Colors.greenAccent,),
//             ),
//           ],
//         ),
//         body: Stack(
//           children: [
//             WebViewWidget(
//               controller: controller,
//             ),
//             if (loadingPercentage < 100)
//               LinearProgressIndicator(
//                 value: loadingPercentage / 100.0,
//
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
// class Courses extends StatefulWidget {
//   @override
//   State<Courses> createState() => _CoursesState();
// }
//
// class _CoursesState extends State<Courses> {
//   late final WebViewController controller;
//   var loadingPercentage = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(NavigationDelegate(
//         onPageStarted: (url) {
//           setState(() {
//             loadingPercentage = 0;
//           });
//         },
//         onProgress: (progress) {
//           setState(() {
//             loadingPercentage = progress;
//           });
//         },
//         onPageFinished: (url) {
//           setState(() {
//             loadingPercentage = 100;
//           });
//         },
//       ))
//
//       ..loadRequest(
//         Uri.parse('https://m3ahd.com/course-categories/'),
//       );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (await controller.canGoBack()) {
//           controller.goBack();
//
//           ///Stay in app
//           return false;
//         } else {
//           ///Leave App
//           return true;
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//
//
//           backgroundColor: Color(0xff292931),
//
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_sharp,color: Colors.greenAccent,),
//             onPressed: () async {
//               if (await controller.canGoBack()) {
//                 controller.goBack();
//               }
//             },
//           ),
//           actions: [
//             IconButton(
//               onPressed: () => controller.reload(),
//               icon: Icon(Icons.refresh_outlined,color: Colors.green,),
//             ),
//           ],
//         ),
//         body: Stack(
//           children: [
//             WebViewWidget(
//               controller: controller,
//             ),
//             if (loadingPercentage < 100)
//               LinearProgressIndicator(
//                 value: loadingPercentage / 100.0,
//
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
