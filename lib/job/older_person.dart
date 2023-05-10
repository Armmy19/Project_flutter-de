import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/job/older_to_person.dart';

class Person extends StatefulWidget {
  const Person({Key? key}) : super(key: key);

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  ////////////////////////
  TextEditingController searchTextController = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<void> getJobperson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=job_disabled');
    var response = await http.post(url, body: {
      "id": userid,
    });
    var data = json.decode(response.body);
    print(data);
    if (data['status']  == 'success') {
      setState(() {
        for (var user in data['message']) {
        _jobperson.add(Jobperson.fromJson(user));
      }
      });
      
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    super.initState();

    _jobperson.clear(); //การลบข้อมูลก่อนหน้า
    getJobperson(); //อัพเดทข้อมูลใหม่
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการรับสมัครงาน'),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Image.network(
                            //   _searchResult[i].picture,
                            //   //https://via.placeholder.com/150
                            //   height: 100,
                            //   width: 100,
                            // ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      '${_searchResult[i].jobName}',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.purple),
                                    ),
                                    subtitle: Text(
                                      'กลุ่มงาน : ${_searchResult[i].jobUserClass}  \nอัตราเงินเดือน : ${_searchResult[i].jobSalary} บาท \nอัตราจ้าง : ${_searchResult[i].jobQuantity} คน \nรายละเอียดงาน : ${_searchResult[i].jobDetail}',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0)
                                              .withOpacity(0.9)),
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      String jobId = _jobperson[i].jobId;
                                      print(jobId);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Jobdata(
                                                  showid: _jobperson[i])));
                                    },
                                    child: Text("รายละเอียด"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : new ListView.builder(
                    itemCount: _jobperson.length,
                    itemBuilder: (context, index) {
                      return new Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Image.network(
                            //   _jobperson[index].picture,
                            //   //https://via.placeholder.com/150
                            //   height: 100,
                            //   width: 100,
                            // ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListTile(
                                    title: Text(
                                      '${_jobperson[index].jobName}',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.purple),
                                    ),
                                    subtitle: Text(
                                      'กลุ่มงาน : ${_jobperson[index].jobUserClass}  \nอัตราเงินเดือน : ${_jobperson[index].jobSalary} บาท \nอัตราจ้าง : ${_jobperson[index].jobQuantity} คน \nรายละเอียดงาน : ${_jobperson[index].jobDetail}',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0)
                                              .withOpacity(0.9)),
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      String jobId = _jobperson[index].jobId;
                                      print(jobId);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Jobdata(
                                                  showid: _jobperson[index])));
                                    },
                                    child: Text("รายละเอียด"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
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

    _jobperson.forEach((userDetail) {
      if (userDetail.jobName.toLowerCase().contains(text) ||
          userDetail.jobId.toLowerCase().contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<Jobperson> _searchResult = [];

List<Jobperson> _jobperson = [];

// // To parse this JSON data, do
// //
// //     final jobperson = jobpersonFromJson(jsonString);

// Jobperson jobpersonFromJson(String str) => Jobperson.fromJson(json.decode(str));

// String jobpersonToJson(Jobperson data) => json.encode(data.toJson());

// class Jobperson {
//   Jobperson({
//     required this.jobId,
//     required this.jobName,
//     required this.jobDetail,
//     required this.jobType,
//     required this.jobSalary,
//     required this.jobQuantity,
//     required this.jobUserClass,
//     required this.jobDate,
//     required this.companyName,
//   });

//   String jobId;
//   String jobName;
//   String jobDetail;
//   String jobType;
//   String jobSalary;
//   String jobQuantity;
//   String jobUserClass;
//   String jobDate;
//   String companyName;

//   factory Jobperson.fromJson(Map<String, dynamic> json) => Jobperson(
//         jobId: json["job_id"] == null ? null : json["job_id"],
//         jobName: json["job_name"] == null ? null : json["job_name"],
//         jobDetail: json["job_detail"] == null ? null : json["job_detail"],
//         jobType: json["job_type"] == null ? null : json["job_type"],
//         jobSalary: json["job_salary"] == null ? null : json["job_salary"],
//         jobQuantity: json["job_quantity"] == null ? null : json["job_quantity"],
//         jobUserClass:
//             json["job_user_class"] == null ? null : json["job_user_class"],
//         jobDate: json["job_date"] == null ? null : json["job_date"],
//         companyName: json["company_name"] == null ? null : json["company_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "job_id": jobId == null ? null : jobId,
//         "job_name": jobName == null ? null : jobName,
//         "job_detail": jobDetail == null ? null : jobDetail,
//         "job_type": jobType == null ? null : jobType,
//         "job_salary": jobSalary == null ? null : jobSalary,
//         "job_quantity": jobQuantity == null ? null : jobQuantity,
//         "job_user_class": jobUserClass == null ? null : jobUserClass,
//         "job_date": jobDate == null ? null : jobDate,
//         "company_name": companyName == null ? null : companyName,
//       };
// }
// To parse this JSON data, do
//
//     final jobperson = jobpersonFromJson(jsonString);


// To parse this JSON data, do
//
//     final jobperson = jobpersonFromJson(jsonString);



List<Jobperson> jobpersonFromJson(String str) => List<Jobperson>.from(json.decode(str).map((x) => Jobperson.fromJson(x)));

String jobpersonToJson(List<Jobperson> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jobperson {
    Jobperson({
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
    dynamic jobType;
    String jobSalary;
    String jobQuantity;
    String jobUserClass;
    DateTime jobDate;
    String companyName;

    factory Jobperson.fromJson(Map<String, dynamic> json) => Jobperson(
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
        "job_date": "${jobDate.year.toString().padLeft(4, '0')}-${jobDate.month.toString().padLeft(2, '0')}-${jobDate.day.toString().padLeft(2, '0')}",
        "company_name": companyName,
    };
}
