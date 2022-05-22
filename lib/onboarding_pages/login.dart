import 'dart:convert';

import 'package:bit_store/home_screens/homeScreen.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  Future<http.Response> login(String email, String password) async {
    return http.post(
      Uri.parse('https://bit-store-backend.herokuapp.com/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{'email': email, 'password': password}),
    );
  }

  void loginRouter() async {
    Box user = await Hive.openBox('Login');

    user.put('loggedIn', 'true');
  }

  void cacheData(dynamic value) async {
    Box data = await Hive.openBox('passwordData');
    data.put('myData', value);
  }

  void cacheUserData(dynamic value, String pass) async {
    Box data = await Hive.openBox('userData');
    Box password = await Hive.openBox('userPassword');
    data.put('user', value);
    password.put('password', pass);
  }

  Future<http.Response> getData(String key) async {
    return http.get(
      Uri.parse('https://bit-store-blockchain.herokuapp.com/chain/${key}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color.fromRGBO(22, 22, 22, 1),
          shape: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Color.fromRGBO(22, 22, 22, 1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool emailFlag = false;
  String errMsg = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [Image.asset('assets/logo.png')],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Hello Again',
                    style: TextStyle(
                        fontFamily: 'gilroy',
                        fontSize: 45,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(60, 60, 60, 1)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Login to access your data',
                    style: TextStyle(
                        fontFamily: 'gilroy',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(104, 104, 104, 1)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 51,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14)),
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
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Color.fromRGBO(77, 77, 77, 1),
                          ),
                          border: InputBorder.none,
                          icon: Image.asset(
                            'assets/icons/user.png',
                            color: Color.fromRGBO(77, 77, 77, 1),
                            height: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 51,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14)),
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
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Color.fromRGBO(77, 77, 77, 1),
                          ),
                          border: InputBorder.none,
                          icon: Image.asset(
                            'assets/icons/password.png',
                            color: Color.fromRGBO(77, 77, 77, 1),
                            height: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (emailFlag) ...[
                    SizedBox(
                      height: 10,
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
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Color.fromRGBO(77, 77, 77, 1),
                        fontSize: 16,
                        fontFamily: 'gilroy',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () async {
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
                        // put the loading screen
                        _onLoading();

                        http.Response response = await login(email, password);
                        Map res = json.decode(response.body);

                        if (res.containsKey('message')) {
                          Navigator.pop(context);
                          setState(() {
                            emailController.text = email;
                            passwordController.text = password;
                            emailFlag = true;
                            errMsg = res['message'];
                          });
                        } else {
                          http.Response passwordData =
                              await getData(res['key']);
                          Map myData = json.decode(passwordData.body);

                          final key = encrypt.Key.fromUtf8(sha256
                              .convert(utf8.encode(password))
                              .toString()
                              .substring(0, 16));
                          final iv = encrypt.IV.fromLength(8);
                          final encrypter = encrypt.Encrypter(encrypt.AES(key));

                          String decryptAES(String base64Text) {
                            String decrypted = encrypter.decrypt(
                                encrypt.Encrypted.fromBase64(base64Text),
                                iv: iv);
                            return decrypted;
                          }

                          if (myData.containsKey('message')) {
                            List root = ['root', '', ''];
                            cacheData(root);
                            loginRouter();
                            cacheUserData(res, password);
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => homeScreen()),
                            );
                          } else {
                            String decrypted = decryptAES(myData['data']);
                            List decData = json.decode(decrypted);
                            cacheData(decData);
                            cacheUserData(res, password);
                            loginRouter();
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => homeScreen()),
                            );
                          }
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'gilroy',
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(22, 22, 22, 1),
                        minimumSize: const Size.fromHeight(44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        )),
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
                    'New to Bit Store ?',
                    style: TextStyle(
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromRGBO(104, 104, 104, 1),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'register');
                    },
                    child: Container(
                      height: 44,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(14),
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
                              fontSize: 19,
                              color: Color.fromRGBO(22, 22, 22, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
