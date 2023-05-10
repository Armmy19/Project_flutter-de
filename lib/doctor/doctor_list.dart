import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/doctor/doctor_detail.dart';

class doc_list extends StatefulWidget {
  const doc_list({Key? key}) : super(key: key);

  @override
  State<doc_list> createState() => _doc_listState();
}

class _doc_listState extends State<doc_list> {
  ////////////////////////
  ///  TextEditingController? textController;
  TextEditingController searchTextController = new TextEditingController();
  List<ShowDoctor> _searchResult = [];
  List<ShowDoctor> _doctor = [];
  TextEditingController? textController;

  // Get json result and convert it to model. Then add
  Future<Null> getShowDoctor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');

    Uri url =
        Uri.parse('https://d4all-onde.com/api/webservice.php?service=health');
    var response = await http.post(url, body: {
      "id": userid,
    });
    var data = json.decode(response.body);
    print(data);

    for (var user in data['message']) {
      _doctor.add(ShowDoctor.fromJson(user));
    }
  }

  @override
  void initState() {
    super.initState();

    _doctor.clear(); //การลบข้อมูลก่อนหน้า
    //อัพเดทข้อมูลใหม่
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการห้องให้คำปรึกษา'),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Color(0xCC45156C),
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                elevation: 8.0,
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: searchTextController,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            child: _searchResult.length != 0 ||
                    searchTextController.text.isNotEmpty
                ? new ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, i) {
                      return new Card(
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Color(0xffF5F5F5),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_searchResult[i].doctorTopicConsultation}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xCC62297B),
                                    fontSize: 24,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 10),
                                  child: Text(
                                    'ผู้ให้คำปรึกษา : ${_searchResult[i].doctorName} ${_searchResult[i].doctorLastname}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  'วันเปิด : ${_searchResult[i].doctorDay}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  'เวลาทำการ : ${_searchResult[i].doctorTimeStart}-${_searchResult[i].doctorTimeEnd}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  'จำนวนที่รับ : ${_searchResult[i].doctorQuantity}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
                                    'จำนวนที่ลงทะเบียนแล้ว : ${_searchResult[i].totalRegistered} ท่าน',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: ElevatedButton.icon(
                                        onPressed: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             doc_detail(
                                          //                 showid:
                                          //                     _searchResult[index])));
                                        },
                                        icon: Icon(Icons.add, size: 18),
                                        label: Text("รายละเอียด"),
                                      )
                                          // RaisedButton.icon(
                                          //   shape: RoundedRectangleBorder(
                                          //     borderRadius:
                                          //         BorderRadius.circular(5),
                                          //   ),
                                          //   label: Text(
                                          //     'รายละเอียด',
                                          //     style: TextStyle(
                                          //       // color: Color.fromARGB(
                                          //       //     255, 255, 255, 255),
                                          //       fontSize: 12,
                                          //       fontWeight: FontWeight.normal,
                                          //     ),
                                          //   ),
                                          //   icon: Icon(
                                          //     Icons.list,
                                          //   ),
                                          //   textColor: Colors.white,
                                          //   color:
                                          //       Color.fromARGB(255, 141, 62, 165),
                                          //   splashColor: Color.fromARGB(
                                          //       255, 238, 144, 233),
                                          //   onPressed: () {
                                          //     // Navigator.push(
                                          //     //     context,
                                          //     //     MaterialPageRoute(
                                          //     //         builder: (context) =>
                                          //     //             doc_detail(
                                          //     //                 showid:
                                          //     //                     _doctor[index])));
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
                      );
                    },
                  )
                : FutureBuilder(
                    future: getShowDoctor(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: _doctor.length,
                          itemBuilder: (context, index) {
                            return new Card(
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Color(0xffF5F5F5),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 20, 20, 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${_doctor[index].doctorTopicConsultation}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xCC62297B),
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 10),
                                        child: Text(
                                          'ผู้ให้คำปรึกษา : ${_doctor[index].doctorName} ${_doctor[index].doctorLastname}',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'วันเปิด : ${_doctor[index].doctorDay}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        'เวลาทำการ : ${_doctor[index].doctorTimeStart}-${_doctor[index].doctorTimeEnd} น.',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        'จำนวนที่รับ : ${_doctor[index].doctorQuantity} ท่าน',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 10),
                                        child: Text(
                                          'จำนวนที่ลงทะเบียนแล้ว : ${_doctor[index].totalRegistered} ท่าน',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              doc_detail(
                                                                  showid: _doctor[
                                                                      index])));
                                                },
                                                icon: Icon(
                                                    Icons.confirmation_num,
                                                    size: 18),
                                                label: Text("รายละเอียด"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _doctor.forEach((doctor) {
      if (doctor.doctorName.toLowerCase().contains(text) ||
          doctor.id.toLowerCase().contains(text)) _searchResult.add(doctor);
    });

    setState(() {});
  }
}

// To parse this JSON data, do
//
//     final showDoctor = showDoctorFromJson(jsonString);

ShowDoctor showDoctorFromJson(String str) =>
    ShowDoctor.fromJson(json.decode(str));

String showDoctorToJson(ShowDoctor data) => json.encode(data.toJson());

class ShowDoctor {
  ShowDoctor({
    required this.id,
    required this.doctorName,
    required this.doctorLastname,
    required this.picture,
    required this.doctorTopicConsultation,
    required this.doctorDay,
    required this.doctorTimeStart,
    required this.doctorTimeEnd,
    required this.doctorQuantity,
    required this.totalRegistered,
  });

  String id;
  String doctorName;
  String doctorLastname;
  String picture;
  String doctorTopicConsultation;
  String doctorDay;
  String doctorTimeStart;
  String doctorTimeEnd;
  String doctorQuantity;
  String totalRegistered;

  factory ShowDoctor.fromJson(Map<String, dynamic> json) => ShowDoctor(
        id: json["id"] == null ? null : json["id"],
        doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
        doctorLastname:
            json["doctor_lastname"] == null ? null : json["doctor_lastname"],
        picture: json["picture"] == null ? null : json["picture"],
        doctorTopicConsultation: json["doctor_topic_consultation"] == null
            ? null
            : json["doctor_topic_consultation"],
        doctorDay: json["doctor_day"] == null ? null : json["doctor_day"],
        doctorTimeStart: json["doctor_time_start"] == null
            ? null
            : json["doctor_time_start"],
        doctorTimeEnd:
            json["doctor_time_end"] == null ? null : json["doctor_time_end"],
        doctorQuantity:
            json["doctor_quantity"] == null ? null : json["doctor_quantity"],
        totalRegistered:
            json["total_registered"] == null ? null : json["total_registered"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "doctor_name": doctorName == null ? null : doctorName,
        "doctor_lastname": doctorLastname == null ? null : doctorLastname,
        "picture": picture == null ? null : picture,
        "doctor_topic_consultation":
            doctorTopicConsultation == null ? null : doctorTopicConsultation,
        "doctor_day": doctorDay == null ? null : doctorDay,
        "doctor_time_start": doctorTimeStart == null ? null : doctorTimeStart,
        "doctor_time_end": doctorTimeEnd == null ? null : doctorTimeEnd,
        "doctor_quantity": doctorQuantity == null ? null : doctorQuantity,
        "total_registered": totalRegistered == null ? null : totalRegistered,
      };
}
