import 'package:bit_store/home_screens/widgets/newEditFolder.dart';
import 'package:bit_store/home_screens/widgets/newEditPassword.dart';
import 'package:flutter/material.dart';

class addNew extends StatefulWidget {
  const addNew({Key? key}) : super(key: key);

  @override
  _addNewState createState() => _addNewState();
}

class _addNewState extends State<addNew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(35, 10, 35, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/account_images/topBar.png')),

              SizedBox(height: 30,),

              Text('Create',style: TextStyle(
                  fontFamily: 'gilroy',
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color.fromRGBO(22, 22, 22, 1)
              ),),
              SizedBox(height: 40,),

              //  remove from fav
              InkWell(
                onTap:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        newEditPassword(
                          passwordData: {}, type: 'New',)),
                  );
                },
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
                          Text('New Password', style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(27, 27, 27, 1),
                          ),),
                          SizedBox(height: 5,),
                          Text('Stores a single password', style: TextStyle(
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
              ),
              SizedBox(height: 25,),

              //  edit password info
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        newEditFolder(
                          folderData: {}, type: 'New',)),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 1, child: ImageIcon(AssetImage("assets/icons/folder.png"), color: Color.fromRGBO(77, 77, 77, 1),)),
                    SizedBox(width: 20,),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('New Folder', style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(27, 27, 27, 1),
                          ),),
                          SizedBox(height: 5,),
                          Text('Stores multiple passwords', style: TextStyle(
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
              ),
            ],
          )
      ),
    );
  }
}
