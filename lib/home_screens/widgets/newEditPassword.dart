import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class newEditPassword extends StatefulWidget {
  const newEditPassword(
      {Key? key, required this.passwordData, required this.type})
      : super(key: key);
  final Map passwordData;
  final String type;

  @override
  _newEditPasswordState createState() => _newEditPasswordState();
}

class _newEditPasswordState extends State<newEditPassword> {
  bool passwordVisible = false;
  String dropdownValue = 'google';

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map passwordData = widget.passwordData;

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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
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
                    '${type} Password',
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
                    if (type == 'New') ...[
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              label: Text(
                                'Enter name to identify',
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
                    ],
                    if (type == 'Edit') ...[
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              label: Text(
                                '${passwordData['name']}',
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
                    ],

                    //  Additional Info
                    if (type == 'New') ...[
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          label: Text(
                                            'Addtl. info to help you remember\n(optional)',
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
                    ],
                    if (type == 'Edit') ...[
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          label: Text(
                                            '${passwordData['about']}',
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
                    ],

                    //  email
                    if (type == 'New') ...[
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
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          label: Text(
                                            'Email (optional)',
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
                    ],
                    if (type == 'Edit') ...[
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
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          label: Text(
                                            '${passwordData['email']}',
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
                    ],

                    //  Icon to display
                    if (type == 'New') ...[
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
                                            color:
                                                Color.fromRGBO(27, 27, 27, 1)),
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
                    ],
                    if (type == 'Edit') ...[
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      DropdownButton<String>(
                                        value: passwordData['icon'],
                                        icon: ImageIcon(
                                          AssetImage("assets/icons/down.png"),
                                          color: Color.fromRGBO(27, 27, 27, 1),
                                        ),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color:
                                                Color.fromRGBO(27, 27, 27, 1)),
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
                    ],

                    SizedBox(
                      height: 25,
                    ),

                    Text(
                      'Password fields',
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
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (type == 'New') ...[
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          label: Text(
                                            'Enter Password',
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
                                    if (type == 'Edit') ...[
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          label: Text(
                                            '${passwordData['password']}',
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
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                  onTap: () {
                                    var uuid = Uuid();
                                    var uid = uuid.v4();
                                    setState(() {});
                                  },
                                  child: ImageIcon(
                                    AssetImage("assets/icons/gear.png"),
                                    color: Color.fromRGBO(125, 125, 125, 1),
                                  )),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Text(
                        'Click the gear icon to generate random password',
                        style: TextStyle(
                          fontFamily: 'gilroy',
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Color.fromRGBO(77, 77, 77, 1),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap: () {},
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
