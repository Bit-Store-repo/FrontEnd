import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:bit_store/home_screens/widgets/passwordSettings.dart';

class favorites extends StatefulWidget {
  const favorites({Key? key, required this.passwordData}) : super(key: key);
  final List passwordData;

  @override
  _favoritesState createState() => _favoritesState();
}

class _favoritesState extends State<favorites> {

  List data = [
    {
      'name' : 'Amazon account 1',
      'password' : 'Amazon password',
      'logo' : 'amazon'
    },
    {
      'name' : 'Gmail',
      'email' : 'xyz@gmail.com',
      'password' : 'xyzXYZ123',
      'logo' : 'google'
    },
    {
      'name' : 'Facebook',
      'email' : 'xyz@facebook.com',
      'password' : 'xyzXYZ123',
      'logo' : 'facebook'
    },
    {
      'name' : 'Debit card',
      'password' : 'Debit card password',
      'logo' : 'card'
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(35, 35, 35, 0.4),
                    offset: const Offset(
                      0,
                      4,
                    ),
                    blurRadius: 14,
                    spreadRadius: -15,
                  ),
                ],
                border: Border.all(
                    color: Colors.white,
                    width: 2
                ),
                borderRadius: BorderRadius.circular(10),

                color: Colors.white,
              ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/user.png"), color: Color.fromRGBO(77, 77, 77, 1),)),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${data[index]['name']}', style: TextStyle(
                              fontFamily: 'gilroy',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromRGBO(27, 27, 27, 1),
                            ),),
                            SizedBox(height: 5,),
                            if(data[index].containsKey('email'))...[
                              Text('${data[index]['email']}', style: TextStyle(
                                fontFamily: 'gilroy',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Color.fromRGBO(137, 137, 137, 1),
                              ),),
                            ]
                          ],
                        ),
                      ),
                      Expanded(flex: 1, child: InkWell( onTap: () {Clipboard.setData(ClipboardData(text: "your text"));},

                          child: ImageIcon(AssetImage("assets/icons/copy.png"), color: Color.fromRGBO(255, 174, 188, 1),))),
                      SizedBox(width:20,),
                      Expanded(flex: 1, child: InkWell( onTap: () => showMaterialModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                          ),
                          context: context,
                          builder: (context) => Stack(
                            children: <Widget>[
                              passwordSettings()
                            ],
                          ),
                        ),
                          child: ImageIcon(AssetImage("assets/icons/dots.png"), color: Color.fromRGBO(255, 174, 188, 1),))),
                    ],
                  )
              ),
            ),
          );

        },
      ),
    );
  }
}
