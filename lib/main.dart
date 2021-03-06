// importing all the account pages
import 'package:bit_store/account_pages/account_landing.dart';
// importing all the home screens
import 'package:bit_store/home_screens/homeScreen.dart';
import 'package:bit_store/home_screens/widgets/newEditFolder.dart';
import 'package:bit_store/home_screens/widgets/newEditPassword.dart';
import 'package:bit_store/onboarding_pages/forgotPassword.dart';
import 'package:bit_store/onboarding_pages/login.dart';
import 'package:bit_store/onboarding_pages/register.dart';
// importing all the onboarding pages
import 'package:bit_store/onboarding_pages/splash.dart';
import 'package:bit_store/onboarding_pages/swipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter('passwordDB');
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      //  all the on-boarding screens come here
      '/': (context) => splash(),
      'swipe_screen': (context) => swipe_screen(),
      'login': (context) => login_screen(),
      'register': (context) => register(),
      // 'verifyMail': (context) => verifyMail(
      //       emailData: {
      //         "email": "itanupad@gmail.com",
      //         "userName": "itanupad",
      //         "profPic": "none",
      //         "key": "bf052bf6-0499-455b-ab89-0fe2dc11d099",
      //         "verified": true,
      //         "__v": 0
      //       },
      //     ),
      'forgotPassword': (context) => forgotPassword(),

      //  account screens come ova here
      'account_landing': (context) => account_landing(),
      // 'changeMail': (context) => changeMail(),

      //  all the main_application pages go here
      'home': (context) => homeScreen(),
      'newPassword': (context) => newEditPassword(
            passwordData: {},
            type: 'New',
            traversal: [],
          ),
      'newFolder': (context) => newEditFolder(
            folderData: {},
            type: 'New',
            traversal: [],
          ),
    },
  ));
}
