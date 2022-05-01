import 'package:flutter/material.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({Key? key}) : super(key: key);

  @override
  _forgotPasswordState createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
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
                Text('Forgot Password',
                  style: TextStyle(
                      fontFamily: 'gilroy',
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(77, 77, 77, 1)
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text('Enter email to get a reset password link',
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
                        icon: Image.asset('assets/icons/user.png', color: Color.fromRGBO(77, 77, 77, 1),),
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

                InkWell(
                  onTap: () {

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
            ),
          )
      ),
    );
  }
}
