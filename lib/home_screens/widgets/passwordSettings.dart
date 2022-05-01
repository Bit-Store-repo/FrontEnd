import 'package:flutter/material.dart';

class passwordSettings extends StatefulWidget {
  const passwordSettings({Key? key}) : super(key: key);

  @override
  _passwordSettingsState createState() => _passwordSettingsState();
}

class _passwordSettingsState extends State<passwordSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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

                SizedBox(height: 30,),

                Text('Password Settings',style: TextStyle(
                    fontFamily: 'gilroy',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Color.fromRGBO(22, 22, 22, 1)
                ),),
                SizedBox(height: 40,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/heart.png"), color: Color.fromRGBO(77, 77, 77, 1),)),
                    SizedBox(width: 20,),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Remove from favorites', style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(27, 27, 27, 1),
                          ),),
                          SizedBox(height: 5,),
                          Text('Am I not your favourite ?', style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Color.fromRGBO(137, 137, 137, 1),
                          ),),
                        ],
                      ),
                    ),
                    Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/forward.png"), color: Color.fromRGBO(77, 77, 77, 0),)),
                  ],
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/editBig.png"), color: Color.fromRGBO(77, 77, 77, 1),)),
                    SizedBox(width: 20,),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Edit Password Info', style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(27, 27, 27, 1),
                          ),),
                          SizedBox(height: 5,),
                          Text('Change password or delete', style: TextStyle(
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
                ),
              ],
            )
        ),
      ),
    );
  }
}
