import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test/complaint/com_list_text.dart';

class com_edit_text extends StatefulWidget {
  final Listcomtext id;
  final Future<void> Function() refresh;
  const com_edit_text({Key? key, required this.id, required this.refresh})
      : super(key: key);

  @override
  _com_edit_textState createState() => _com_edit_textState();
}

class _com_edit_textState extends State<com_edit_text> {
  // TextEditingController textController1;
  // TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Listcomtext showid;
  var now = DateTime.now();
  TextEditingController title = new TextEditingController();
  TextEditingController content = new TextEditingController();
  TextEditingController dateInput = TextEditingController();

  //   Future<Null> Showdetailtext() async {
  //   showid = widget.id;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userid = prefs.getString('userid');
  //   print(showid.id);
  //   Uri url = Uri.parse(
  //      'https://addpaycrypto.com/mdes_new/api/webservice.php?service=complaint_text_data');
  //   var response = await http.post(url, body: {
  //     "id": showid.id,
  //   });
  //   var data = json.decode(response.body);
  //   textdata = detailtextdataFromJson(response.body);
  //   print(data);
  // }

  Future<Null> Editdetaultext() async {
    showid = widget.id;
    print(showid.id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_text_editdata');
    var response = await http.post(url, body: {
      "id": showid.id,
      "id_user": userid,
      "title": title.text,
      "content": content.text,
      "date": '${now.year}-${now.month}-${now.day}',
    });
    var data = json.decode(response.body);
    if (data["status"] == "success") {
      widget.refresh();
      Navigator.pop(context);
    } else {
      print('error');
    }
    print(data);
  }

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'แก้ไขรายการร้องเรียน ',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'แก้ไขรายการข้อความร้องเรียน',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF543062),
                        fontSize: 20,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFFE0D2E4),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                        child: Text(
                          'หัวข้อร้องเรียน',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xCC62297B),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: TextFormField(
                          controller: title,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF0E4FF),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF0E4FF),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          ),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                        child: Text(
                          'เนื้อหาการร้องเรียน',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xCC62297B),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: TextFormField(
                          controller: content,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF0E4FF),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF0E4FF),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          ),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 6,
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.max,
                      //     children: [
                      //       Padding(
                      //         padding:
                      //             EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      //         child: Row(
                      //           mainAxisSize: MainAxisSize.max,
                      //           children: [
                      //             Text(
                      //               'วันที่ส่งการร้องเรียน ',
                      //               style: TextStyle(
                      //                 fontFamily: 'Poppins',
                      //                 color: Color(0xCC62297B),
                      //                 fontWeight: FontWeight.normal,
                      //               ),
                      //             ),

                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: ElevatedButton.icon(
                              onPressed: () {
                                Editdetaultext();
                              },
                              icon: Icon(Icons.arrow_right_outlined, size: 18),
                              label: Text("ส่งข้อมูลร้องเรียน"),
                            )
                                // RaisedButton.icon(
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(5),
                                //   ),
                                //   label: Text(
                                //     'ส่งข้อมูลร้องเรียน',
                                //     style: TextStyle(
                                //       // color: Color.fromARGB(
                                //       //     255, 255, 255, 255),
                                //       fontSize: 12,
                                //       fontWeight: FontWeight.normal,
                                //     ),
                                //   ),
                                //   icon: Icon(
                                //     Icons.arrow_right_outlined,
                                //     // color:
                                //     //     Color.fromARGB(255, 255, 255, 255),
                                //   ),
                                //   textColor: Colors.white,
                                //   color: Color.fromARGB(255, 141, 62, 165),
                                //   splashColor: Color.fromARGB(255, 238, 144, 233),
                                //   onPressed: () {
                                //     Editdetaultext();
                                //   },
                                // ),
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Detailtextdata detailtextdataFromJson(String str) =>
    Detailtextdata.fromJson(json.decode(str));

String detailtextdataToJson(Detailtextdata data) => json.encode(data.toJson());

class Detailtextdata {
  Detailtextdata({
    required this.id,
    required this.title,
    required this.content,
    required this.picture,
    required this.date,
    required this.status,
  });

  String id;
  String title;
  String content;
  String picture;
  String date;
  String status;

  factory Detailtextdata.fromJson(Map<String, dynamic> json) => Detailtextdata(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
        picture: json["picture"] == null ? null : json["picture"],
        date: json["date"] == null ? null : json["date"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "content": content == null ? null : content,
        "picture": picture == null ? null : picture,
        "date": date == null ? null : date,
        "status": status == null ? null : status,
      };
}
