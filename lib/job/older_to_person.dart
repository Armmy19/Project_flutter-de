import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test/job/older_person.dart';

class Jobdata extends StatefulWidget {
  final Jobperson showid;
  const Jobdata({Key? key, required this.showid}) : super(key: key);

  @override
  State<Jobdata> createState() => _JobdataState();
}

class _JobdataState extends State<Jobdata> {
  late Jobperson showjobid;
  late Showjobdata showdata;
  @override
  void initState() {
    getJobperson();
    showjobid = widget.showid;
    print(showjobid.jobId);
    // TODO: implement initState
    super.initState();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ลงทะเบียนสำเร็จ'),
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

  Future<void> _showMyDialogDuplicate() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('คุณได้ลงทะเบียนไปแล้ว'),
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
  Future<void> getJobperson() async {
    showjobid = widget.showid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');

    Uri url =
        Uri.parse('https://d4all-onde.com/api/webservice.php?service=job_data');
    var response = await http.post(url, body: {
      "id": showjobid.jobId,
    });
    var data = json.decode(response.body);

    showdata = showjobdataFromJson(response.body);

    print(data);
    if (data["status"] == "success") {
    } else {
      print('error');
    }
  }

  //API สำหรับการ _Rgistertrain ลงทะเบียนฝึกอบรม รับค่าเป็น POST
  Future<void> _Rgistertrain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    showjobid = widget.showid;
    final id = await showjobid.jobId;
    print('====== $userid');
    print('====== $id');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=job_resume_register');
    var response = await http.post(url, body: {
      "id": userid,
      "job_id": id,
    });
    var data = json.decode(response.body);
    print("Job Resume Register");
    print(data);
    if (data["status"] == "success") {
      print('test $id');
      setState(() {
        _showMyDialog();
        Navigator.pop(context);
      });
    } else {
      _showMyDialogDuplicate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายละเอียดงาน"),
      ),
      body: FutureBuilder(
        future: getJobperson(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Widget> children;
          if (snapshot.connectionState == ConnectionState.done) {
            children = <Widget>[
              // Image.network(Showjobdata.picture),
              Column(
                children: [
                  // Image.network(showdata.message.profileImg),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            '${showdata.message.jobName}',
                            style:
                                TextStyle(fontSize: 18, color: Colors.purple),
                          ),
                          subtitle: Text(
                            'กลุ่มงาน : ${showdata.message.jobUserClass}  \nอัตราเงินเดือน : ${showdata.message.jobSalary} บาท \nอัตราจ้าง : ${showdata.message.jobQuantity} คน \nที่อยู่ : ${showdata.message.companyHouseNum}/${showdata.message.companyVillageNum} ต.${showdata.message.companySubdistrict} อ.${showdata.message.companyDistrict} จ.${showdata.message.companyProvince} ไปรษณีย์ ${showdata.message.companyPostalcode} \nรายละเอียดงาน : ${showdata.message.jobDetail}',
                            style: TextStyle(
                                color: Color.fromARGB(255, 7, 7, 7)
                                    .withOpacity(0.9)),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                _Rgistertrain();
                              },
                              icon: Icon(Icons.add, size: 18),
                              label: Text("ลงทะเบียน"),
                            )
                            // FlatButton(
                            //   textColor: const Color(0xFF6200EE),
                            //   onPressed: () {
                            //     _Rgistertrain();
                            //   },
                            //   child: const Text('ลงทะเบียน'),
                            // ),
                          ],
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

// To parse required this JSON data, do
//
//     final showjobdata = showjobdataFromJson(jsonString);

Showjobdata showjobdataFromJson(String str) =>
    Showjobdata.fromJson(json.decode(str));

String showjobdataToJson(Showjobdata data) => json.encode(data.toJson());

class Showjobdata {
  Showjobdata({
    required this.status,
    required this.message,
  });

  String status;
  Message message;

  factory Showjobdata.fromJson(Map<String, dynamic> json) => Showjobdata(
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
    required this.jobId,
    required this.jobName,
    required this.jobDetail,
    required this.jobType,
    required this.jobSalary,
    required this.jobQuantity,
    required this.jobUserClass,
    required this.jobDate,
    required this.companyName,
    required this.companyAbout,
    required this.companyPhone,
    required this.companyEmail,
    required this.profileImg,
    required this.companyLatitude,
    required this.companyLongitude,
    required this.companyHouseNum,
    required this.companyVillageNum,
    required this.companyAlleylane,
    required this.companyRoad,
    required this.companySubdistrict,
    required this.companyDistrict,
    required this.companyProvince,
    required this.companyPostalcode,
  });

  String jobId;
  String jobName;
  String jobDetail;
  String jobType;
  String jobSalary;
  String jobQuantity;
  String jobUserClass;
  DateTime jobDate;
  String companyName;
  String companyAbout;
  String companyPhone;
  String companyEmail;
  String profileImg;
  String companyLatitude;
  String companyLongitude;
  String companyHouseNum;
  String companyVillageNum;
  String companyAlleylane;
  String companyRoad;
  String companySubdistrict;
  String companyDistrict;
  String companyProvince;
  String companyPostalcode;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        jobId: json["job_id"],
        jobName: json["job_name"],
        jobDetail: json["job_detail"],
        jobType: json["job_type"],
        jobSalary: json["job_salary"],
        jobQuantity: json["job_quantity"],
        jobUserClass: json["job_user_class"],
        jobDate: DateTime.parse(json["job_date"]),
        companyName: json["company_name"],
        companyAbout: json["company_about"],
        companyPhone: json["company_phone"],
        companyEmail: json["company_email"],
        profileImg: json["profile_img"],
        companyLatitude: json["company_latitude"],
        companyLongitude: json["company_longitude"],
        companyHouseNum: json["company_houseNum"],
        companyVillageNum: json["company_villageNum"],
        companyAlleylane: json["company_alleylane"],
        companyRoad: json["company_road"],
        companySubdistrict: json["company_subdistrict"],
        companyDistrict: json["company_district"],
        companyProvince: json["company_province"],
        companyPostalcode: json["company_postalcode"],
      );

  Map<String, dynamic> toJson() => {
        "job_id": jobId,
        "job_name": jobName,
        "job_detail": jobDetail,
        "job_type": jobType,
        "job_salary": jobSalary,
        "job_quantity": jobQuantity,
        "job_user_class": jobUserClass,
        "job_date":
            "${jobDate.year.toString().padLeft(4, '0')}-${jobDate.month.toString().padLeft(2, '0')}-${jobDate.day.toString().padLeft(2, '0')}",
        "company_name": companyName,
        "company_about": companyAbout,
        "company_phone": companyPhone,
        "company_email": companyEmail,
        "profile_img": profileImg,
        "company_latitude": companyLatitude,
        "company_longitude": companyLongitude,
        "company_houseNum": companyHouseNum,
        "company_villageNum": companyVillageNum,
        "company_alleylane": companyAlleylane,
        "company_road": companyRoad,
        "company_subdistrict": companySubdistrict,
        "company_district": companyDistrict,
        "company_province": companyProvince,
        "company_postalcode": companyPostalcode,
      };
}
