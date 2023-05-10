import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/doctor/doctorregister_detail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class doc_reg extends StatefulWidget {
  // const doc_reg({Key key}) : super(key: key);

  @override
  _doc_regState createState() => _doc_regState();
}

class _doc_regState extends State<doc_reg> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Timer _timer;

  TextEditingController searchTextController = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<void> getShowDoctordata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=health_user');
    var response = await http.post(url, body: {
      "id": userid,
    });
    var data = json.decode(response.body);

    if (data["status"] == "success") {
      setState(() {
        for (var user in data["message"]) {
          _doctordata.add(ShowDoctordata.fromJson(user));
        }
      });
    } else {
      print("error");
    }
    ;
  }

  // Create function to refresh
  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _doctordata.clear();
      getShowDoctordata();
    });
    return null;
  }

  @override
  void initState() {
    super.initState();

    _doctordata.clear(); //การลบข้อมูลก่อนหน้า
    getShowDoctordata(); //อัพเดทข้อมูลใหม่
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'รายการห้องให้คำปรึกษา',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
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
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      searchTextController.clear();
                      onSearchTextChanged('');
                    },
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
                                  '${_doctordata[i].doctorTopicConsultation}',
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
                                    'ผู้ให้คำปรึกษา : ${_doctordata[i].doctorName} ${_doctordata[i].doctorLastname}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  'วันเปิด : ${_doctordata[i].doctorDay}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  'เวลาทำการ : ${_doctordata[i].doctorTimeStart}-${_doctordata[i].doctorTimeEnd}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  'จำนวนที่รับ : ${_doctordata[i].doctorQuantity}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
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
                                          child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text('รายละเอียด'),
                                      )),
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
                : new ListView.builder(
                    itemCount: _doctordata.length,
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_doctordata[index].doctorTopicConsultation}',
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
                                    'ผู้ให้คำปรึกษา : ${_doctordata[index].doctorName} ${_doctordata[index].doctorLastname}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  'วันเปิด : ${_doctordata[index].doctorDay}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  'เวลาทำการ : ${_doctordata[index].doctorTimeStart}-${_doctordata[index].doctorTimeEnd} น.',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  'จำนวนที่รับ : ${_doctordata[index].doctorQuantity} ท่าน',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Center(
                                  child: _doctordata[index].statusRegRoom ==
                                          'yes'
                                      ? Column(
                                          children: [
                                            IconButton(
                                              iconSize: 72,
                                              color: Colors.red,
                                              icon:
                                                  const Icon(Icons.video_call),
                                              tooltip: 'Increase volume by 10',
                                              onPressed: () async {
                                                launch(
                                                    "${_doctordata[index].link}");
                                              },
                                            ),
                                            Text(
                                                'ถึงเวลานัดคุยแล้ว :${_doctordata[index].datetimeVideocall}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                          ],
                                        )
                                      : Text(
                                          'เวลานัดคุย :${_doctordata[index].datetimeVideocall ??= "ยังไม่ได้นัดหมาย"}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
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
                                          child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      docregister_detail(
                                                        showid:
                                                            _doctordata[index],
                                                        refreshListTrigger:
                                                            refreshList,
                                                      )));
                                        },
                                        child: Text('รายละเอียด'),
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          // Create simple refresh button
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

    _doctordata.forEach((userDetail) {
      if (userDetail.doctorName.toLowerCase().contains(text) ||
          userDetail.id.toLowerCase().contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<ShowDoctordata> _searchResult = [];

List<ShowDoctordata> _doctordata = [];

// To parse this JSON data, do
//
//     final showDoctordata = showDoctordataFromJson(jsonString);

List<ShowDoctordata> showDoctordataFromJson(String str) =>
    List<ShowDoctordata>.from(
        json.decode(str).map((x) => ShowDoctordata.fromJson(x)));

String showDoctordataToJson(List<ShowDoctordata> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowDoctordata {
  ShowDoctordata({
    required this.id,
    required this.doctorName,
    required this.doctorLastname,
    required this.picture,
    required this.doctorTopicConsultation,
    required this.doctorDay,
    required this.doctorTimeStart,
    required this.doctorTimeEnd,
    required this.doctorQuantity,
    required this.statusRegRoom,
    required this.datetimeVideocall,
    required this.link,
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
  String statusRegRoom;
  dynamic datetimeVideocall;
  String link;

  factory ShowDoctordata.fromJson(Map<String, dynamic> json) => ShowDoctordata(
        id: json["id"],
        doctorName: json["doctor_name"],
        doctorLastname: json["doctor_lastname"],
        picture: json["picture"],
        doctorTopicConsultation: json["doctor_topic_consultation"],
        doctorDay: json["doctor_day"],
        doctorTimeStart: json["doctor_time_start"],
        doctorTimeEnd: json["doctor_time_end"],
        doctorQuantity: json["doctor_quantity"],
        statusRegRoom: json["status_reg_room"],
        datetimeVideocall: json["datetime_videocall"],
        link: json["Link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_name": doctorName,
        "doctor_lastname": doctorLastname,
        "picture": picture,
        "doctor_topic_consultation": doctorTopicConsultation,
        "doctor_day": doctorDay,
        "doctor_time_start": doctorTimeStart,
        "doctor_time_end": doctorTimeEnd,
        "doctor_quantity": doctorQuantity,
        "status_reg_room": statusRegRoom,
        "datetime_videocall": datetimeVideocall,
        "Link": link,
      };
}


// To parse this JSON data, do
// //
// //     final showDoctordata = showDoctordataFromJson(jsonString);
// // To parse this JSON data, do
// //
// //     final showDoctordata = showDoctordataFromJson(jsonString);

// List<ShowDoctordata> showDoctordataFromJson(String str) =>
//     List<ShowDoctordata>.from(
//         json.decode(str).map((x) => ShowDoctordata.fromJson(x)));

// String showDoctordataToJson(List<ShowDoctordata> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class ShowDoctordata {
//   ShowDoctordata({
//     required this.id,
//     required this.doctorName,
//     required this.doctorLastname,
//     required this.picture,
//     required this.doctorTopicConsultation,
//     required this.doctorDay,
//     required this.doctorTimeStart,
//     required this.doctorTimeEnd,
//     required this.doctorQuantity,
//   });

//   String id;
//   String doctorName;
//   String doctorLastname;
//   String picture;
//   String doctorTopicConsultation;
//   String doctorDay;
//   String doctorTimeStart;
//   String doctorTimeEnd;
//   String doctorQuantity;

//   factory ShowDoctordata.fromJson(Map<String, dynamic> json) => ShowDoctordata(
//         id: json["id"] == null ? null : json["id"],
//         doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
//         doctorLastname:
//             json["doctor_lastname"] == null ? null : json["doctor_lastname"],
//         picture: json["picture"] == null ? null : json["picture"],
//         doctorTopicConsultation: json["doctor_topic_consultation"] == null
//             ? null
//             : json["doctor_topic_consultation"],
//         doctorDay: json["doctor_day"] == null ? null : json["doctor_day"],
//         doctorTimeStart: json["doctor_time_start"] == null
//             ? null
//             : json["doctor_time_start"],
//         doctorTimeEnd:
//             json["doctor_time_end"] == null ? null : json["doctor_time_end"],
//         doctorQuantity:
//             json["doctor_quantity"] == null ? null : json["doctor_quantity"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "doctor_name": doctorName == null ? null : doctorName,
//         "doctor_lastname": doctorLastname == null ? null : doctorLastname,
//         "picture": picture == null ? null : picture,
//         "doctor_topic_consultation":
//             doctorTopicConsultation == null ? null : doctorTopicConsultation,
//         "doctor_day": doctorDay == null ? null : doctorDay,
//         "doctor_time_start": doctorTimeStart == null ? null : doctorTimeStart,
//         "doctor_time_end": doctorTimeEnd == null ? null : doctorTimeEnd,
//         "doctor_quantity": doctorQuantity == null ? null : doctorQuantity,
//       };
// }
