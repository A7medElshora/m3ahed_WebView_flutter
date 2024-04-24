
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'login.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentPage = 0;

  final List<String> _titles = [
    "تعلَم مهارات جديدة",
    "تسجيل الدخول",
    "الشهــادات",
  ];

  final List<String> _descriptions = [
    "يمكنك الآن دراسة كل الدورات التي تريدها\n دون الحاجة للسفر ",
    "يجب تسجيل الدخول أولا\n ليمكنك التصفح بأمان",
    "بعد انتهائكمن الدورة تكون جاهزا لدخول الامتحان النهائي للتقييم\nومن ثمَّ الحصول على الشهادة النهائية \n جميع الشهادات معتمدة من الجهات الرسمية ",
  ];

  final List<String> _lottieFiles = [
    'assets/images/welcome.json',
    'assets/images/login.json',
    'assets/images/cer.json',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _titles.length,
            itemBuilder: (context, index) {
              return _buildPage(index);
            },
          ),
          _buildSkipButton(),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
      _animationController.reset();
      _animationController.forward();
    });
  }

  Widget _buildPage(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: _buildLottieAnimation(index),
          ),
        ),
        SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: _buildTextContent(index),
        ),
      ],
    );
  }

  Widget _buildLottieAnimation(int index) {
    return Center(
      child: Lottie.asset(
        _lottieFiles[index],
        controller: index == 0 ? null : _animationController,
      ),
    );
  }

  Widget _buildTextContent(int index) {
    return Column(
      children: [
        Text(
          _titles[index],
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),
        Text(
          _descriptions[index],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _titles.length,
              (index) => Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? Colors.lightGreen : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                "تخطي",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
