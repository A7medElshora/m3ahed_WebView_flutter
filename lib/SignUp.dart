import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m3ahed/About.dart';
import 'package:m3ahed/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
          SizedBox(
            height: 100,
          ),
         

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 150,),
                       Image.asset("assets/images/m3ahed.png"),
                    SizedBox(height: 20,),
                      Text(
                        "إنشاء حساب جديد",
                        style: TextStyle(
                          color: Color(0xff3C6255),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      //Full Name
                      TextFormField(
                        controller: _fullNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلكادخل الاسم بالكامل ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "الاسم",
                          filled: true,
                          fillColor: Colors.grey[200],
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xff3C6255),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      //Email
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلكادخلالبريد الإليتروني ';
                          }
                          // You can add more complex email validation logic here
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "البريد الإلكتروني",
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

                      //Phone
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Phone';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "الهاتف",
                          filled: true,
                          fillColor: Colors.grey[200],
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color(0xff3C6255),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isObscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخلكلمة المرور';
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
                      SizedBox(height: 20),
                      //Confirm Password
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _isObscureConfirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك اعد كتابة كلمة المرور كما هي';
                          }
                          if (value != _passwordController.text) {
                            return 'كلمتا المرور غير متطابقتان';
                          }
                          return null;
                        },
                        
                        decoration: InputDecoration(
                          labelText: "تأكيد كلمة المرور",
                          filled: true,
                          fillColor: Colors.grey[200],
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff3C6255),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscureConfirmPassword =
                                    !_isObscureConfirmPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Log_in(context); 
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF9CCCA7),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(100, 7, 100, 7),
                            child: Text(
                              'تسجـيـل',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "دخول",
                                  style: TextStyle(
                                      color: Color(0xff3C6255),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "لديك حساب!؟",
                                style: TextStyle(color: Colors.black54),
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                                        ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void Log_in(BuildContext context) async {
    try {
      
      final response = await Dio().post(
        "https://api.escuelajs.co/api/v1/users/",
        data: {
          "name": _fullNameController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
          "avatar": "https://api.lorem.space/image/face?w=640&h=480"
        },
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('fullName', _fullNameController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on DioError catch (e) {
      print("Registration error: ${e.response}");
      if (e.response!.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid email or password!'),
          backgroundColor: Colors.red,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print("Unexpected error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An unexpected error occurred. Please try again later.'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
