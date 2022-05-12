import 'package:bit_store/home_screens/widgets/folders.dart';
import 'package:bit_store/home_screens/widgets/new.dart';
//  importing the builder widgets
import 'package:bit_store/home_screens/widgets/passwords.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class folderPage extends StatefulWidget {
  const folderPage(
      {Key? key, required this.folderData, required this.traversal})
      : super(key: key);

  final List folderData;
  final List traversal;

  @override
  _folderPageState createState() => _folderPageState();
}

class _folderPageState extends State<folderPage> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    List passwordData = widget.folderData;

    List password = [];
    List folder = [];

    for (int i = 3; i < widget.folderData.length; i++) {
      if (widget.folderData[i].runtimeType == List<dynamic>) {
        folder.add(widget.folderData[i]);
      } else {
        password.add(widget.folderData[i]);
      }
    }
    ;

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
                      widget.traversal.removeAt(widget.traversal.length - 1);
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
                    '${passwordData[0]}',
                    style: TextStyle(
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color.fromRGBO(77, 77, 77, 1),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => showMaterialModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      context: context,
                      builder: (context) => Stack(
                        children: <Widget>[
                          addNew(
                            traversal: widget.traversal,
                          ),
                        ],
                      ),
                    ),
                    child: ImageIcon(AssetImage("assets/icons/add.png"),
                        color: Colors.white),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary:
                            Color.fromRGBO(22, 22, 22, 1), // <-- Button color
                        onPrimary: Color.fromRGBO(
                            227, 255, 235, 1), // <-- Splash color
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
                          passwordData[1],
                          style: TextStyle(
                            fontFamily: 'gilroy',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromRGBO(77, 77, 77, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    if (password.isNotEmpty) ...[
                      Text(
                        'Passwords',
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
                      passwords(
                        passwordData: password,
                        traversal: widget.traversal,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                    if (folder.isNotEmpty) ...[
                      Text(
                        'Folders',
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
                      folders(
                        folderData: folder,
                        traversal: widget.traversal,
                      ),
                    ],
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
