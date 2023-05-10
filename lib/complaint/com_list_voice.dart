import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/complaint/com_detail_voice.dart';
import 'package:test/complaint/com_edit_voice.dart';

class com_list_voice extends StatefulWidget {
  // const com_list_voice({Key key}) : super(key: key);

  @override
  _com_list_voiceState createState() => _com_list_voiceState();
}

class _com_list_voiceState extends State<com_list_voice> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Showlistvoice> showComvoice = [];

  Future<void> Comlistvoice() async {
    //กำหนดชื่อฟังชั่นใหม่ เพื่อจะดึงข้อมูลจากลิงค์ api
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_sound');
    var response = await http.post(url, body: {
      "id": '$userid',
    });
    var data = json.decode(response.body);
    print(data);
    if (data["status"] == "success") {
      for (var user in data["message"]) {
        showComvoice.add(Showlistvoice.fromJson(user));
      }
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'รายการข้อความเสียงร้องเรียน',
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
        future: Comlistvoice(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (showComvoice.length == 0) {
              return Center(
                child: Text('ไม่มีรายการร้องเรียน'),
              );
            } else {
              return Shoelistvoice();
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

  Widget Shoelistvoice() {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: showComvoice.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                            child: Text(
                              'รายการร้องเรียน',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF543062),
                                fontSize: 20,
                                letterSpacing: 0.2,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 20, 20, 20),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFFAFAFA),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Color(0xFFF0E4FF),
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
                                                              .fromSTEB(10, 10,
                                                                  10, 10),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                        child: Image.network(
                                                          'https://addpaycrypto.com/mdes_new/images/icon_voice_02.png',
                                                          width: 40,
                                                          height: 40,
                                                          fit: BoxFit.fill,
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 0, 0, 0),
                                                      child: Text(
                                                        'รายการข้อความเสียงร้องเรียน',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 0, 20, 20),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 10, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: TextButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          com_detail_voice(
                                                                            idvoice:
                                                                                showComvoice[index],
                                                                          )));
                                                            },
                                                            child: Text(
                                                                showComvoice[
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
                                                            .fromSTEB(
                                                                10, 0, 0, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Ink(
                                                          child: IconButton(
                                                            icon: Icon(
                                                                Icons.settings),
                                                            color: Color(
                                                                0xCC7E3A9D),
                                                            iconSize: 30,
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          com_edit_voice(
                                                                            ideditvoice:
                                                                                showComvoice[index],
                                                                          )));
                                                            },
                                                          ),
                                                        ),
                                                        Ink(
                                                          child: IconButton(
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
                                                              String? userid =
                                                                  prefs.getString(
                                                                      'userid');

                                                              Uri url = Uri.parse(
                                                                  'https://d4all-onde.com/api/webservice.php?service=complaint_sound_delete');
                                                              var response =
                                                                  await http
                                                                      .post(url,
                                                                          body: {
                                                                    "id": showComvoice[
                                                                            index]
                                                                        .id,
                                                                    "id_user":
                                                                        userid,
                                                                  });
                                                              var data =
                                                                  json.decode(
                                                                      response
                                                                          .body);
                                                              print(data);
                                                              if (data[
                                                                      "status"] ==
                                                                  "success") {
                                                                setState(() {
                                                                  Navigator.pop(
                                                                      context);
                                                                });
                                                              } else {
                                                                print('error');
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
              ]);
            }),
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final showlistvoice = showlistvoiceFromJson(jsonString);

List<Showlistvoice> showlistvoiceFromJson(String str) =>
    List<Showlistvoice>.from(
        json.decode(str).map((x) => Showlistvoice.fromJson(x)));

String showlistvoiceToJson(List<Showlistvoice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Showlistvoice {
  Showlistvoice({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
  });

  String id;
  String title;
  String date;
  String status;

  factory Showlistvoice.fromJson(Map<String, dynamic> json) => Showlistvoice(
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
