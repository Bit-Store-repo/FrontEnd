import 'package:bit_store/home_screens/homeScreen.dart';
import 'package:bit_store/home_screens/widgets/newEditPassword.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class passwordSettings extends StatefulWidget {
  const passwordSettings(
      {Key? key, required this.passwordData, required this.traversal})
      : super(key: key);
  final Map passwordData;
  final List traversal;

  @override
  _passwordSettingsState createState() => _passwordSettingsState();
}

class _passwordSettingsState extends State<passwordSettings> {
  List resData1 = [];

  void getCache() async {
    Box data = await Hive.openBox('passwordData');
    // print(data.get('myData'));
    // hello.add(data.get('myData'));
    if (resData1.isEmpty) {
      setState(() {
        resData1 = data.get('myData');
      });
    }
  }

  void cacheData(dynamic value) async {
    Box data = await Hive.openBox('passwordData');
    data.put('myData', value);
  }

  @override
  Widget build(BuildContext context) {
    getCache();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Container(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 10, 35, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/account_images/topBar.png')),

                SizedBox(
                  height: 30,
                ),

                Text(
                  'Password Settings',
                  style: TextStyle(
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Color.fromRGBO(22, 22, 22, 1)),
                ),
                SizedBox(
                  height: 40,
                ),

                // conditional statements
                //  remove from fav
                if (widget.passwordData.containsKey('favourite')) ...[
                  InkWell(
                    onTap: () {
                      widget.passwordData.remove('favourite');
                      cacheData(resData1);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => homeScreen()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: ImageIcon(
                              AssetImage("assets/icons/heart.png"),
                              color: Color.fromRGBO(77, 77, 77, 1),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Remove from favorites',
                                style: TextStyle(
                                  fontFamily: 'gilroy',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromRGBO(27, 27, 27, 1),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Am I not your favourite ?',
                                style: TextStyle(
                                  fontFamily: 'gilroy',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color.fromRGBO(137, 137, 137, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: ImageIcon(
                              AssetImage("assets/icons/forward.png"),
                              color: Color.fromRGBO(77, 77, 77, 0),
                            )),
                      ],
                    ),
                  ),
                ],

                // add to fav
                if (!widget.passwordData.containsKey('favourite')) ...[
                  InkWell(
                    onTap: () {
                      widget.passwordData['favourite'] = true;
                      cacheData(resData1);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => homeScreen()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: ImageIcon(
                              AssetImage("assets/icons/heartFilled.png"),
                              color: Color.fromRGBO(77, 77, 77, 1),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add to favorites',
                                style: TextStyle(
                                  fontFamily: 'gilroy',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromRGBO(27, 27, 27, 1),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Faster and easy access',
                                style: TextStyle(
                                  fontFamily: 'gilroy',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color.fromRGBO(137, 137, 137, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: ImageIcon(
                              AssetImage("assets/icons/forward.png"),
                              color: Color.fromRGBO(77, 77, 77, 0),
                            )),
                      ],
                    ),
                  ),
                ],

                SizedBox(
                  height: 25,
                ),

                //  edit password info
                InkWell(
                  onTap: () {
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: ImageIcon(
                            AssetImage("assets/icons/editBig.png"),
                            color: Color.fromRGBO(77, 77, 77, 1),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit Password Info',
                              style: TextStyle(
                                fontFamily: 'gilroy',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color.fromRGBO(27, 27, 27, 1),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Change password or delete',
                              style: TextStyle(
                                fontFamily: 'gilroy',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Color.fromRGBO(137, 137, 137, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: ImageIcon(
                            AssetImage("assets/icons/forward.png"),
                            color: Color.fromRGBO(77, 77, 77, 1),
                          )),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
