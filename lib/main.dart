import 'package:bit_store/account_pages/editAccount.dart';
import 'package:flutter/material.dart';

// importing all the onboarding pages
import 'package:bit_store/onboarding_pages/swipe_screen.dart';
import 'package:bit_store/onboarding_pages/login.dart';
import 'package:bit_store/onboarding_pages/register.dart';
import 'package:bit_store/onboarding_pages/verifyMail.dart';
import 'package:bit_store/onboarding_pages/forgotPassword.dart';

// importing all the account pages
import 'package:bit_store/account_pages/account_landing.dart';
import 'package:bit_store/account_pages/editAccount.dart';
import 'package:bit_store/account_pages/checkPassword.dart';
import 'package:bit_store/account_pages/changeMail.dart';

// importing all the home screens
import 'package:bit_store/home_screens/homeScreen.dart';

void main() => runApp(MaterialApp(
  initialRoute: 'home',

  routes: {
    // '/': (context) => loading(),

  //  all the on-boarding screens come here
    'swipe_screen':(context) => swipe_screen(),
    'login': (context) => login_screen(),
    'register': (context) => register(),
    'verifyMail': (context) => verifyMail(),
    'forgotPassword': (context) => forgotPassword(),

  //  account screens come ova here
    'account_landing' : (context) => account_landing(),
    'changeMail' : (context) => changeMail(),

  //  all the main_application pages go here
    'home' : (context) => homeScreen()
  },
));
