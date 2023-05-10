import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test/complaint/com_detail_text.dart';
import 'package:test/complaint/com_edit_text.dart';

class com_list_text extends StatefulWidget {
  // const com_list_text({Key key}) : super(key: key);

  @override
  _com_list_textState createState() => _com_list_textState();
}

class _com_list_textState extends State<com_list_text> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isApiCallProcess = false;
  late List<Listcomtext> showComtext = [];
  Future<void> Comlisttext() async {
    //กำหนดชื่อฟังชั่นใหม่ เพื่อจะดึงข้อมูลจากลิงค์ api
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    if (_isApiCallProcess == false) {
      Uri url = Uri.parse(
          'https://d4all-onde.com/api/webservice.php?service=complaint_text');
      var response = await http.post(url, body: {
        "id": userid,
      });
      var data = json.decode(response.body);
      if (data['status'] == 'success') {
        _isApiCallProcess = true;
        showComtext.clear();
        for (var user in data['message']) {
          showComtext.add(Listcomtext.fromJson(user));
        }
      } else {
        print('error');
      }
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _isApiCallProcess = false;
      Comlisttext();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showComtext.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'รายการร้องเรียน',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Comlisttext(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (showComtext.length == 0) {
              return Center(
                child: Text('ไม่มีรายการร้องเรียน'),
              );
            } else {
              return ListView.builder(
                itemCount: showComtext.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
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
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(20, 20, 20, 20),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFFAFAFA),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFF0E4FF),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        10,
                                                                        10,
                                                                        10),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                              child:
                                                                  Image.network(
                                                                'https://addpaycrypto.com/mdes_new/images/icon_text_02.png',
                                                                width: 40,
                                                                height: 40,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              'รายการข้อความร้องเรียน',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(20, 0, 20, 20),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                com_detail_text(showidtext: showComtext[index])));
                                                                  },
                                                                  child: Text(
                                                                      showComtext[
                                                                              index]
                                                                          .title),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Ink(
                                                                child:
                                                                    IconButton(
                                                                  icon: Icon(Icons
                                                                      .settings),
                                                                  color: Color(
                                                                      0xCC7E3A9D),
                                                                  iconSize: 30,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => com_edit_text(
                                                                                  id: showComtext[index],
                                                                                  refresh: _refresh,
                                                                                )));
                                                                  },
                                                                ),
                                                              ),
                                                              Ink(
                                                                child:
                                                                    IconButton(
                                                                  icon: Icon(Icons
                                                                      .delete_forever),
                                                                  color: Color(
                                                                      0xCC7E3A9D),
                                                                  iconSize: 30,
                                                                  onPressed:
                                                                      () async {
                                                                    SharedPreferences
                                                                        prefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    String?
                                                                        userid =
                                                                        prefs.getString(
                                                                            'userid');

                                                                    Uri url = Uri
                                                                        .parse(
                                                                            'https://d4all-onde.com/api/webservice.php?service=complaint_text_delete');
                                                                    var response =
                                                                        await http.post(
                                                                            url,
                                                                            body: {
                                                                          "id":
                                                                              showComtext[index].id,
                                                                          "id_user":
                                                                              userid,
                                                                        });
                                                                    var data = json
                                                                        .decode(
                                                                            response.body);
                                                                    print(data);
                                                                    if (data[
                                                                            "status"] ==
                                                                        "success") {
                                                                      setState(
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      });
                                                                    } else {
                                                                      print(
                                                                          'error');
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
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
//     final listcomtext = listcomtextFromJson(jsonString);

List<Listcomtext> listcomtextFromJson(String str) => List<Listcomtext>.from(
    json.decode(str).map((x) => Listcomtext.fromJson(x)));

String listcomtextToJson(List<Listcomtext> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Listcomtext {
  Listcomtext({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
  });

  String id;
  String title;
  String date;
  String status;

  factory Listcomtext.fromJson(Map<String, dynamic> json) => Listcomtext(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        date: json["date"] == null ? null : json["date"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "date": date == null ? null : date,
        "status": status == null ? null : status,
      };
}
