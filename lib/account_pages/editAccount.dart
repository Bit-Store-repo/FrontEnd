import 'package:bit_store/account_pages/checkPassword.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class edit_account extends StatefulWidget {
  const edit_account({Key? key, required this.verified }) : super(key: key);

  final String verified;

  @override
  _edit_accountState createState() => _edit_accountState();
}

class _edit_accountState extends State<edit_account> {

  String imageUrl = 'https://storage.googleapis.com/download/storage/v1/b/edumilieu-3b218.appspot.com/o/cf85a769-6e44-4c9e-a462-cec00eed51f0.png?generation=1650383943652227&alt=media';
  String userName = 'EmilyLayman2145';
  String email = 'itanupad@gmail.com';

  int keys = 25;
  int folders = 10;

  //  to help change change state to edit username
  bool edit_userName = false;

  @override
  Widget build(BuildContext context) {
    String status = widget.verified;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        image: DecorationImage(
          image: AssetImage('assets/account_images/bg1.png'),
          fit: BoxFit.cover,
        ),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Container(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                    Center(
                      //  the image
                      child: Container(
                        width: 140.0,  height: 130.0,
                        child: Stack(
                          children: <Widget>[
                            new Container(
                            alignment: Alignment.center,
                            height: 116,
                            width: 127,
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
                                  fit: BoxFit.cover
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.white,
                                  width: 2
                              ),
                            ),
                          ),

                            new Align(alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: ImageIcon(AssetImage("assets/icons/editBig.png"),
                                    color: Colors.white),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size.zero, // Set this
                                    padding: EdgeInsets.all(8), // and this
                                    shape: CircleBorder(),
                                    primary: Color.fromRGBO(22, 22, 22, 1),
                                    elevation: 4
                                ),
                              ),
                            )
                        ]
                        ),
                      ),
                    ),
                    SizedBox(height: 25,),

                    //  change username
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                      child: Text('Username', style: TextStyle(
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
                            borderRadius: BorderRadius.circular(20),

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
                              padding: const EdgeInsets.fromLTRB(20.0, 8, 20, 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/user.png"), color: Color.fromRGBO(77, 77, 77, 1),)),
                                  SizedBox(width: 20,),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if(edit_userName == false)...[
                                          Text('${userName}', style: TextStyle(
                                            fontFamily: 'gilroy',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Color.fromRGBO(27, 27, 27, 1),
                                          ),),
                                        ],
                                        if(edit_userName == true)...[
                                          TextFormField(
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              label: Text('${userName}',style: TextStyle(
                                                  fontFamily: 'gilroy',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(77, 77, 77, 1)
                                              ),),
                                            ),
                                          ),
                                        ]
                                      ],
                                    ),
                                  ),
                                  Expanded(flex: 1,
                                    child: Column(
                                      children: [
                                        if(edit_userName == false)...[
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                edit_userName = true;
                                              });
                                            },
                                            child: ImageIcon(AssetImage("assets/icons/edit.png"),
                                                color: Colors.white),
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size.zero, // Set this
                                                padding: EdgeInsets.all(8), // and this
                                                shape: CircleBorder(),
                                                primary: Color.fromRGBO(22, 22, 22, 1),
                                                elevation: 4
                                            ),
                                          ),
                                        ],
                                        if(edit_userName == true)...[
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                edit_userName = false;
                                              });
                                            },
                                            child: ImageIcon(AssetImage("assets/icons/tick.png"),
                                                color: Color.fromRGBO(22, 22, 22, 1)),
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size.zero, // Set this
                                                padding: EdgeInsets.all(8), // and this
                                                shape: CircleBorder(),
                                                primary: Color.fromRGBO(180, 248, 200, 1),
                                                elevation: 4
                                            ),
                                          ),
                                        ]

                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),

                    SizedBox(height: 15,),

                    //  lookup email
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                      child: Text('Email', style: TextStyle(
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
                          borderRadius: BorderRadius.circular(20),

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
                            padding: const EdgeInsets.fromLTRB(20.0, 8, 20, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/mail.png"), color: Color.fromRGBO(77, 77, 77, 1),)),
                                SizedBox(width: 20,),
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${email}', style: TextStyle(
                                        fontFamily: 'gilroy',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Color.fromRGBO(27, 27, 27, 1),
                                      ),),
                                    ],
                                  ),
                                ),

                                if(status == 'verified')...[
                                  Expanded(flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: ImageIcon(AssetImage("assets/icons/tick.png"),
                                          color: Color.fromRGBO(22, 22, 22, 1)),
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size.zero, // Set this
                                          padding: EdgeInsets.all(8), // and this
                                          shape: CircleBorder(),
                                          primary: Color.fromRGBO(180, 248, 200, 1), // <-- Button color
                                          onPrimary: Color.fromRGBO(227, 255, 235, 1), // <-- Splash color
                                          elevation: 2
                                      ),
                                    ),
                                  ),
                                ],
                                if(status == 'not_verified')...[
                                  Expanded(flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: ImageIcon(AssetImage("assets/icons/cross.png"),
                                          color: Colors.white,),
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size.zero, // Set this
                                          padding: EdgeInsets.all(8), // and this
                                          shape: CircleBorder(),
                                          primary: Color.fromRGBO(223, 109, 114, 1), // <-- Button color
                                          onPrimary: Color.fromRGBO(227, 255, 235, 1), // <-- Splash color
                                          elevation: 2
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            )
                        ),
                      ),
                    ),

                    SizedBox(height: 15,),

                    if(status == 'not_verified')...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Container(
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
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 15, 20, 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/mail.png"), color: Color.fromRGBO(77, 77, 77, 1),)),
                                  SizedBox(width: 20,),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Verify Email', style: TextStyle(
                                          fontFamily: 'gilroy',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color.fromRGBO(27, 27, 27, 1),
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/forward.png"), color: Color.fromRGBO(77, 77, 77, 1),)),
                                ],
                              )
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 25,),

                    // change email and password options
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                      child: Text('Security Settings', style: TextStyle(
                        fontFamily: 'gilroy',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color.fromRGBO(77, 77, 77, 1),
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => showMaterialModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                    ),
                                      context: context,
                                      builder: (context) => Stack(
                                      children: <Widget>[
                                      checkPassword(type: 'mail')
                                    ],
                                  ),
                                ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white,
                                    width: 2
                                ),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),

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
                                  padding: const EdgeInsets.fromLTRB(20.0, 12, 20, 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/mail.png"), color: Color.fromRGBO(77, 77, 77, 1),)),
                                      SizedBox(width: 20,),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Change Email', style: TextStyle(
                                              fontFamily: 'gilroy',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Color.fromRGBO(27, 27, 27, 1),
                                            ),),
                                            SizedBox(height: 5,),
                                            Text('You’ll need to verify your email', style: TextStyle(
                                              fontFamily: 'gilroy',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: Color.fromRGBO(137, 137, 137, 1),
                                            ),),
                                          ],
                                        ),
                                      ),
                                      Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/forward.png"), color: Color.fromRGBO(77, 77, 77, 1),)),
                                    ],
                                  )
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => showMaterialModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              ),
                              context: context,
                              builder: (context) => Stack(
                                children: <Widget>[
                                  checkPassword(type: 'password')
                                ],
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white,
                                    width: 2
                                ),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),

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
                                  padding: const EdgeInsets.fromLTRB(20.0, 12, 20, 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/password.png"), color: Color.fromRGBO(77, 77, 77, 1),)),
                                      SizedBox(width: 20,),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Change Password', style: TextStyle(
                                              fontFamily: 'gilroy',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Color.fromRGBO(27, 27, 27, 1),
                                            ),),
                                            SizedBox(height: 5,),
                                            Text('A reset link will be sent to your email', style: TextStyle(
                                              fontFamily: 'gilroy',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: Color.fromRGBO(137, 137, 137, 1),
                                            ),),
                                          ],
                                        ),
                                      ),
                                      Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/forward.png"), color: Color.fromRGBO(77, 77, 77, 1),)),
                                    ],
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/icons/bottomLogo.png'),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
