import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  // int now = DateTime.now().millisecondsSinceEpoch;
  // print(DateTime.now().millisecondsSinceEpoch);
  //
  // while (true) {
  //   if (DateTime.now().millisecondsSinceEpoch > now + 2000) {
  //     Navigator.pushReplacementNamed(context, 'swipe_screen');
  //   }
  // }

  void firstTime() async {
    Box firstTimeUser = await Hive.openBox('FirstTime');
    var firstTime = firstTimeUser.get('firstTime');

    if (firstTime == null) {
      firstTimeUser.put('firstTime', 'false');
      Navigator.pushReplacementNamed(context, 'swipe_screen');
    }
  }

  void checkLoggedIn() async {
    Box user = await Hive.openBox('Login');

    var loggedIn = user.get('loggedIn');
    // print(loggedIn);

    if (loggedIn == null) {
      // user.put('loggedIn', 'true');
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      // user.delete('loggedIn');
      Navigator.pushReplacementNamed(context, 'home');
    }
  }

  @override
  Widget build(BuildContext context) {
    firstTime();
    checkLoggedIn();

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logoBig.png',
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'The Easy Storage',
                  style: TextStyle(
                      fontFamily: 'gilroy',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(77, 77, 77, 1)),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )),
    );
  }
}
