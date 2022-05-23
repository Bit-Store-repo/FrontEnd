import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class changeMail extends StatefulWidget {
  const changeMail({Key? key, required this.changeKey, required this.email})
      : super(key: key);
  final String changeKey;
  final String email;

  @override
  _changeMailState createState() => _changeMailState();
}

class _changeMailState extends State<changeMail> {
  Future<http.Response> changeEmail(
      String email, String newEmail, String key) async {
    return http.patch(
      Uri.parse('https://bit-store-backend.herokuapp.com/user/mail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{
        'email': email.toLowerCase(),
        'newEmail': newEmail,
        'key': key
      }),
    );
  }

  void cacheUserData(dynamic value) async {
    Box data = await Hive.openBox('userData');
    data.put('user', value);
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

  TextEditingController mailController = TextEditingController();
  TextEditingController newMailController = TextEditingController();
  String errMsg = "";

  @override
  Widget build(BuildContext context) {
    mailController.text = widget.email;

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
                    'Change Email',
                    style: TextStyle(
                        fontFamily: 'gilroy',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(77, 77, 77, 1)),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 8, 80, 0),
                    child: Text(
                      'You’ll need to verify your new email after this step',
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
                  'Current email',
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
                      controller: mailController,
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
              ),

              SizedBox(
                height: 10,
              ),
              //  new email
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8, 20, 8),
                child: Text(
                  'New Email',
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
                      controller: newMailController,
                      decoration: InputDecoration(
                        hintText: 'New email',
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
                    String email = newMailController.text;

                    if (email.isEmpty) {
                      setState(() {
                        newMailController.text = email;
                        errMsg = "Email cannot be empty";
                      });
                    } else if (email.contains("@") == false ||
                        email.contains(".") == false) {
                      setState(() {
                        newMailController.text = email;
                        errMsg = "Invalid Email";
                      });
                    } else {
                      _onLoading();

                      http.Response response = await changeEmail(
                          widget.email, email, widget.changeKey);
                      Map res = json.decode(response.body);

                      Navigator.pop(context);

                      if (!res.containsKey("message")) {
                        cacheUserData(res);
                        int count = 0;
                        Navigator.popUntil(context, (route) {
                          return count++ == 2;
                        });
                      } else {
                        setState(() {
                          newMailController.text = email;
                          errMsg = res["message"];
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
              ),
            ],
          ),
        ));
  }
}
