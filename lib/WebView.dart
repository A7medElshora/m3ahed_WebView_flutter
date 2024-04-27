import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setBackgroundColor(const Color(0x00000000))
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false; // Stay in app
        } else {
          return true; // Leave app
        }
      },
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Color(0xff292931),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp, color: Colors.greenAccent),
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              }
            },
          ),
          actions: [
            IconButton(
              onPressed: () => controller.reload(),
              icon: Icon(Icons.refresh_outlined, color: Colors.greenAccent),
            ),
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
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





class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late final WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setBackgroundColor(const Color(0x00000000))
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
        Uri.parse('https://m3ahd.com/cart/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();

          ///Stay in app
          return false;
        } else {
          ///Leave App
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff292931),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp,color: Colors.greenAccent,),
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              }
            },
          ),
          actions: [
            IconButton(
              onPressed: () => controller.reload(),
              icon: Icon(Icons.refresh_outlined,color: Colors.greenAccent,),
            ),
          ],
        ),
        body:Stack(
          children: [
            WebViewWidget(
              controller: controller,
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





class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late final WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setBackgroundColor(const Color(0x00000000))
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
        Uri.parse('https://m3ahd.com/cart/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();

          ///Stay in app
          return false;
        } else {
          ///Leave App
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Color(0xff292931),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp,color: Colors.greenAccent,),
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              }
            },
          ),
          actions: [
            IconButton(
              onPressed: () => controller.reload(),
              icon: Icon(Icons.refresh_outlined,color: Colors.greenAccent,),
            ),
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
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



class Account extends StatefulWidget {
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late final WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setBackgroundColor(const Color(0x00000000))
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
        Uri.parse('https://m3ahd.com/my-account/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();

          ///Stay in app
          return false;
        } else {
          ///Leave App
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Color(0xff292931),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp,color: Colors.greenAccent,),
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              }
            },
          ),
          actions: [
            IconButton(
              onPressed: () => controller.reload(),
              icon: Icon(Icons.refresh_outlined,color: Colors.greenAccent,),
            ),
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
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




class Courses extends StatefulWidget {
  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  late final WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setBackgroundColor(const Color(0x00000000))
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
        Uri.parse('https://m3ahd.com/course-categories/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();

          ///Stay in app
          return false;
        } else {
          ///Leave App
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(


          backgroundColor: Color(0xff292931),

          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp,color: Colors.greenAccent,),
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              }
            },
          ),
          actions: [
            IconButton(
              onPressed: () => controller.reload(),
              icon: Icon(Icons.refresh_outlined,color: Colors.green,),
            ),
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
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
