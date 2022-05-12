import 'package:bit_store/home_screens/widgets/newEditPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class passwordPage extends StatefulWidget {
  const passwordPage(
      {Key? key, required this.passwordData, required this.traversal})
      : super(key: key);

  final Map passwordData;
  final List traversal;

  @override
  _passwordPageState createState() => _passwordPageState();
}

class _passwordPageState extends State<passwordPage> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    Map passwordData = widget.passwordData;
    print(widget.traversal);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          shadowColor: Color.fromRGBO(35, 35, 35, 0.2),
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: ImageIcon(AssetImage("assets/icons/back.png"),
                        color: Color.fromRGBO(22, 22, 22, 1)),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Color.fromRGBO(
                            180, 248, 200, 1), // <-- Button color
                        onPrimary: Color.fromRGBO(
                            227, 255, 235, 1), // <-- Splash color
                        elevation: 8),
                  ),
                  Text(
                    '${passwordData['name']}',
                    style: TextStyle(
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color.fromRGBO(77, 77, 77, 1),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => newEditPassword(
                                  passwordData: widget.passwordData,
                                  type: 'Edit',
                                  traversal: widget.traversal,
                                )),
                      );
                    },
                    child: ImageIcon(AssetImage("assets/icons/edit.png"),
                        color: Colors.white),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Color.fromRGBO(22, 22, 22, 1),
                        elevation: 8),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/home_images/homeBGpng.png'),
                fit: BoxFit.cover,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'About',
                      style: TextStyle(
                        fontFamily: 'gilroy',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color.fromRGBO(77, 77, 77, 1),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(35, 35, 35, 0.8),
                            offset: const Offset(
                              0,
                              4,
                            ),
                            blurRadius: 14,
                            spreadRadius: -15,
                          ),
                        ],
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          passwordData['about'],
                          style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromRGBO(77, 77, 77, 1),
                          ),
                        ),
                      ),
                    ),
                    if (passwordData.containsKey('email')) ...[
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(35, 35, 35, 0.8),
                                offset: const Offset(
                                  0,
                                  4,
                                ),
                                blurRadius: 14,
                                spreadRadius: -15,
                              ),
                            ],
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${passwordData['email']}',
                                        style: TextStyle(
                                          fontFamily: 'gilroy',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color.fromRGBO(27, 27, 27, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: InkWell(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                              text: passwordData['password']));
                                        },
                                        child: ImageIcon(
                                          AssetImage("assets/icons/copy.png"),
                                          color:
                                              Color.fromRGBO(255, 174, 188, 1),
                                        ))),
                              ],
                            ),
                          )),
                    ],
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'gilroy',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color.fromRGBO(77, 77, 77, 1),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(35, 35, 35, 0.8),
                              offset: const Offset(
                                0,
                                4,
                              ),
                              blurRadius: 14,
                              spreadRadius: -15,
                            ),
                          ],
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (passwordVisible == true) ...[
                                      Text(
                                        '${passwordData['password']}',
                                        style: TextStyle(
                                          fontFamily: 'gilroy',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color.fromRGBO(27, 27, 27, 1),
                                        ),
                                      ),
                                    ],
                                    if (passwordVisible == false) ...[
                                      Text(
                                        '*****************',
                                        style: TextStyle(
                                          fontFamily: 'gilroy',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color.fromRGBO(27, 27, 27, 1),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: passwordData['password']));
                                      },
                                      child: ImageIcon(
                                        AssetImage("assets/icons/copy.png"),
                                        color: Color.fromRGBO(255, 174, 188, 1),
                                      ))),
                              SizedBox(
                                width: 20,
                              ),
                              if (passwordVisible == true) ...[
                                Expanded(
                                    flex: 1,
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            passwordVisible = false;
                                          });
                                        },
                                        child: ImageIcon(
                                          AssetImage(
                                              "assets/icons/eyeClose.png"),
                                          color:
                                              Color.fromRGBO(125, 125, 125, 1),
                                        ))),
                              ],
                              if (passwordVisible == false) ...[
                                Expanded(
                                    flex: 1,
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            passwordVisible = true;
                                          });
                                        },
                                        child: ImageIcon(
                                          AssetImage("assets/icons/eye.png"),
                                          color:
                                              Color.fromRGBO(125, 125, 125, 1),
                                        ))),
                              ],
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
