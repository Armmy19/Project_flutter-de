import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/Dataresume.dart';
import 'package:test/api/showprofile.dart';
import 'package:test/job/edit_resume.dart';

class Rasume extends StatefulWidget {
  const Rasume({Key? key}) : super(key: key);

  @override
  State<Rasume> createState() => _RasumeState();
}

class _RasumeState extends State<Rasume> {
  late Dataresume Showresume;
  String? profile;
  late ProfileShow show;
  Future<void> Profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=user_profile');
    var response = await http.post(url, body: {
      "id": '$userid',
    });
    var data = json.decode(response.body);
    show = profileShowFromJson(response.body);

    if (data["status"] == "success") {
      setState(() {
        profile = show.message.profileImg;
      });
      print(data);
    } else {
      print('error');
    }
  }

  //API สำหรับการ _Rgistertrain ลงทะเบียนฝึกอบรม รับค่าเป็น POST
  Future<Null> _getresume() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    print('====== $userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=job_resume');
    var response = await http.post(url, body: {
      "id": userid,
    });
    var data = json.decode(response.body);
    print("ASD");
    Showresume = dataresumeFromJson(response.body);
    print("DEF");
  }

  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _getresume();
    });
  }

  @override
  void initState() {
    Profile();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: FutureBuilder<void>(
        // กำหนดชนิดข้อมูล
        future: _getresume(), // ข้อมูล Future
        //builder: (BuildContext context, AsyncSnapshot snapshot) {
        builder: (context, snapshot) {
          // สร้าง widget เมื่อได้ค่า snapshot ข้อมูลสุดท้าย
          if (snapshot.connectionState == ConnectionState.done) {
            // ถ้าได้ค่าข้อมูลสุดท้าย
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage('$profile'),
                                  fit: BoxFit.cover)),
                          child: Container(
                            width: double.infinity,
                            height: 200,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          color: Color(0xCC45156C),
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Center(
                                child: Text(
                              'ชื่อ : ${Showresume.message.userName + ' ' + '${Showresume.message.userLastname}'}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                            subtitle: Center(
                                child: Text(
                              'กลุ่ม : ${Showresume.message.userClass} \nเพศ : ${Showresume.message.userGender ??= "-"}  \nอีเมล : ${Showresume.message.userEmail} \nหมายเลขติดต่อ : ${Showresume.message.userPhone}',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Color(0xCC45156C),
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Center(
                                child: Text(
                              'งานที่ต้องการ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                            subtitle: Center(
                                child: Text(
                              'ประเภทงาน : ${Showresume.message.resumeJobTypeInterested ??= "-"}  \nประมาณการอัตราเงินเดือน : ${Showresume.message.resumeRequiredSalary ??= "-"} บาท',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Color(0xCC45156C),
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Center(
                                child: Text(
                              'คุณสมบัติผู้สมัครงาน',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                            subtitle: Center(
                                child: Text(
                              'วุฒิการศึกษาสูงสุด : ${Showresume.message.resumeGraduation ??= "-"} \nจบการศึกษาที่ : ${Showresume.message.resumeEducationalPlace ??= "-"} \nความสามารถด้านภาษาอังกฤษ : ${Showresume.message.resumeLanguageAbility ??= "-"} \nความสามารถด้านคอมพิวเตอร์ : ${Showresume.message.resumeComputerSkills ??= "-"} ',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Color(0xCC45156C),
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Center(
                                child: Text(
                              'ประสบการณ์ในการทำงาน',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                            subtitle: Center(
                                child: Text(
                              '- ${Showresume.message.resumeHistoryWork ??= "-"}  \n- ${Showresume.message.userClass}',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Color(0xCC45156C),
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Center(
                                child: Text(
                              'ประสบการณ์ในการอบรม',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                            subtitle: Center(
                                child: Text(
                              '- ${Showresume.message.resumeTraining ??= "-"} \n',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Color(0xCC45156C),
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Center(
                                child: Text(
                              'เกียรติบัตร/รางวัลที่ได้รับ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                            subtitle: Center(
                                child: Text(
                              '- ${Showresume.message.resumeAwarded ??= "-"} \n',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Color(0xCC45156C),
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Center(
                                child: Text(
                              'ที่อยู่ผู้สมัครงาน',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                            subtitle: Center(
                                child: Text(
                              'บ้านเลขที่ : ${Showresume.message.userHouseNum ??= "-"} \nถนน : ${Showresume.message.userRoad ??= "-"} \nแขวง/ตำบล : ${Showresume.message.userSubdistrict ??= "-"} \nเขต/อำเภอ : ${Showresume.message.userDistrict ??= "-"} \nจังหวัด : ${Showresume.message.userProvince ??= "-"} \nรหัสไปรษณีย์ : ${Showresume.message.userPostalcode ??= "-"}',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            // ถ้ามี error
            return Text('${snapshot.error}');
          }
          // ค่าเริ่มต้น, แสดงตัว Loading.สถานะ ConnectionState.waiting
          return Center(child: const CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Editresume(
                        refresh: refresh,
                      )));
        },
        label: Text("แก้ไข Resume"),
        icon: Icon(Icons.edit),
        backgroundColor: Color.fromARGB(204, 200, 70, 81),
      ),
    );
  }
}
