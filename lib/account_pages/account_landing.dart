import 'dart:convert';

import 'package:bit_store/account_pages/editAccount.dart';
import 'package:bit_store/onboarding_pages/verifyMail.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class account_landing extends StatefulWidget {
  const account_landing({Key? key}) : super(key: key);

  @override
  _account_landingState createState() => _account_landingState();
}

class _account_landingState extends State<account_landing> {
  String userName = "";
  String email = "";
  String status = "";
  String passwordOnly = "";
  String imageUrl =
      "https://www.icmetl.org/wp-content/uploads/2020/11/user-icon-human-person-sign-vector-10206693.png";

  Map userData = {};
  List resData = [];
  void getCache() async {
    Box user = await Hive.openBox('userData');
    Box passwordData = await Hive.openBox('passwordData');
    Box password = await Hive.openBox('userPassword');
    if (userData.isEmpty) {
      setState(() {
        resData = passwordData.get('myData');
        passwordOnly = password.get('password');
        userData = user.get('user');
        userName = userData['userName'];
        imageUrl = userData['profPic'];
        email = userData['email'];
        status = userData['verified'] ? "verified" : "not_verified";
      });
    }
  }

  Future<http.Response> logout(String user_id) async {
    return http.get(
        Uri.parse('https://bit-store-backend.herokuapp.com/logout/${user_id}'));
  }

