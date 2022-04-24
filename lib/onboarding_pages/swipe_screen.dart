import 'package:flutter/material.dart';

class swipe_screen extends StatelessWidget {
  const swipe_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onboard_images/phonebg.png'),
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
                children: [
                  Image.asset('assets/logo.png')
                ],
              ),
              SizedBox(height: 40,),
              Text('The Easy\nStorage',
                style: TextStyle(
                  fontFamily: 'gilroy',
                  fontSize: 45,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(77, 77, 77, 1)
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        )
      ),
    );
  }
}
