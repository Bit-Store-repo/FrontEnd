import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// importing the account page screen
import 'package:bit_store/account_pages/account_landing.dart';

//  importing the builder widgets
import 'package:bit_store/home_screens/widgets/passwords.dart';
import 'package:bit_store/home_screens/widgets/folders.dart';
import 'package:bit_store/home_screens/widgets/new.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  String imageUrl = 'https://storage.googleapis.com/download/storage/v1/b/edumilieu-3b218.appspot.com/o/cf85a769-6e44-4c9e-a462-cec00eed51f0.png?generation=1650383943652227&alt=media';

  //  An example data
  List resData = [
    'root', '', '',
    {
      'name' : 'Amazon account 1',
      'password' : 'Amazon password',
      'logo' : 'amazon',
      'about' : 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum'
    },
    {
      'name' : 'Gmail',
      'favourite' : true,
      'email' : 'xyz@gmail.com',
      'password' : 'xyzXYZ123',
      'logo' : 'google',
      'about' : 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum'
    },
    [
      'Cards', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum', 'card',
      {
        'name' : 'Amazon account 1',
        'favourite' : true,
        'password' : 'Amazon password',
        'logo' : 'amazon',
        'about' : 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum'
      },
      {
        'name' : 'Gmail',
        'favourite' : true,
        'email' : 'xyz@gmail.com',
        'password' : 'xyzXYZ123',
        'logo' : 'google',
        'about' : 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum'
      },
    ],
    [
      'Google Accounts', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum', 'google',
      {
        'name' : 'Firebase',
        'password' : 'Amazon password',
        'logo' : 'amazon',
        'about' : 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum'
      },
      {
        'name' : 'Gmail',
        'email' : 'xyz@gmail.com',
        'password' : 'xyzXYZ123',
        'logo' : 'google',
        'about' : 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum'
      },
      [
        'Cards', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum', 'card',
        {
          'name' : 'Amazon account 1',
          'favourite' : true,
          'password' : 'Amazon password',
          'logo' : 'amazon',
          'about' : 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum'
        },
        {
          'name' : 'Gmail',
          'favourite' : true,
          'email' : 'xyz@gmail.com',
          'password' : 'xyzXYZ123',
          'logo' : 'google',
          'about' : 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum'
        },
      ],
      [
        'Google sub folder', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum', 'google',
        {
          'name' : 'Firebase',
          'password' : 'Amazon password',
          'logo' : 'amazon',
          'about' : 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum'
        },
        {
          'name' : 'Gmail',
          'email' : 'xyz@gmail.com',
          'password' : 'xyzXYZ123',
          'logo' : 'google',
          'about' : 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum'
        },
      ],
    ],
  ];

  List findFavorites(data, favorites){
    // print('recursion');
    for(int i =3; i < data.length; i++){
      if(data[i].runtimeType == List<Object>){
        favorites = findFavorites(data[i], favorites);
      }
      else{
        if(data[i].containsKey('favourite')){
          favorites.add(data[i]);
        }
      }
    };
    return favorites;
  }

  @override
  Widget build(BuildContext context) {
    List password = [];
    List folder = [];

    for(int i =3; i < resData.length; i++){
      if(resData[i].runtimeType == List<Object>){
        folder.add(resData[i]);
      }
      else{
        password.add(resData[i]);
      }
    };

    List favorites = findFavorites(resData, []);

    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      resizeToAvoidBottomInset: false,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/logo.png'),
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => showMaterialModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                  ),
                                  context: context,
                                  builder: (context) => Stack(
                                    children: <Widget>[
                                      addNew(),
                                    ],
                                  ),
                                ),
                              child: ImageIcon(AssetImage("assets/icons/add.png"),
                                  color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  primary: Color.fromRGBO(22, 22, 22, 1), // <-- Button color
                                  onPrimary: Color.fromRGBO(227, 255, 235, 1), // <-- Splash color
                                  elevation: 8
                              ),
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                              onTap: () => showMaterialModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                ),
                                context: context,
                                builder: (context) => Stack(
                                  children: <Widget>[
                                    account_landing()
                                  ],
                                ),
                              ),
                              child: Container(
                                height: 50,
                                width: 50,
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
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 2
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 40,),
                    Text('Favorites',style: TextStyle(
                        fontFamily: 'gilroy',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color.fromRGBO(77, 77, 77, 1)
                    ),),
                    passwords(passwordData : favorites,),
                    SizedBox(height: 25,),
                    Text('Folders',style: TextStyle(
                        fontFamily: 'gilroy',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color.fromRGBO(77, 77, 77, 1)
                    ),),

                    folders(folderData : folder,),

                    SizedBox(height: 25,),
                    Text('Passwords',style: TextStyle(
                        fontFamily: 'gilroy',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color.fromRGBO(77, 77, 77, 1)
                    ),),

                    passwords(passwordData : password,),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
