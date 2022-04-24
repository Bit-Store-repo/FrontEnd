import 'package:flutter/material.dart';
import 'package:bit_store/onboarding_pages/swipe_screen.dart';
import 'package:bit_store/onboarding_pages/login.dart';

void main() => runApp(MaterialApp(
  initialRoute: 'login',

  routes: {
    // '/': (context) => loading(),

    //all the onboarding screen comes here
    'swipe_screen':(context) => swipe_screen(),
    'login': (context) => login_screen(),
  },
));
