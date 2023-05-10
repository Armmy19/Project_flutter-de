import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test/complaint/com_list_text.dart';

class com_detail_text extends StatefulWidget {
  final Listcomtext showidtext;
  const com_detail_text({Key? key, required this.showidtext}) : super(key: key);

  @override
  _com_detail_textState createState() => _com_detail_textState();
}

class _com_detail_textState extends State<com_detail_text> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Listcomtext idtext;
  late Detailtextdata textdata;
  Future<void> Comdetailtext() async {
    idtext = widget.showidtext;
    print(idtext.id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_text_data');
    var response = await http.post(url, body: {
      "id": idtext.id,
    });
    var data = json.decode(response.body);
    textdata = detailtextdataFromJson(response.body);
    print("รายละเอียดข้อมูล Complain Text/Picture");
    print(data);
  }

  @override
  void initState() {
    idtext = widget.showidtext;
    print(idtext.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'รายละเอียดข้อมูล',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: FutureBuilder(
        future: Comdetailtext(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 20, 20, 0),
                                    child: Text(
                                      textdata.message.title,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xCC62297B),
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 10, 20, 10),
                                    child: Text(
                                      textdata.message.content,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 20, 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 0),
                                          child: Text(
                                            'สถานะข้อมูล :',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          textdata.status,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF5BAF89),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Load and show image from textdata.picture
                                  Image.network(textdata.message.picture),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final detailtextdata = detailtextdataFromJson(jsonString);

Detailtextdata detailtextdataFromJson(String str) =>
    Detailtextdata.fromJson(json.decode(str));

String detailtextdataToJson(Detailtextdata data) => json.encode(data.toJson());

class Detailtextdata {
  Detailtextdata({
    required this.status,
    required this.message,
  });

  String status;
  Message message;

  factory Detailtextdata.fromJson(Map<String, dynamic> json) => Detailtextdata(
        status: json["status"],
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
      };
}

class Message {
  Message({
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

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        picture: json["picture"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "picture": picture,
        "date": date,
        "status": status,
      };
}
