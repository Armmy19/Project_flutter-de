import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/job/job_match.dart';

class Jobdetail extends StatefulWidget {
  //1.การ set รับค่าจากหน้าส่ง
  final Jsonjobmatch
      keyjobid; //สร้างตัวแปรรับค่า json data(Jsonjobmatch) จากหน้าส่ง
  const Jobdetail({Key? key, required this.keyjobid})
      : super(key: key); //การกำหนด key (required this.keyjobid)
  @override
  State<Jobdetail> createState() => _JobdetailState();
}

//---------------------------------------------------------
class _JobdetailState extends State<Jobdetail> {
  //2.การตัวแปร key ที่สร้างไว้มา where แสดงผล

  late Jsonjobmatch
      showid; //สร้างตัวแปรรับค่า json data(Jsonjobmatch) จากหน้าส่ง
  late Jsonjobdetail
      showdetail; //สร้างตัวแปรรับค่า json data(Jsonjobdetail) จาก dark json
  @override
  void initState() {
    //ทำการจับคู่ตัวแปร keyjobid กับ showid
    // TODO: implement initState
    super.initState();
    //สั่งให้เรียกฟังชั่น (showjobdetail) เพื่อแสดงข้อมูลอัตโนมัติ
    showid = widget.keyjobid; //การจับคู่
    print(showid.jobId); //สั่งแสดงผลที่ละค่า
  }

  Future<Null> showjobdetail() async {
    //กำหนดชื่อฟังชั่นใหม่ เพื่อจะดึงข้อมูลจากลิงค์ api
    showid = widget.keyjobid; //การจับคู่
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    Uri url =
        Uri.parse('https://d4all-onde.com/api/webservice.php?service=job_data');
    var response = await http.post(url, body: {
      "id": showid.jobId,
    });
    var data = json.decode(response.body);
    print(data);
    showdetail = JsonjobdetailFromJson(response.body);
    if (data['status'] == 'success') {
    } else {
      print('error');
    }

    //จับคู่ตัว (showdetail) กับ dart json
  }

  // String function that add , to the number every 3 digits
  String addComma(String number) {
    var result = '';
    var count = 0;
    for (var i = number.length - 1; i >= 0; i--) {
      result = number[i] + result;
      count++;
      if (count == 3 && i != 0) {
        result = ',' + result;
        count = 0;
      }
    }
    return result;
  }

  Future<void> _Rgistertrain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    showid = widget.keyjobid;

    print('====== $userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=job_resume_register');
    var response = await http.post(url, body: {
      "id": userid,
      "job_id": showid.jobId,
    });
    var data = json.decode(response.body);

