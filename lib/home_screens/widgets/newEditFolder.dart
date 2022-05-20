import 'package:bit_store/home_screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class newEditFolder extends StatefulWidget {
  const newEditFolder(
      {Key? key,
      required this.folderData,
      required this.type,
      required this.traversal})
      : super(key: key);
  final Map folderData;
  final String type;
  final List traversal;

  @override
  _newEditFolderState createState() => _newEditFolderState();
}

class _newEditFolderState extends State<newEditFolder> {
  bool passwordVisible = false;
  String dropdownValue = 'None';

  List resData1 = [];

  void cacheData(dynamic value) async {
    Box data = await Hive.openBox('passwordData');
    data.put('myData', value);
  }

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

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getCache();
    Map folderData = widget.folderData;

    // Map passwordData = widget.passwordData;
    String type = widget.type;

    //  replace the list with stored icons
    List icons = <String>[
      'amazon',
      'google',
      'card',
      'None',
      'One',
      'Two',
      'Free',
      'Four',
    ];

    TextEditingController nameController = TextEditingController();
    TextEditingController aboutController = TextEditingController();

    if (widget.type == "Edit") {
      nameController.text = widget.folderData['name'];
      if (widget.folderData.containsKey('about')) {
        aboutController.text = widget.folderData['about'];
      }
    }

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
                      // widget.traversal.removeAt(widget.traversal.length - 1);
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
                    '${type} Folder',
                    style: TextStyle(
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color.fromRGBO(77, 77, 77, 1),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: ImageIcon(AssetImage("assets/icons/edit.png"),
                        color: Colors.white),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Color.fromRGBO(22, 22, 22, 0),
                        elevation: 0),
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
                      'Meta Data',
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

                    //  Name of password
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
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            label: Text(
                              'Enter folder name',
                              style: TextStyle(
                                  fontFamily: 'gilroy',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color.fromRGBO(77, 77, 77, 1)),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //  Additional Info
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        height: 130,
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
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: aboutController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        label: Text(
                                          'Addtl. info to help you remember',
                                          style: TextStyle(
                                              fontFamily: 'gilroy',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  77, 77, 77, 1)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),

                    //  Icon to display
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
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Text(
                                  'Select Icon to display',
                                  style: TextStyle(
                                    fontFamily: 'gilroy',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color.fromRGBO(27, 27, 27, 1),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: ImageIcon(
                                        AssetImage("assets/icons/down.png"),
                                        color: Color.fromRGBO(27, 27, 27, 1),
                                      ),
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: Color.fromRGBO(27, 27, 27, 1)),
                                      onChanged: (dynamic? newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                        });
                                      },
                                      items: icons
                                          .map<DropdownMenuItem<String>>(
                                              (dynamic value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        String name = nameController.text;
                        String about = aboutController.text;

                        List newFolder = [name, about, 'google'];

                        if (widget.type == "New") {
                          // function that gets the index of that traversal
                          // array from the data
                          int getIndex(List alist, int index) {
                            int counter = 0;
                            for (int i = 0; i < alist.length; i++) {
                              if (alist[i].runtimeType == List<dynamic>) {
                                counter += 1;
                              }
                              if (counter == index) {
                                return i;
                              }
                            }
                            return -1;
                          }

                          List tempArray = resData1;
                          for (int i = 0; i < widget.traversal.length; i++) {
                            tempArray = tempArray[
                                getIndex(resData1, widget.traversal[i])];
                          }
                          tempArray.add(newFolder);
                          print(resData1);
                          print(widget.traversal);
                          print(tempArray);
                          cacheData(resData1);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => homeScreen()),
                          );
                        } else if (widget.type == "Edit") {
                          // function that gets the index of that traversal
                          // array from the data
                          int getIndex(List alist, int index) {
                            int counter = 0;
                            for (int i = 0; i < alist.length; i++) {
                              if (alist[i].runtimeType == List<dynamic>) {
                                counter += 1;
                              }
                              if (counter == index) {
                                return i;
                              }
                            }
                            return -1;
                          }

                          List tempArray = resData1;
                          for (int i = 0; i < widget.traversal.length; i++) {
                            tempArray = tempArray[
                                getIndex(resData1, widget.traversal[i])];
                          }
                          tempArray[0] = name;
                          tempArray[1] = about;
                          tempArray[2] = 'card';

                          print(resData1);

                          cacheData(resData1);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => homeScreen()),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
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
                          padding: const EdgeInsets.fromLTRB(20.0, 15, 20, 15),
                          child: Center(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontFamily: 'gilroy',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Color.fromRGBO(22, 22, 22, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