  Future<http.Response> verify(String email) async {
    return http.post(
      Uri.parse('https://bit-store-backend.herokuapp.com/user/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{'email': email.toLowerCase()}),
    );
  }

  void logoutRouter() async {
    Box user = await Hive.openBox('Login');

    user.put('loggedIn', 'false');
  }

  void delData() async {
    Box data = await Hive.openBox('passwordData');
    data.put('myData', null);
  }

  Future<http.Response> putData(
      String pKey, dynamic value, String password) async {
    final key = encrypt.Key.fromUtf8(
        sha256.convert(utf8.encode(password)).toString().substring(0, 16));
    final iv = encrypt.IV.fromLength(8);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(json.encode(value), iv: iv).base64;

    return http.post(
      Uri.parse('https://bit-store-blockchain.herokuapp.com/chain/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{'key': pKey, 'data': encrypted}),
    );
  }

  void delUserData() async {
    Box data = await Hive.openBox('userData');
    Box password = await Hive.openBox('userPassword');
    data.put('user', null);
    password.put('password', null);
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

  int fCount = 0;
  int pCount = 0;
  List resArr = [];

  List findNumbers(data, arr) {
    // print('recursion');
    for (int i = 3; i < data.length; i++) {
      if (data[i].runtimeType == List<dynamic>) {
        arr[0] += 1;
        arr = findNumbers(data[i], arr);
      } else {
        arr[1] += 1;
      }
    }
    ;
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    getCache();
    if (resData.isNotEmpty) {
      resArr = findNumbers(resData, [0, 0]);
      fCount = resArr[0];
      pCount = resArr[1];
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        image: DecorationImage(
          image: AssetImage('assets/account_images/bg1.png'),
          fit: BoxFit.cover,
        ),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Container(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Center(
                          child:
                              Image.asset('assets/account_images/topBar.png')),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: ImageIcon(
                                AssetImage("assets/icons/back.png"),
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
                      Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(35, 35, 35, 0.4),
                                offset: const Offset(
                                  0,
                                  4,
                                ),
                                blurRadius: 34,
                                spreadRadius: 1,
                              ),
                            ],
                            image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      Text(
                        '${userName}',
                        style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color.fromRGBO(22, 22, 22, 1)),
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${email}',
                            style: TextStyle(
                              fontFamily: 'gilroy',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color.fromRGBO(104, 104, 104, 1),
                            ),
                          ),
                          if (status == 'verified') ...[
                            ImageIcon(
                              AssetImage("assets/icons/verified.png"),
                              color: Color.fromRGBO(114, 207, 141, 1),
                            ),
                          ],
                          if (status == 'not_verified') ...[
                            ImageIcon(
                              AssetImage("assets/icons/not_verified.png"),
                              color: Color.fromRGBO(223, 109, 114, 1),
                            ),
                          ]
                        ],
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(245, 245, 245, 1),
                                  Color.fromRGBO(254, 228, 217, 1)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(150, 150, 150, 0.4),
                                  offset: const Offset(
                                    0,
                                    4,
                                  ),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${pCount}',
                                  style: TextStyle(
                                      fontFamily: 'gilroy',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Color.fromRGBO(93, 218, 214, 1)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Keys Stored',
                                  style: TextStyle(
                                    fontFamily: 'gilroy',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color.fromRGBO(22, 22, 22, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(245, 245, 245, 1),
                                  Color.fromRGBO(254, 228, 217, 1)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(150, 150, 150, 0.4),
                                  offset: const Offset(
                                    0,
                                    4,
                                  ),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${fCount}',
                                  style: TextStyle(
                                      fontFamily: 'gilroy',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Color.fromRGBO(93, 218, 214, 1)),
                                ),
                                Text(
                                  'Folders',
                                  style: TextStyle(
                                    fontFamily: 'gilroy',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color.fromRGBO(22, 22, 22, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // conditional verify email button
                      if (status == 'not_verified') ...[
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: InkWell(
                            onTap: () async {
                              _onLoading();
                              await verify(email);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => verifyMail(
                                          emailData: userData,
                                          type: "edit",
                                        )),
                              ).then((_) {
                                setState(() {
                                  userData = {};
                                });
                              });
                            },
                            child: Container(
                              height: 51,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(14),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(180, 231, 229, 1),
                                    Color.fromRGBO(180, 248, 200, 1)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: ImageIcon(
                                            AssetImage("assets/icons/mail.png"),
                                            color:
                                                Color.fromRGBO(77, 77, 77, 1),
                                          )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Text(
                                          'Verify Email',
                                          style: TextStyle(
                                            fontFamily: 'gilroy',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color:
                                                Color.fromRGBO(27, 27, 27, 1),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: ImageIcon(
                                            AssetImage(
                                                "assets/icons/forward.png"),
                                            color:
                                                Color.fromRGBO(77, 77, 77, 1),
                                          )),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ],

                      SizedBox(
                        height: 15,
                      ),

                      // menu options
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => showMaterialModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                ),
                                context: context,
                                builder: (context) => Stack(
                                  children: <Widget>[edit_account()],
                                ),
                              ).then((_) {
                                setState(() {
                                  userData = {};
                                });
                              }),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(14),
                                      topRight: Radius.circular(14)),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: ImageIcon(
                                              AssetImage(
                                                  "assets/icons/user.png"),
                                              color:
                                                  Color.fromRGBO(77, 77, 77, 1),
                                            )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Account Settings',
                                                style: TextStyle(
                                                  fontFamily: 'gilroy',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      27, 27, 27, 1),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Edit your user and security settings',
                                                style: TextStyle(
                                                  fontFamily: 'gilroy',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color: Color.fromRGBO(
                                                      137, 137, 137, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: ImageIcon(
                                              AssetImage(
                                                  "assets/icons/forward.png"),
                                              color:
                                                  Color.fromRGBO(77, 77, 77, 1),
                                            )),
                                      ],
                                    )),
                              ),
                            ),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: ImageIcon(
                                            AssetImage("assets/icons/help.png"),
                                            color:
                                                Color.fromRGBO(77, 77, 77, 1),
                                          )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Help',
                                              style: TextStyle(
                                                fontFamily: 'gilroy',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    27, 27, 27, 1),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Helpdesk to contact us',
                                              style: TextStyle(
                                                fontFamily: 'gilroy',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: Color.fromRGBO(
                                                    137, 137, 137, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: ImageIcon(
                                            AssetImage(
                                                "assets/icons/forward.png"),
                                            color:
                                                Color.fromRGBO(77, 77, 77, 1),
                                          )),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      // logout
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: InkWell(
                          onTap: () async {
                            _onLoading();
                            http.Response response =
                                await logout(userData['_id']);
                            Map res = json.decode(response.body);
                            if (res['message'] == "success") {
                              logoutRouter();
                              delData();
                              delUserData();
                              http.Response putInfo = await putData(
                                  userData['key'], resData, passwordOnly);
                              List info = json.decode(putInfo.body);
                              Navigator.pop(context);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (route) => false);
                            } else {
                              Navigator.pop(context);
                              print(res['message']);
                            }
                          },
                          child: Container(
                            height: 51,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(14),
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: ImageIcon(
                                          AssetImage("assets/icons/logout.png"),
                                          color: Color.fromRGBO(77, 77, 77, 1),
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Logout',
                                            style: TextStyle(
                                              fontFamily: 'gilroy',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(27, 27, 27, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.asset('assets/icons/bottomLogo.png'),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
