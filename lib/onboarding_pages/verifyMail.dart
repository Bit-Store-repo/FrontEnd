import 'package:flutter/material.dart';

class verifyMail extends StatefulWidget {
  const verifyMail({Key? key}) : super(key: key);

  @override
  _verifyMailState createState() => _verifyMailState();
}

class _verifyMailState extends State<verifyMail> {

  int seconds = 1;
  String email = 'itanupad@gmail.com';

  // a flag that triggers wrong otp message
  // it should also reset resend otp timer to 0

  bool wrongOtp = false;

  @override
  Widget build(BuildContext context) {
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
              children: [
                Row(
                  children: [
                    Image.asset('assets/logo.png')
                  ],
                ),
                SizedBox(height: 80,),
                Text('Verify Email',
                  style: TextStyle(
                      fontFamily: 'gilroy',
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(77, 77, 77, 1)
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 29, 0),
                  child: Text('We’ve sent you an OTP to your email, please enter it below',
                    style: TextStyle(
                        fontFamily: 'gilroy',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(104, 104, 104, 1)
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40,),

                Text('${email}', style: TextStyle(
                    fontFamily: 'gilroy',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color.fromRGBO(12, 12, 12, 1),
                ),),

                TextButton(
                  onPressed:(){

                  },
                  child: Text('Change',
                    style: TextStyle(
                      color: Color.fromRGBO(104, 104, 104, 1),
                      fontSize: 16,fontFamily: 'gilroy',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white,
                        width: 2
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),

                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(252, 218, 221, 1),
                        Color.fromRGBO(254, 228, 217, 1)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Image.asset('assets/icons/password.png', color: Color.fromRGBO(77, 77, 77, 1),),
                        label: Text('Enter your OTP',style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(77, 77, 77, 1)
                        ),),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                if(wrongOtp == false)...[
                  InkWell(
                    onTap: () {
                        setState(() {
                          wrongOtp = true;
                        });
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white,
                            width: 2
                        ),
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
                          child: Text('Confirm', style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Color.fromRGBO(22, 22, 22, 1),
                          ),),
                        ),
                      ),
                    ),
                  ),
                ],

                if(wrongOtp == true)...[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 2
                      ),
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
                        child: Text('Wrong OTP', style: TextStyle(
                          fontFamily: 'gilroy',
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  ),
                ],

                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/Line.png', width: 80,),
                    SizedBox(width: 10,),
                    Text('Didn’t receive the OTP?', style: TextStyle(
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromRGBO(22, 22, 22, 1),
                    ),),
                    SizedBox(width: 10,),
                    Image.asset('assets/icons/Line.png', width: 80),
                  ],
                ),
                SizedBox(height: 20,),
                TextButton(
                  onPressed:(){
                    setState(() {
                      wrongOtp = false;
                    });
                  },
                  child: Text('Resend OTP',
                    style: TextStyle(
                      color: Color.fromRGBO(12, 12, 12, 1),
                      fontSize: 20,fontFamily: 'gilroy',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text('in ${seconds} seconds', style: TextStyle(
                    fontFamily: 'gilroy',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color.fromRGBO(104, 104, 104, 1)
                ),),
                SizedBox(height: 20,),


              ],
            ),
          )
      ),
    );
  }
}
