import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('معاهــد.كـــوم'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'assets/images/m3ahed.png',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            FadeTransition(
              opacity: _animation,
              child: Text(
                'معاهــد.كـــوم',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            FadeTransition(
              opacity: _animation,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 9, 0),
                child: Text(
                  textAlign: TextAlign.right,
                  'موقع معاهد.كوم هو موقع يوفر لك تعلُم ودراسة كلالمجالات التي تحبها ولديك شغف فى دراستها\n على يد باقة من افضل المدرسين والناهج العلمية الحديثة والمُطَورة باستمرار \n معنا يمكنك دراسة البرمجة من الصفر ولا يُشترط ان تكون قد سبق ودرستها فى الجامعه مثلا \n فنحن نتولى تأهيلك من جديد تمامََا \n أما بالنسبة للتخصصات فلدينا جميع التخصصات المطلوبة فى سوق العمل نأهلك تأهيل تام لتكون على دراية واسعة بسوقالعمل وكيف يمكنك الحصول على فرصة عمل بسرعة والتفوق على منافسيك \n والشهادات التي يحصل عليها الطلاب بعد اتمام الدورات شهادات معتمدة بالكامل معترف بها دوليا ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AboutPage(),
  ));
}
