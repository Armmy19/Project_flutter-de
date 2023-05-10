import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test/train/list_to_train.dart';

class ListRegistertrain extends StatefulWidget {
  const ListRegistertrain({Key? key}) : super(key: key);

  @override
  State<ListRegistertrain> createState() => _ListRegistertrainState();
}

class _ListRegistertrainState extends State<ListRegistertrain> {
  late Listtotrain showid;
  String? deleleid;
  TextEditingController searchTextController = new TextEditingController();

  Future<Null> delele() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      deleleid = prefs.getString('userid')!;
    });
  }

  ////////////list รายการลงทะเบียนคอสอบรม ///////////
  Future<void> _listRgistertrain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    print('====== $userid');

    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=training_course_registered');
    final response = await http.post(url, body: {
      "id": userid,
    });
    final responseJson = json.decode(response.body);
    if (responseJson['status'] == 'success') {
      result_data = responseJson['message'];
    } else {
      result_data = [];
    }
  }

  //API สำหรับการ ยกเลิกการลงทะเบียนฝึกอบรม รับค่าเป็น POST
  Future<void> _Deleltrain(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');
    print('====== $id');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=training_course_unregister');
    var response = await http.post(url, body: {
      "id": userid,
      "course": id,
    });
    var data = json.decode(response.body);
    if (data["status"] == "success") {
      setState(() {
        _listRgistertrain();
      });
    } else {
      print('error');
    }
  }

////////////////////////////////////////////////////
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delele();
    _userDetails.clear(); //การลบข้อมูลก่อนหน้า
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deleleid == null
            ? 'รายการลงทะเบียน'
            : 'รายการลงทะเบียน id $deleleid'),
      ),
      body: FutureBuilder(
        future: _listRgistertrain(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (result_data.length == 0) {
              return Center(
                child: Text('ไม่มีรายการลงทะเบียน'),
              );
            } else {
              return new Column(
                children: <Widget>[
                  new Expanded(
                    child: new ListView.builder(
                      itemCount: result_data.length,
                      itemBuilder: (context, index) {
                        return new Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'ชื่อ : ${result_data[index]['name']}',
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'สถานที่ : ${result_data[index]['location']}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'วันที่ : ${result_data[index]['date']}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'จำนวนผู้เข้าร่วม : ${result_data[index]['registered']}/${result_data[index]['participants']}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        String id = result_data[index]['id'];
                                        // Ask for confirmation
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("ยืนยันการลบ"),
                                              content: Text(
                                                  "คุณต้องการยกเลิกการลงทะเบียนใช่หรือไม่"),
                                              actions: [
                                                TextButton(
                                                  child: Text("ยกเลิก"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("ยืนยัน"),
                                                  onPressed: () {
                                                    // Close the dialog
                                                    _Deleltrain(id);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Text("ยกเลิกลงทะเบียน"),
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

// Create list to store data from API in json format
var result_data = [];

List<Showuserregister> _userDetails = [];

List<Showuserregister> showuserregisterFromJson(String str) =>
    List<Showuserregister>.from(
        json.decode(str).map((x) => Showuserregister.fromJson(x)));

String showuserregisterToJson(List<Showuserregister> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Showuserregister {
  Showuserregister({
    required this.id,
    required this.fname,
    required this.lname,
    required this.showuserregisterClass,
    required this.tel,
    required this.email,
    required this.province,
  });

  String id;
  String fname;
  String lname;
  String showuserregisterClass;
  String tel;
  String email;
  String province;

  factory Showuserregister.fromJson(Map<String, dynamic> json) =>
      Showuserregister(
        id: json["id"] == null ? null : json["id"],
        fname: json["fname"] == null ? null : json["fname"],
        lname: json["lname"] == null ? null : json["lname"],
        showuserregisterClass: json["class"] == null ? null : json["class"],
        tel: json["tel"] == null ? null : json["tel"],
        email: json["email"] == null ? null : json["email"],
        province: json["province"] == null ? null : json["province"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "fname": fname == null ? null : fname,
        "lname": lname == null ? null : lname,
        "class": showuserregisterClass == null ? null : showuserregisterClass,
        "tel": tel == null ? null : tel,
        "email": email == null ? null : email,
        "province": province == null ? null : province,
      };
}
