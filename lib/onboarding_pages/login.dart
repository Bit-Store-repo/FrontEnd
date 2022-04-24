import 'package:flutter/material.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
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
                Text('Hello Again',
                  style: TextStyle(
                      fontFamily: 'gilroy',
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(77, 77, 77, 1)
                  ),
                  textAlign: TextAlign.center,
                ),
                Text('Login to access your data',
                  style: TextStyle(
                      fontFamily: 'gilroy',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(104, 104, 104, 1)
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    
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
                        label: Text('Username/Email',style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(77, 77, 77, 1)
                        ),),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white,
                        width: 2
                    ),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),

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
                        label: Text('Password',style: TextStyle(
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
                TextButton(
                  onPressed:(){

                  },
                  child: Text('Forgot Password',
                    style: TextStyle(
                      color: Color.fromRGBO(77, 77, 77, 1),
                      fontSize: 16,fontFamily: 'gilroy',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                ElevatedButton(onPressed: (){

                },child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Text('Login', style: TextStyle(
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Colors.white,
                    ),),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(22, 22, 22, 1),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                    )
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/Line.png'),
                    SizedBox(width: 10,),
                    Text('or', style: TextStyle(
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromRGBO(22, 22, 22, 1),
                    ),),
                    SizedBox(width: 10,),
                    Image.asset('assets/icons/Line.png'),
                  ],
                ),
                SizedBox(height: 20,),
                Text('New to Bit Store ?', style: TextStyle(
                  fontFamily: 'gilroy',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color.fromRGBO(22, 22, 22, 1),
                ),),
                SizedBox(height: 20,),

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
                        child: Text('Join Bit Store', style: TextStyle(
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
