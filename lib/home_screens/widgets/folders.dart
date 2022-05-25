import 'package:bit_store/home_screens/widgets/folderPage.dart';
import 'package:bit_store/home_screens/widgets/folderSettings.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class folders extends StatefulWidget {
  const folders({Key? key, required this.folderData, required this.traversal})
      : super(key: key);
  final List folderData;
  final List traversal;

  @override
  _foldersState createState() => _foldersState();
}

class _foldersState extends State<folders> {
  @override
  Widget build(BuildContext context) {
    List password = [];
    List folder = [];
    List data = [];

    for (int i = 0; i < widget.folderData.length; i++) {
      if (widget.folderData[i].runtimeType == List<dynamic>) {
        folder.add(widget.folderData[i]);
        String name = widget.folderData[i][0];
        String about = widget.folderData[i][1];
        String logo = widget.folderData[i][2];

        Map newData = {'name': name, 'icon': logo, 'about': about};

        data.add(newData);
      } else {
        password.add(widget.folderData[i]);
      }
    }
    ;

    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // push the index value to traversal
              widget.traversal.add(index + 1);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => folderPage(
                          folderData: folder[index],
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
                              AssetImage("assets/icons/folderLock.png"),
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
                                  fontWeight: FontWeight.w600,
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
                              ]
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  // push the index value to traversal
                                  widget.traversal.add(index + 1);
                                  showMaterialModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                    ),
                                    context: context,
                                    builder: (context) => Stack(
                                      children: <Widget>[
                                        folderSettings(
                                          folderData: data[index],
                                          traversal: widget.traversal,
                                        )
                                      ],
                                    ),
                                  ).then((_) {
                                    setState(() {});
                                  });
                                },
                                child: ImageIcon(
                                  AssetImage("assets/icons/dots.png"),
                                  color: Color.fromRGBO(114, 207, 141, 1),
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
