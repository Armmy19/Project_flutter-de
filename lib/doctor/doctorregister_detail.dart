import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test/doctor/doctorregister.dart';
import 'package:url_launcher/url_launcher.dart';

class docregister_detail extends StatefulWidget {
  final ShowDoctordata showid;
  final Future<void> Function() refreshListTrigger;

  const docregister_detail(
      {Key? key, required this.showid, required this.refreshListTrigger})
      : super(key: key);

  @override
  State<docregister_detail> createState() => _docregister_detailState();
}

class _docregister_detailState extends State<docregister_detail> {
  late ShowDoctordata showdocid;
  late ShowRgdoctordata showdata;

  _launchURLBrowser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    final url =
        'https://addpaycrypto.com/mdes_new/doctor/room_call.php?room_call=$userid';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    getShowDoctor();
    showdocid = widget.showid;
    // TODO: implement initState
    super.initState();
  }

  Future<void> _showMyDialog_data() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยกเลิกสำเร็จ'),
          actions: <Widget>[
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //API สำหรับการ แสดงรายการ รับค่าเป็น POST
  Future<void> getShowDoctor() async {
    showdocid = widget.showid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=health_data');
    var response = await http.post(url, body: {
      "id": showdocid.id,
      "id_user": userid,
    });
    var data = json.decode(response.body);
    showdata = showRgdoctordataFromJson(response.body);
  }

  //API สำหรับการ _Rgistertrain ลงทะเบียนฝึกอบรม รับค่าเป็น POST
  Future<void> _unregister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    showdocid = widget.showid;
    final id = await showdocid.id;

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=health_unregister');
    var response = await http.post(url, body: {
      "id": id,
      "id_user": userid,
    });
    var data = json.decode(response.body);
    if (data["status"] == "success") {
      setState(() {
        _showMyDialog_data();
        // Remove the previous page
        Navigator.pop(context);
        widget.refreshListTrigger();

        // How to Navigator.pop(context) then reload the screen?
      });
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายละเอียดห้องให้คำปรึกษา"),
      ),
      body: FutureBuilder(
        future: getShowDoctor(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Widget> children;
          if (snapshot.connectionState == ConnectionState.done) {
            children = <Widget>[
              // Image.network(showdata.picture),
              Column(
                children: [
                  // Image.network(showdata.picture),

                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            '${showdata.message.picture}',
                            width: 100,
                            height: 100,
                            // fit: BoxFit.cover,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '${showdata.message.doctorTopicConsultation}',
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF7968A6)),
                          ),
                          subtitle: Text(
                            '\nรายละเอียดหัวข้อ : ${showdata.message.doctorExpertise} \nผู้ให้คำปรึกษา : ${showdata.message.userName} ${showdata.message.userLastname} บาท \nเลขที่ใบอนุญาต : ${showdata.message.doctorLicenseNumber} \nวันที่เปิด : ${showdata.message.doctorDay} \nเปิด - ปิด ทำการเวลา  : ${showdata.message.doctorTimeStart} - ${showdata.message.doctorTimeEnd} น. \nจำนวนที่เปิดรับต่อวัน : ${showdata.message.doctorQuantity} ท่าน',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 7, 7, 7)
                                    .withOpacity(0.9)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                onPressed: () {
                                  _unregister();
                                },
                                child: Text('ยกเลิก'),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[LinearProgressIndicator()];
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Container(
                child: ListView(
                  children: children,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final showRgdoctordata = showRgdoctordataFromJson(jsonString);

ShowRgdoctordata showRgdoctordataFromJson(String str) =>
    ShowRgdoctordata.fromJson(json.decode(str));

String showRgdoctordataToJson(ShowRgdoctordata data) =>
    json.encode(data.toJson());

class ShowRgdoctordata {
  ShowRgdoctordata({
    required this.status,
    required this.message,
  });

  String status;
  Message message;

  factory ShowRgdoctordata.fromJson(Map<String, dynamic> json) =>
      ShowRgdoctordata(
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
    required this.userName,
    required this.userLastname,
    required this.picture,
    required this.doctorLicenseNumber,
    required this.doctorExpertise,
    required this.doctorTopicConsultation,
    required this.doctorDay,
    required this.doctorTopicAbout,
    required this.doctorTimeStart,
    required this.doctorTimeEnd,
    required this.doctorQuantity,
    required this.totalRegistered,
    required this.canRegis,
  });

  String id;
  String userName;
  String userLastname;
  String picture;
  String doctorLicenseNumber;
  String doctorExpertise;
  String doctorTopicConsultation;
  String doctorDay;
  String doctorTopicAbout;
  String doctorTimeStart;
  String doctorTimeEnd;
  String doctorQuantity;
  String totalRegistered;
  int canRegis;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        userName: json["user_name"],
        userLastname: json["user_lastname"],
        picture: json["picture"],
        doctorLicenseNumber: json["doctor_license_number"],
        doctorExpertise: json["doctor_expertise"],
        doctorTopicConsultation: json["doctor_topic_consultation"],
        doctorDay: json["doctor_day"],
        doctorTopicAbout: json["doctor_topic_about"],
        doctorTimeStart: json["doctor_time_start"],
        doctorTimeEnd: json["doctor_time_end"],
        doctorQuantity: json["doctor_quantity"],
        totalRegistered: json["total_registered"],
        canRegis: json["can_regis"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "user_lastname": userLastname,
        "picture": picture,
        "doctor_license_number": doctorLicenseNumber,
        "doctor_expertise": doctorExpertise,
        "doctor_topic_consultation": doctorTopicConsultation,
        "doctor_day": doctorDay,
        "doctor_topic_about": doctorTopicAbout,
        "doctor_time_start": doctorTimeStart,
        "doctor_time_end": doctorTimeEnd,
        "doctor_quantity": doctorQuantity,
        "total_registered": totalRegistered,
        "can_regis": canRegis,
      };
}
