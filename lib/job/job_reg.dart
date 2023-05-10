import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Jobred extends StatefulWidget {
  const Jobred({Key? key}) : super(key: key);

  @override
  State<Jobred> createState() => _JobredState();
}

class _JobredState extends State<Jobred> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  List<Jobreddata> _showjobdata = [];

  //API สำหรับการ _Rgistertrain ลงทะเบียนฝึกอบรม รับค่าเป็น POST
  Future<void> _JobRed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    print('====== $userid');

    Uri url =
        Uri.parse('https://d4all-onde.com/api/webservice.php?service=job_reg');
    var response = await http.post(url, body: {
      "id": userid,
    });
    var data = json.decode(response.body);
    print("รายละเอียดข้อมูล Job Register");
    print(data);
    if (data['status'] == 'success') {
      setState(() {
        _showjobdata.clear();
        for (var user in data['message']) {
          _showjobdata.add(Jobreddata.fromJson(user));
        }
      });
    } else {
      setState(() {
        _showjobdata.clear();
      });
      print('error');
    }
  }

  Future<void> _JobUnreg(String job_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    print('====== $userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=job_resume_unregister');
    var response = await http.post(url, body: {
      "id": userid,
      "job_id": job_id,
    });
    var data = json.decode(response.body);
    print("ผลลัพธ์ API Job Unregister");
    print(data);
    if (data['status'] == 'success') {
      setState(() {
        _JobRed();
      });
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    super.initState();
    _JobRed(); //อัพเดทข้อมูลใหม่
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการยื่นสมัครงานของคุณ'),
      ),
      body: _showjobdata.length == 0
          ? Center(
              child: Text('ไม่มีข้อมูล'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _showjobdata.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    // ถ้าได้ค่าข้อมูลสุดท้าย
                    Center(
                      /** Card Widget **/
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.arrow_drop_down_circle),
                              title: Text(
                                _showjobdata[index].jobName,
                                style: TextStyle(fontSize: 25),
                              ),
                              subtitle: Text(
                                'สถานะการสมัคร: ${(_showjobdata[index].statusReg == 'yes' ? 'เรียบร้อย' : 'ยังไม่ได้สมัคร')}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'บริษัท: ${_showjobdata[index].companyName} \nอัตราเงินเดือน: ${_showjobdata[index].jobSalary} \nวันที่ยื่นสมัคร: ${_showjobdata[index].jobDate} \nรายละเอียดงาน: ${_showjobdata[index].jobDetail}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 18),
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.start,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {
                                    _JobUnreg(_showjobdata[index].jobId);
                                  },
                                  icon: Icon(Icons.delete, size: 18),
                                  label: Text("ยกเลิกการสมัคร"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
    );
  }
}
// To parse required this JSON data, do
//
//     final jobreddata = jobreddataFromJson(jsonString);

List<Jobreddata> jobreddataFromJson(String str) =>
    List<Jobreddata>.from(json.decode(str).map((x) => Jobreddata.fromJson(x)));

String jobreddataToJson(List<Jobreddata> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jobreddata {
  Jobreddata({
    required this.regId,
    required this.statusReg,
    required this.dateJobReg,
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

  String regId;
  String statusReg;
  String dateJobReg;
  String jobId;
  String jobName;
  String jobDetail;
  String jobType;
  String jobSalary;
  String jobQuantity;
  String jobUserClass;
  String jobDate;
  String companyName;

  factory Jobreddata.fromJson(Map<String, dynamic> json) => Jobreddata(
        regId: json["reg_id"],
        statusReg: json["status_reg"],
        dateJobReg: json["date_job_reg"],
        jobId: json["job_id"],
        jobName: json["job_name"],
        jobDetail: json["job_detail"],
        jobType: json["job_type"],
        jobSalary: json["job_salary"],
        jobQuantity: json["job_quantity"],
        jobUserClass: json["job_user_class"],
        jobDate: json["job_date"],
        companyName: json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "reg_id": regId,
        "status_reg": statusReg,
        "date_job_reg": dateJobReg,
        "job_id": jobId,
        "job_name": jobName,
        "job_detail": jobDetail,
        "job_type": jobType,
        "job_salary": jobSalary,
        "job_quantity": jobQuantity,
        "job_user_class": jobUserClass,
        "job_date": jobDate,
        "company_name": companyName,
      };
}
