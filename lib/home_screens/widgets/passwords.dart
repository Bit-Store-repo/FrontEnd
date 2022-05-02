import 'package:bit_store/home_screens/widgets/passwordPage.dart';
import 'package:bit_store/home_screens/widgets/passwordSettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class passwords extends StatefulWidget {
  const passwords(
      {Key? key, required this.passwordData, required this.favourite})
      : super(key: key);
  final List passwordData;
  final bool favourite;

  @override
  _passwordsState createState() => _passwordsState();
}

class _passwordsState extends State<passwords> {
  @override
  Widget build(BuildContext context) {
    List data = widget.passwordData;

    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => passwordPage(
                          passwordData: data[index],
                        )),
              );
            },
            child: Padding(
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
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: ImageIcon(
                              AssetImage("assets/icons/user.png"),
                              color: Color.fromRGBO(77, 77, 77, 1),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${data[index]['name']}',
                                style: TextStyle(
                                  fontFamily: 'gilroy',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromRGBO(27, 27, 27, 1),
                                ),
                              ),
                              if (data[index].containsKey('email')) ...[
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${data[index]['email']}',
                                  style: TextStyle(
                                    fontFamily: 'gilroy',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: Color.fromRGBO(137, 137, 137, 1),
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
                                      text: data[index]['password']));
                                },
                                child: ImageIcon(
                                  AssetImage("assets/icons/copy.png"),
                                  color: Color.fromRGBO(255, 174, 188, 1),
                                ))),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () => showMaterialModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                      ),
                                      context: context,
                                      builder: (context) => Stack(
                                        children: <Widget>[
                                          passwordSettings(
                                            passwordData: data[index],
                                            favourite: widget.favourite,
                                          )
                                        ],
                                      ),
                                    ),
                                child: ImageIcon(
                                  AssetImage("assets/icons/dots.png"),
                                  color: Color.fromRGBO(255, 174, 188, 1),
                                ))),
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