    print(data);
    if (data["status"] == "success") {
      setState(() {
        _showMyDialog();
      });
    } else {
      print('error');
    }
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

//---------------------------------------------------------
  @override //แสดงผลในแอพ
  Widget build(BuildContext context) {
    //3.การแสดงผล ui ของมือถือ
    return Scaffold(
      //Ui ทุกอย่างต้องอยู่ใน Scaffold
      appBar: AppBar(
        title: Text('Job Detail'),
      ),
      body: FutureBuilder<void>(
        // กำหนดชนิดข้อมูล
        future: showjobdetail(), // ข้อมูล Future
        //builder: (BuildContext context, AsyncSnapshot snapshot) {
        builder: (context, snapshot) {
          // สร้าง widget เมื่อได้ค่า snapshot ข้อมูลสุดท้าย
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsDirectional.all(20),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      '${showdetail.message.profileImg}',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'บริษัท',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            '${showdetail.message.companyName}',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 10),
                                child: Text(
                                  'ที่อยู่บริษัท : ที่อยู่ : ${showdetail.message.companyHouseNum} ม.${showdetail.message.companyVillageNum} ต.${showdetail.message.companySubdistrict} อ.${showdetail.message.companyDistrict} จ.${showdetail.message.companyProvince} ${showdetail.message.companyPostalcode} ',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Text(showdetail.message.jobName,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xCC62297B),
                                      fontSize: 24,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 10),
                                child: Text(showdetail.message.jobDetail,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ),
                              Text(
                                'กลุ่ม : ${showdetail.message.jobUserClass} ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                'อัตราเงินเดือน : ${addComma(showdetail.message.jobSalary)} บาท',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: Text(
                                  'อัตราจ้าง : ${showdetail.message.jobQuantity} คน',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        _Rgistertrain();
                                        print(
                                          showdetail.message.jobName,
                                        );
                                      },
                                      icon: Icon(Icons.input, size: 18),
                                      label: Text("ลงทะเบียน"),
                                    )
                                    // RaisedButton(
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(5),
                                    //   ),
                                    //   onPressed: () {
                                    //     _Rgistertrain();
                                    //     print(
                                    //       showdetail.jobName,
                                    //     );
                                    //     // Navigator.push(
                                    //     //     context,
                                    //     //     MaterialPageRoute(
                                    //     //         builder: (context) => Jobdetail(
                                    //     //             //คลาสของหน้ารับ(Jobdetail)
                                    //     //             keyjobid: showdetail.jobName))); //key ของหน้ารับ(keyjobid)
                                    //   },
                                    //   color: Color(0xFF7968A6),
                                    //   child: Text(
                                    //     'ลงทะเบียน',
                                    //     style: TextStyle(color: Colors.white),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            );
          } else if (snapshot.hasError) {
            // ถ้ามี error
            return Text('${snapshot.error}');
          }
          // ค่าเริ่มต้น, แสดงตัว Loading.สถานะ ConnectionState.waiting
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}

// // To parse this JSON data, do
// //
// //     final jsonjobdetail = jsonjobdetailFromJson(jsonString);

// Jsonjobdetail jsonjobdetailFromJson(String str) =>
//     Jsonjobdetail.fromJson(json.decode(str));

// String jsonjobdetailToJson(Jsonjobdetail data) => json.encode(data.toJson());

// class Jsonjobdetail {
//   Jsonjobdetail({
//     required this.jobName,
//     required this.jobDetail,
//     required this.jobType,
//     required this.jobSalary,
//     required this.jobQuantity,
//     required this.jobUserClass,
//     required this.jobDate,
//     required this.companyName,
//     required this.companyAbout,
//     required this.companyPhone,
//     required this.companyEmail,
//     required this.profileImg,
//     required this.companyLatitude,
//     required this.companyLongitude,
//     required this.companyHouseNum,
//     required this.companyVillageNum,
//     required this.companyAlleylane,
//     required this.companyRoad,
//     required this.companySubdistrict,
//     required this.companyDistrict,
//     required this.companyProvince,
//     required this.companyPostalcode,
//   });

//   String jobName;
//   String jobDetail;
//   String jobType;
//   String jobSalary;
//   String jobQuantity;
//   String jobUserClass;
//   DateTime jobDate;
//   String companyName;
//   String companyAbout;
//   String companyPhone;
//   String companyEmail;
//   String profileImg;
//   String companyLatitude;
//   String companyLongitude;
//   String companyHouseNum;
//   String companyVillageNum;
//   String companyAlleylane;
//   String companyRoad;
//   String companySubdistrict;
//   String companyDistrict;
//   String companyProvince;
//   String companyPostalcode;

//   factory Jsonjobdetail.fromJson(Map<String, dynamic> json) => Jsonjobdetail(
//         jobName: json["job_name"],
//         jobDetail: json["job_detail"],
//         jobType: json["job_type"],
//         jobSalary: json["job_salary"],
//         jobQuantity: json["job_quantity"],
//         jobUserClass: json["job_user_class"],
//         jobDate: DateTime.parse(json["job_date"]),
//         companyName: json["company_name"],
//         companyAbout: json["company_about"],
//         companyPhone: json["company_phone"],
//         companyEmail: json["company_email"],
//         profileImg: json["profile_img"],
//         companyLatitude: json["company_latitude"],
//         companyLongitude: json["company_longitude"],
//         companyHouseNum: json["company_houseNum"],
//         companyVillageNum: json["company_villageNum"],
//         companyAlleylane: json["company_alleylane"],
//         companyRoad: json["company_road"],
//         companySubdistrict: json["company_subdistrict"],
//         companyDistrict: json["company_district"],
//         companyProvince: json["company_province"],
//         companyPostalcode: json["company_postalcode"],
//       );

//   Map<String, dynamic> toJson() => {
//         "job_name": jobName,
//         "job_detail": jobDetail,
//         "job_type": jobType,
//         "job_salary": jobSalary,
//         "job_quantity": jobQuantity,
//         "job_user_class": jobUserClass,
//         "job_date":
//             "${jobDate.year.toString().padLeft(4, '0')}-${jobDate.month.toString().padLeft(2, '0')}-${jobDate.day.toString().padLeft(2, '0')}",
//         "company_name": companyName,
//         "company_about": companyAbout,
//         "company_phone": companyPhone,
//         "company_email": companyEmail,
//         "profile_img": profileImg,
//         "company_latitude": companyLatitude,
//         "company_longitude": companyLongitude,
//         "company_houseNum": companyHouseNum,
//         "company_villageNum": companyVillageNum,
//         "company_alleylane": companyAlleylane,
//         "company_road": companyRoad,
//         "company_subdistrict": companySubdistrict,
//         "company_district": companyDistrict,
//         "company_province": companyProvince,
//         "company_postalcode": companyPostalcode,
//       };
// }

Jsonjobdetail JsonjobdetailFromJson(String str) =>
    Jsonjobdetail.fromJson(json.decode(str));

String JsonjobdetailToJson(Jsonjobdetail data) => json.encode(data.toJson());

class Jsonjobdetail {
  Jsonjobdetail({
    required this.status,
    required this.message,
  });

  String status;
  Message message;

  factory Jsonjobdetail.fromJson(Map<String, dynamic> json) => Jsonjobdetail(
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
