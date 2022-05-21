// importing the account page screen
import 'dart:convert';

import 'package:bit_store/account_pages/account_landing.dart';
import 'package:bit_store/home_screens/widgets/folders.dart';
import 'package:bit_store/home_screens/widgets/new.dart';
//  importing the builder widgets
import 'package:bit_store/home_screens/widgets/passwords.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  _getRequests() async {}

  List findFavorites(data, favorites) {
    // print('recursion');
    for (int i = 3; i < data.length; i++) {
      if (data[i].runtimeType == List<dynamic>) {
        favorites = findFavorites(data[i], favorites);
      } else {
        if (data[i].containsKey('favourite')) {
          favorites.add(data[i]);
        }
      }
    }
    ;
    return favorites;
  }

  List resData = [];
  Map userData = {};
  String passwordOnly = "";
  String imageUrl =
      "https://www.icmetl.org/wp-content/uploads/2020/11/user-icon-human-person-sign-vector-10206693.png";

  void getCache() async {
    Box passwordData = await Hive.openBox('passwordData');
    Box user = await Hive.openBox('userData');
    Box password = await Hive.openBox('userPassword');
    if (resData.isEmpty) {
      setState(() {
        resData = passwordData.get('myData');
        userData = user.get('user');
        passwordOnly = password.get('password');
        print(userData['profPic']);
        imageUrl = userData['profPic'];
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

  List traversal = [];

  @override
  Widget build(BuildContext context) {
    getCache();

    List password = [];
    List folder = [];

    for (int i = 3; i < resData.length; i++) {
      if (resData[i].runtimeType == List<dynamic>) {
        folder.add(resData[i]);
      } else {
        password.add(resData[i]);
      }
    }
    ;
    List favorites = findFavorites(resData, []);

    // print('------------------');
    // print('------------------');
    // print(folder);
    // print('------------------');
    // print(password);
    // print('------------------');
    // print('------------------');
    // print(resData);
    // print('------------------');
    // print('------------------');

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          shadowColor: Color.fromRGBO(35, 35, 35, 0.2),
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/logo.png'),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          _onLoading();
                          http.Response putInfo = await putData(
                              userData['key'], resData, passwordOnly);
                          List info = json.decode(putInfo.body);
                          Navigator.pop(context);
                        },
                        child: ImageIcon(AssetImage("assets/icons/forward.png"),
                            color: Colors.white),
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: Color.fromRGBO(
                                22, 22, 22, 1), // <-- Button color
                            onPrimary: Color.fromRGBO(
                                227, 255, 235, 1), // <-- Splash color
                            elevation: 8),
                      ),
                      ElevatedButton(
                        onPressed: () => showMaterialModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          context: context,
                          builder: (context) => Stack(
                            children: <Widget>[
                              addNew(
                                traversal: [],
                              ),
                            ],
                          ),
                        ),
                        child: ImageIcon(AssetImage("assets/icons/add.png"),
                            color: Colors.white),
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: Color.fromRGBO(
                                22, 22, 22, 1), // <-- Button color
                            onPrimary: Color.fromRGBO(
                                227, 255, 235, 1), // <-- Splash color
                            elevation: 8),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () => showMaterialModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          context: context,
                          builder: (context) => Stack(
                            children: <Widget>[account_landing()],
                          ),
                        ).then((_) {
                          setState(() {
                            resData = [];
                          });
                        }),
                        child: Container(
                          height: 50,
                          width: 50,
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
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/home_images/homeBGpng.png'),
                fit: BoxFit.cover,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0,
                    ),
                    if (!favorites.isEmpty) ...[
                      Text(
                        'Favorites',
                        style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color.fromRGBO(77, 77, 77, 1)),
                      ),
                      passwords(
                        passwordData: favorites,
                        traversal: [],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                    if (!folder.isEmpty) ...[
                      Text(
                        'Folders',
                        style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color.fromRGBO(77, 77, 77, 1)),
                      ),
                      folders(
                        folderData: folder,
                        traversal: [],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                    if (!password.isEmpty) ...[
                      Text(
                        'Passwords',
                        style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color.fromRGBO(77, 77, 77, 1)),
                      ),
                      passwords(
                        passwordData: password,
                        traversal: [],
                      ),
                    ]
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
