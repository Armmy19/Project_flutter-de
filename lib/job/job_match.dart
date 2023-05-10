import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/job/job_match_to_match.dart';

class Jobmatch extends StatefulWidget {
  const Jobmatch({Key? key}) : super(key: key);

  @override
  State<Jobmatch> createState() => _JobmatchState();
}

class _JobmatchState extends State<Jobmatch> {
  ////////////////////////
  List<Jsonjobmatch> _Match = [];

  // Get json result and convert it to model. Then add
  Future<void> getJsonjobmatch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=job_match');
    var response = await http.post(url, body: {
      "id": userid,
    });
    var data = json.decode(response.body);
    print(data);
    if (data['status'] == 'success') {
      for (var user in data['message']) {
        _Match.add(Jsonjobmatch.fromJson(user));
      }
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    super.initState();
    //อัพเดทข้อมูลใหม่
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('งานที่ตรงตามความต้องการ'),
      ),
      body: FutureBuilder(
        future: getJsonjobmatch(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_Match.length != 0) {
              return ListView.builder(
                  itemCount: _Match.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          //-----------------------------------------------
                          Padding(
                            padding: EdgeInsetsDirectional.all(20),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_Match[index].jobName,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xCC62297B),
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 10),
                                      child: Text(_Match[index].jobDetail,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          )),
                                    ),
                                    Text(
                                      'กลุ่ม : ${_Match[index].jobUserClass}',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      'อัตราเงินเดือน : ${_Match[index].jobSalary} บาท',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      'อัตราจ้าง : ${_Match[index].jobQuantity} คน',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
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
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              print(
                                                _Match[index].jobId,
                                              );
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Jobdetail(
                                                              //คลาสของหน้ารับ(Jobdetail)
                                                              keyjobid: _Match[
                                                                  index]))); //key ของหน้ารับ(keyjobid)
                                            },
                                            icon: Icon(Icons.add, size: 18),
                                            label: Text("รายละเอียดงาน"),
                                          )
                                          // RaisedButton(
                                          //   shape: RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.circular(5),
                                          //   ),
                                          //   onPressed: () {
                                          //     print(
                                          //       _Match[index].jobId,
                                          //     );
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => Jobdetail(
                                          //                 //คลาสของหน้ารับ(Jobdetail)
                                          //                 keyjobid: _Match[
                                          //                     index]))); //key ของหน้ารับ(keyjobid)
                                          //   },
                                          //   color: Color(0xFF7968A6),
                                          //   child: Text(
                                          //     'รายละเอียดงาน',
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
                          //-----------------------------------------------------
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('ไม่พบงานตรงกับที่ท่านต้องการ'),
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
//     final jsonjobmatch = jsonjobmatchFromJson(jsonString);

List<Jsonjobmatch> jsonjobmatchFromJson(String str) => List<Jsonjobmatch>.from(
    json.decode(str).map((x) => Jsonjobmatch.fromJson(x)));

String jsonjobmatchToJson(List<Jsonjobmatch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jsonjobmatch {
  Jsonjobmatch({
    required this.jobId,
    required this.jobName,
    required this.jobDetail,
    required this.jobType,
    required this.jobSalary,
    required this.jobQuantity,
    required this.jobUserClass,
    required this.jobDate,
    required this.companyName,
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

  factory Jsonjobmatch.fromJson(Map<String, dynamic> json) => Jsonjobmatch(
        jobId: json["job_id"],
        jobName: json["job_name"],
        jobDetail: json["job_detail"],
        jobType: json["job_type"],
        jobSalary: json["job_salary"],
        jobQuantity: json["job_quantity"],
        jobUserClass: json["job_user_class"],
        jobDate: DateTime.parse(json["job_date"]),
        companyName: json["company_name"],
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
      };
}
