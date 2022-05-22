import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class changePassword extends StatefulWidget {
  const changePassword({Key? key, required this.changeKey, required this.email})
      : super(key: key);

  final String changeKey;
  final String email;

  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  String errMsg = "";

  Future<http.Response> changePassword(
      String email, String key, password) async {
    return http.patch(
      Uri.parse('https://bit-store-backend.herokuapp.com/user/password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
          <String, String>{'email': email, 'key': key, 'password': password}),
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

  void cacheUserData(dynamic value) async {
    Box data = await Hive.openBox('userData');
    data.put('user', value);
  }

  @override
  Widget build(BuildContext context) {
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
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
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
                    'Change Password',
                    style: TextStyle(
                        fontFamily: 'gilroy',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(77, 77, 77, 1)),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 8, 60, 0),
                    child: Text(
                      'You’ll need to use the new password henceforth',
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
              //  Current email
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8, 20, 8),
                child: Text(
                  'New Password',
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
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      controller: password1Controller,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                          fontFamily: 'gilroy',
                          fontWeight: FontWeight.w500,
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
                height: 10,
              ),
              //  new email
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8, 20, 8),
                child: Text(
                  'Confirm Password',
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
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      controller: password2Controller,
                      decoration: InputDecoration(
                        hintText: 'Re-enter Password',
                        hintStyle: TextStyle(
                          fontFamily: 'gilroy',
                          fontWeight: FontWeight.w500,
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
                height: 20,
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

              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: InkWell(
                  onTap: () async {
                    String newPassword = password1Controller.text;
                    String password = password2Controller.text;

                    if (newPassword == password) {
                      if (password.isEmpty || password.length < 8) {
                        setState(() {
                          password1Controller.text = newPassword;
                          password2Controller.text = password;
                          if (password.isEmpty) {
                            errMsg = "Password cannot be empty";
                          } else {
                            errMsg = "Password needs min 8 characters";
                          }
                        });
                      } else {
                        _onLoading();
                        http.Response response = await changePassword(
                            widget.email, widget.changeKey, password);
                        Map res = json.decode(response.body);

                        Navigator.pop(context);

                        if (!res.containsKey("message")) {
                          cacheUserData(res);
                          Navigator.pushNamedAndRemoveUntil(
                              context, "home", (r) => false);
                        } else {
                          setState(() {
                            password1Controller.text = newPassword;
                            password2Controller.text = password;
                            errMsg = res["message"];
                          });
                        }
                      }
                    } else {
                      setState(() {
                        password1Controller.text = newPassword;
                        password2Controller.text = password;
                        errMsg = "Passwords are not equal";
                      });
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
          ),
        ));
  }
}
