import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m3ahed/About.dart';
import 'package:m3ahed/SignUp.dart';
import 'package:m3ahed/WebView.dart';
import 'package:m3ahed/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;
  bool _isObscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       automaticallyImplyLeading: false, 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info,),
            color: Colors.lightGreen,
            iconSize: 38.5,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(height: 100,),
        
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 2 / 3,
            
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       Image.asset("assets/images/m3ahed.png"),
                        Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            color: Color(0xff3C6255),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "تسجيل الدخول بحسابك ",
                          style: TextStyle(
                            color: Color(0xff61876E),
                          ),
                        ),
                        SizedBox(height: 30),
                        // Email
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يجب ادخال البريد الإليكتروني';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "البريد الإليكتروني",
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xff3C6255),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Password
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isObscurePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'ادخل كلمة المرور';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "كلمة المرور",
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff3C6255),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscurePassword = !_isObscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
            
                        //Remember Me
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (newValue) {
                                    setState(() {
                                      rememberMe = newValue!;
                                    });
                                  },
                                  activeColor: Color(0xff3C6255),
                                ),
                                Text(
                                  "تذكرني",
                                  style: TextStyle(
                                      color: Color(0xff3C6255),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                              ///ForgetPassword Page
                           },
                              child: Text(
                                'نسيت كلمة المرور!؟',
                                style: TextStyle(
                                  // fontSize: 16,
                                  color: Color(0xff3C6255),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Login Button
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              logIn();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF9CCCA7),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(100, 7, 100, 7),
                              child: Text(
                                '  دخول  ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        // Sign Up Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  ),
                                );
                              },
                              child: Text(
                                "إنشاء حساب جديد ..؟",
                                style: TextStyle(color: Color(0xff3C6255),fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "ليس لديك حساب؟ ",
                              style: TextStyle(color: Colors.black54),
                            ),
                           
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logIn() async {
    try {
     
      final response = await Dio().post(
        "https://api.escuelajs.co/api/v1/auth/login",
        data: {
          "email": _emailController.text,
          "password": _passwordController.text,
        },
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WebViewApp()),
      );
    } on DioError catch (e) {
      print("Login error: ${e.response}");
      if (e.response!.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid email or password!'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}