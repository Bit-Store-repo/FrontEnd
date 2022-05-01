import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:bit_store/account_pages/changeMail.dart';
import 'package:bit_store/account_pages/changePassword.dart';

class checkPassword extends StatefulWidget {
  const checkPassword({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  _checkPasswordState createState() => _checkPasswordState();
}

class _checkPasswordState extends State<checkPassword> {

  // a flag that triggers wrong password message

  bool wrongpassword = false;

  @override
  Widget build(BuildContext context) {
    String nextPage = widget.type;

    return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          image: DecorationImage(
            image: AssetImage('assets/account_images/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/account_images/topBar.png')),
              SizedBox(height: 10,),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: ImageIcon(AssetImage("assets/icons/back.png"),
                        color: Color.fromRGBO(22, 22, 22, 1)),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Color.fromRGBO(180, 248, 200, 1), // <-- Button color
                        onPrimary: Color.fromRGBO(227, 255, 235, 1), // <-- Splash color
                        elevation: 8
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Column(
                children: [
                  Text('Caution',
                    style: TextStyle(
                        fontFamily: 'gilroy',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(77, 77, 77, 1)
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text('You’re trying to enter security settings and we need to verify you',
                      style: TextStyle(
                          fontFamily: 'gilroy',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(104, 104, 104, 1)
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8, 20, 8),
                child: Text('Enter Password to continue', style: TextStyle(
                  fontFamily: 'gilroy',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color.fromRGBO(104, 104, 104, 1),
                ),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white,
                        width: 2
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),

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
              ),

              SizedBox(height: 15,),

              if(wrongpassword == false)...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: InkWell(
                    onTap: () => showMaterialModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              ),
                              context: context,
                              builder: (context) => Stack(
                                children: <Widget>[
                                  if(nextPage == 'mail')...[changeMail()],
                                  if(nextPage == 'password')...[changePassword()]
                                ],
                              ),
                          ),
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
                ),
              ],

              if(wrongpassword == true)...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                        child: Text('Wrong Password', style: TextStyle(
                          fontFamily: 'gilroy',
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        )
    );
  }
}
