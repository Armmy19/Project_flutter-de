import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/job/edit_resume.dart';
import 'package:test/job/job_match.dart';
import 'package:test/job/job_reg.dart';
import 'package:test/job/older_person.dart';
import 'package:test/job/resume.dart';

class Job_main extends StatefulWidget {
  const Job_main({Key? key}) : super(key: key);

  @override
  State<Job_main> createState() => _Job_mainState();
}

class _Job_mainState extends State<Job_main> {
  String? user_class;
  final TextEditingController controller = TextEditingController(
      text:
          'เมนูสำหรับการค้นหางาน ประกอบไปด้วย เมนูเรชูเม่ของคุณ เมนูงานที่ตรงตามความต้องการของคุณ เมนูค้นหางานสำหรับผู้สูงอายุและคนพิการ  เมนูตรวจสอบการสมัครงานของคุณ');

  set_class() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_class = prefs.getString('class');
    });
  }

  @override
  void initState() {
    set_class();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เมนูสำหรับค้นหางาน'),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.keyboard_voice),
          //   tooltip: 'Show Snackbar',
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('อธิบายด้วยเสียง')));

          //   },
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 100),
        child: Container(
          child: Column(
            children: [
              Card(
                color: Color(0xCC45156C),
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Center(
                      child: Text(
                    'ข้อมูลการสมัครงาน (Resume)',
                    style: TextStyle(color: Colors.white),
                  )),
                  subtitle: Center(
                      child: Text(
                    'เข้าดู ข้อมูลการสมัครงาน (Resume) ของท่าน',
                    style: TextStyle(color: Colors.white),
                  )),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Rasume()));
                  },
                ),
              ),
              SizedBox(
                height: 15,
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
                    'แสดงงานที่ตรงความต้องการ',
                    style: TextStyle(color: Colors.white),
                  )),
                  subtitle: Center(
                      child: Text(
                    'เข้าดู แสดงงานที่ตรงความต้องการ ',
                    style: TextStyle(color: Colors.white),
                  )),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Jobmatch()));
                  },
                ),
              ),
              SizedBox(
                height: 15,
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
                    'ค้นหางาน',
                    style: TextStyle(color: Colors.white),
                  )),
                  subtitle: Center(
                      child: Text(
                    'ค้นหางานสำหรับ $user_class',
                    style: TextStyle(color: Colors.white),
                  )),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Person()));
                  },
                ),
              ),
              SizedBox(
                height: 15,
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
                    'ตรวจสอบรายการสมัครของท่าน',
                    style: TextStyle(color: Colors.white),
                  )),
                  subtitle: Center(
                      child: Text(
                    'เข้าดู รายการสมัครของท่าน',
                    style: TextStyle(color: Colors.white),
                  )),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Jobred()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
