import 'dart:convert';

import 'package:bit_store/account_pages/changeMail.dart';
import 'package:bit_store/account_pages/changePassword.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class checkPassword extends StatefulWidget {
  const checkPassword({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  _checkPasswordState createState() => _checkPasswordState();
}

class _checkPasswordState extends State<checkPassword> {
  // a flag that triggers wrong password message

  bool wrongpassword = false;

  Future<http.Response> check(String email, String password) async {
    return http.post(
      Uri.parse('https://bit-store-backend.herokuapp.com/user/checkpassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{'email': email, 'password': password}),
    );
  }

  String userName = "";
  String email = "";
  String status = "";

  Map userData = {};
  void getCache() async {
    Box user = await Hive.openBox('userData');
    if (userData.isEmpty) {
      setState(() {
        userData = user.get('user');
        userName = userData['userName'];
        email = userData['email'];
        status = userData['verified'] ? "verified" : "not_verified";
      });
    }
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

  TextEditingController passwordController = TextEditingController();
  String errMsg = "";

  @override
  Widget build(BuildContext context) {
    String nextPage = widget.type;
    getCache();

    return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          image: DecorationImage(
            image: AssetImage('assets/account_images/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/account_images/topBar.png')),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: ImageIcon(AssetImage("assets/icons/back.png"),
                        color: Color.fromRGBO(22, 22, 22, 1)),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Color.fromRGBO(
                            180, 248, 200, 1), // <-- Button color
                        onPrimary: Color.fromRGBO(
                            227, 255, 235, 1), // <-- Splash color
                        elevation: 8),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    'Caution',
                    style: TextStyle(
                        fontFamily: 'gilroy',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(77, 77, 77, 1)),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Text(
                      'You’re trying to enter security settings and we need to verify you',
                      style: TextStyle(
                          fontFamily: 'gilroy',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(104, 104, 104, 1)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8, 20, 8),
                child: Text(
                  'Enter Password to continue',
                  style: TextStyle(
                    fontFamily: 'gilroy',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color.fromRGBO(104, 104, 104, 1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(
                  height: 51,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(252, 231, 223, 1),
                        Color.fromRGBO(254, 239, 219, 1)
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
                          height: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              if (errMsg.length != 0) ...[
                Center(
                  child: TextButton(
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
                ),
                SizedBox(
                  height: 10,
                ),
              ],
              if (wrongpassword == false) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: InkWell(
                    onTap: () async {
                      String password = passwordController.text;

                      if (password.isEmpty || password.length < 8) {
                        setState(() {
                          if (password.isEmpty) {
                            errMsg = "Password cannot be empty";
                          } else {
                            errMsg = "Password needs min 8 characters";
                          }
                        });
                      } else {
                        _onLoading();
                        http.Response response = await check(email, password);
                        Map res = json.decode(response.body);

                        if (res.containsKey("changeKey")) {
                          Navigator.pop(context);
                          showMaterialModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            context: context,
                            builder: (context) => Stack(
                              children: <Widget>[
                                if (nextPage == 'mail') ...[
                                  changeMail(
                                    changeKey: res['changeKey'],
                                    email: email,
                                  )
                                ] else if (nextPage == 'password') ...[
                                  changePassword(
                                    changeKey: res['changeKey'],
                                    email: email,
                                  )
                                ]
                              ],
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                          setState(() {
                            errMsg = res["message"];
                          });
                        }
                      }
                    },
                    child: Container(
                      height: 51,
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
                            'Confirm',
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
                ),
              ],
              if (wrongpassword == true) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                          'Wrong Password',
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
            ],
          ),
        ));
  }
}
