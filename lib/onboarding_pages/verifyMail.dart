import 'dart:convert';

import 'package:bit_store/home_screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class verifyMail extends StatefulWidget {
  const verifyMail({Key? key, required this.emailData, required this.type})
      : super(key: key);

  final Map emailData;
  final String type;

  @override
  _verifyMailState createState() => _verifyMailState();
}

class _verifyMailState extends State<verifyMail> {
  TextEditingController otpController = TextEditingController();
  int seconds = 1;
  // String email = widget.emailData['email'];

  // a flag that triggers wrong otp message
  // it should also reset resend otp timer to 0

  bool wrongOtp = false;
  String errMsg = "";

  Future<http.Response> verify(String otp, String email) async {
    return http.patch(
      Uri.parse('https://bit-store-backend.herokuapp.com/user/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{'email': email, 'otp': otp}),
    );
  }

  void cacheUserData(dynamic value) async {
    Box data = await Hive.openBox('userData');
    data.put('user', value);
  }

  @override
  Widget build(BuildContext context) {
    String email = widget.emailData['email'];

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/logo.png'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: ImageIcon(AssetImage("assets/icons/back.png"),
                          color: Colors.white),
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          primary:
                              Color.fromRGBO(77, 77, 77, 1), // <-- Button color
                          onPrimary:
                              Color.fromRGBO(77, 77, 77, 1), // <-- Splash color
                          elevation: 8),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Verify Email',
                  style: TextStyle(
                      fontFamily: 'gilroy',
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(77, 77, 77, 1)),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 29, 0),
                  child: Text(
                    'We’ve sent you an OTP to your email, please enter it below',
                    style: TextStyle(
                        fontFamily: 'gilroy',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(104, 104, 104, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  '${email}',
                  style: TextStyle(
                    fontFamily: 'gilroy',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color.fromRGBO(12, 12, 12, 1),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Change',
                    style: TextStyle(
                      color: Color.fromRGBO(104, 104, 104, 1),
                      fontSize: 16,
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                      controller: otpController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Image.asset(
                          'assets/icons/password.png',
                          color: Color.fromRGBO(77, 77, 77, 1),
                        ),
                        label: Text(
                          'Enter your OTP',
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
                if (wrongOtp) ...[
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
                if (wrongOtp == false) ...[
                  InkWell(
                    onTap: () async {
                      String otp = otpController.text;

                      if (otp.isEmpty || otp.length < 6) {
                        setState(() {
                          wrongOtp = true;
                          errMsg = "Wrong OTP";
                        });
                      } else {
                        http.Response response =
                            await verify(otp, widget.emailData['email']);
                        Map res = json.decode(response.body);

                        if (!res.containsKey("message")) {
                          cacheUserData(res);
                          if (widget.type == "login") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => homeScreen()),
                            );
                          }
                          if (widget.type == "edit") {
                            Navigator.pop(context);
                          }
                        } else {
                          setState(() {
                            wrongOtp = true;
                            errMsg = res['message'];
                          });
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
                            'Confirm',
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
                ],
                if (wrongOtp == true) ...[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(223, 109, 114, 1),
                            Color.fromRGBO(223, 155, 200, 1)
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 15, 20, 10),
                        child: Center(
                          child: Text(
                            'Go Back',
                            style: TextStyle(
                              fontFamily: 'gilroy',
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/Line.png',
                      width: 80,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Didn’t receive the OTP?',
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
                    Image.asset('assets/icons/Line.png', width: 80),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      wrongOtp = false;
                    });
                  },
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(
                      color: Color.fromRGBO(12, 12, 12, 1),
                      fontSize: 20,
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  'in ${seconds} seconds',
                  style: TextStyle(
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromRGBO(104, 104, 104, 1)),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }
}
