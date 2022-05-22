import 'package:bit_store/home_screens/widgets/passwordPage.dart';
import 'package:bit_store/home_screens/widgets/passwordSettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class passwords extends StatefulWidget {
  const passwords(
      {Key? key, required this.passwordData, required this.traversal})
      : super(key: key);
  final List passwordData;
  final List traversal;

  @override
  _passwordsState createState() => _passwordsState();
}

class _passwordsState extends State<passwords> {
  @override
  Widget build(BuildContext context) {
    List data = widget.passwordData;

    void _onLoading() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Color.fromRGBO(22, 22, 22, 1),
            shape: CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new ImageIcon(
                    AssetImage("assets/icons/tick.png"),
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Copied!',
                    style: TextStyle(
                      fontFamily: 'gilroy',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
      new Future.delayed(new Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    }

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
                          traversal: widget.traversal,
                        )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Container(
                height: 51,
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
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: ImageIcon(
                              AssetImage("assets/icons/password.png"),
                              color: Color.fromRGBO(77, 77, 77, 1),
                              size: 20,
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
                                  _onLoading();
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
                                onTap: () {
                                  showMaterialModalBottomSheet(
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
                                          traversal: widget.traversal,
                                        )
                                      ],
                                    ),
                                  );
                                },
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
