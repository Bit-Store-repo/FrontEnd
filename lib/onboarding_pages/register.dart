import 'dart:convert';

import 'package:bit_store/onboarding_pages/verifyMail.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool emailFlag = false;
  String errMsg = "";

  Future<http.Response> register(String email, String password) async {
    return http.post(
      Uri.parse('http://localhost:3000/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{'email': email, 'password': password}),
    );
  }

  Future<http.Response> verify(String email) async {
    return http.post(
      Uri.parse('http://localhost:3000/user/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{'email': email}),
    );
  }

  void cacheData(dynamic value) async {
    Box data = await Hive.openBox('passwordData');
    data.put('myData', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/onboard_images/main_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 80, 35, 40),
            child: Column(
              children: [
                Row(
                  children: [Image.asset('assets/logo.png')],
                ),
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Join Us!',
                  style: TextStyle(
                      fontFamily: 'gilroy',
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(77, 77, 77, 1)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Securely store and access data',
                  style: TextStyle(
                      fontFamily: 'gilroy',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(104, 104, 104, 1)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(252, 218, 221, 1),
                        Color.fromRGBO(254, 228, 217, 1)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Image.asset(
                          'assets/icons/user.png',
                          color: Color.fromRGBO(77, 77, 77, 1),
                        ),
                        label: Text(
                          'Email',
                          style: TextStyle(
                              fontFamily: 'gilroy',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromRGBO(77, 77, 77, 1)),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(252, 218, 221, 1),
                        Color.fromRGBO(254, 228, 217, 1)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Image.asset(
                          'assets/icons/password.png',
                          color: Color.fromRGBO(77, 77, 77, 1),
                        ),
                        label: Text(
                          'Password',
                          style: TextStyle(
                              fontFamily: 'gilroy',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromRGBO(77, 77, 77, 1)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'There are no terms and policies!',
                    style: TextStyle(
                      color: Color.fromRGBO(77, 77, 77, 1),
                      fontSize: 16,
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (emailFlag) ...[
                  SizedBox(
                    height: 0,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '${errMsg}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontFamily: 'gilroy',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    String email = emailController.text;
                    String password = passwordController.text;

                    if (email.isEmpty) {
                      setState(() {
                        emailController.text = email;
                        passwordController.text = password;
                        emailFlag = true;
                        errMsg = "Email cannot be empty";
                      });
                    } else if (email.contains("@") == false ||
                        email.contains(".") == false) {
                      setState(() {
                        emailController.text = email;
                        passwordController.text = password;
                        emailFlag = true;
                        errMsg = "Invalid Email";
                      });
                    } else if (password.isEmpty || password.length < 8) {
                      setState(() {
                        emailController.text = email;
                        passwordController.text = password;
                        emailFlag = true;
                        if (password.isEmpty) {
                          errMsg = "Password cannot be empty";
                        } else {
                          errMsg = "Password needs min 8 characters";
                        }
                      });
                    } else {
                      http.Response response = await register(email, password);
                      Map res = json.decode(response.body);

                      if (res.containsKey('message')) {
                        setState(() {
                          emailController.text = email;
                          passwordController.text = password;
                          emailFlag = true;
                          errMsg = res['message'];
                        });
                      } else {
                        await verify(email);
                        List root = ['root', '', ''];
                        cacheData(root);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => verifyMail(
                                    emailData: res,
                                    type: "login",
                                  )),
                        );
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(180, 231, 229, 1),
                          Color.fromRGBO(180, 248, 200, 1)
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                      child: Center(
                        child: Text(
                          'Join Bit Store',
                          style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Color.fromRGBO(22, 22, 22, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/Line.png'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'or',
                      style: TextStyle(
                        fontFamily: 'gilroy',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color.fromRGBO(22, 22, 22, 1),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset('assets/icons/Line.png'),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Already have an account ?',
                  style: TextStyle(
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromRGBO(104, 104, 104, 1)),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'gilroy',
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(22, 22, 22, 1),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                ),
              ],
            ),
          )),
    );
  }
}
