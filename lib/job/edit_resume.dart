import 'dart:async';
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/Dataresume.dart';
import 'package:test/job/resume.dart';
import 'resume_mapper.dart';

class Editresume extends StatefulWidget {
  final Future<void> Function() refresh;
  const Editresume({Key? key, required this.refresh}) : super(key: key);

  @override
  State<Editresume> createState() => _EditresumeState();
}

class _EditresumeState extends State<Editresume> {
  late Dataresume Showresumeshow;
  late String vvv = '55';
  TextEditingController resume_graduation = new TextEditingController();
  TextEditingController resume_educational_place = new TextEditingController();
  TextEditingController resume_job_type_interested =
      new TextEditingController();
  TextEditingController resume_required_salary = new TextEditingController();
  TextEditingController resume_language_ability = new TextEditingController();
  TextEditingController resume_computer_skills = new TextEditingController();
  TextEditingController resume_history_work = new TextEditingController();
  TextEditingController resume_training = new TextEditingController();
  TextEditingController resume_awarded = new TextEditingController();

  //API สำหรับการ _Rgistertrain ลงทะเบียนฝึกอบรม รับค่าเป็น POST
  Future<void> _getresumeshow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=job_resume');
    var response = await http.post(url, body: {
      "id": userid,
    });
    var data = json.decode(response.body);

    Showresumeshow = dataresumeFromJson(response.body);
    setState(() {
      resume_graduation.text = graduation_maper_reverse(
          Showresumeshow.message.resumeGraduation ??= "");
      resume_language_ability.text =
          Showresumeshow.message.resumeLanguageAbility ??= "";
      resume_educational_place.text =
          Showresumeshow.message.resumeEducationalPlace ??= "";
      resume_required_salary.text =
          Showresumeshow.message.resumeRequiredSalary ??= "";
      resume_history_work.text =
          Showresumeshow.message.resumeHistoryWork ??= "";
      resume_training.text = Showresumeshow.message.resumeTraining ??= "";
      resume_awarded.text = Showresumeshow.message.resumeAwarded ??= "";
      resume_computer_skills.text =
          Showresumeshow.message.resumeComputerSkills ??= "";
      resume_job_type_interested.text = type_interested_maper_reverse(
          Showresumeshow.message.resumeJobTypeInterested ??= "");
    });
    // print("${Showresumeshow.message.resumeEducationalPlace} " );
    print(data);
  }

  final List<String> graduation = [
    'ไม่มีวุฒิการศึกษา',
    'ระดับ ประถมศึกษา',
    'ระดับ มัธยมศึกษา',
    'ระดับ ปวช.',
    'ระดับ ปวส.',
    'ระดับ ปริญญาตรี',
    'ระดับ ปริญญาโท',
    'ระดับ ปริญญาเอก',
  ];

  final List<String> language_ability = [
    'ไม่มีพื้นฐาน',
    'ระดับพื้นฐาน',
    'ระดับกลาง',
    'ระดับสูง',
  ];

  final List<String> computer_skills = [
    'ไม่มีพื้นฐาน',
    'ระดับพื้นฐาน',
    'ระดับกลาง',
    'ระดับสูง',
  ];

  final List<String> type_interested = [
    'ช่างซ่อม',
    'งานโรงงาน/ฝ่ายการผลิต/ควบคุมคุณภาพ',
    'โปรแกรมเมอร์',
    'ออกแบบกราฟฟิก/3D/ตัดต่อวิดีโอ',
    'สื่อสารสนเทศ/นักเขียน/พิสูจน์อักษร/นักแปลภาษา',
    'งานโรงงาน/ฝ่ายการผลิต/ควบคุมคุณภาพ',
    'งานบริการลูกค้า/งานขาย/งานขนส่ง',
    'การเงินการบัญชี',
    'งานเอกสารและธุรการ',
    'คอร์สสอน/ครู/อาจารย์',
    'ล่าม/มัคคุเทศก์',
    'Freelance/Part-time',
  ];

  final _formKey = GlobalKey<FormState>();

//API สำหรับการ login รับค่าเป็น POST
  Future<void> _resumeEdit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=job_resume_edit');
    var responseedit = await http.post(url, body: {
      "id": userid,
      "resume_graduation": graduation_maper(resume_graduation.text),
      "resume_educational_place": resume_educational_place.text,
      "resume_job_type_interested":
          type_interested_maper(resume_job_type_interested.text),
      "resume_required_salary": resume_required_salary.text,
      "resume_language_ability": resume_language_ability.text,
      "resume_computer_skills": resume_computer_skills.text,
      "resume_history_work": resume_history_work.text,
      "resume_training": resume_training.text,
      "resume_awarded": resume_awarded.text,
    });

    var dataedit = json.decode(responseedit.body);
    print("Edit Resume");
    print(dataedit);
    if (dataedit["status"] == "success") {
      widget.refresh();
      Navigator.pop(context);
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getresumeshow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลการสมัครงาน (Resume)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color(0xFFDEE2E6),
                                    ),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกข้อมูลนี้ ';
                                      }
                                      return null;
                                    },
                                    enabled: false,
                                    controller: resume_graduation,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'ระดับการศึกษาสูงสูด *',
                                      labelStyle: TextStyle(
                                        color: Color.fromARGB(255, 226, 1, 1),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 226, 1, 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 5, 4, 4),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              10, 10, 10, 10),
                                    ),
                                    style: GoogleFonts.getFont(
                                      'Prompt',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.arrow_drop_down),
                                onSelected: (String value) {
                                  resume_graduation.text = value;
                                },
                                itemBuilder: (BuildContext context) {
                                  return graduation.map<PopupMenuItem<String>>(
                                      (String value) {
                                    return new PopupMenuItem(
                                        child: new Text(value), value: value);
                                  }).toList();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูลนี้ ';
                        }
                        return null;
                      },
                      controller: resume_educational_place,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        labelText: 'จากสถาบันการศึกษา *',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 226, 1, 1),
                        ),
                        hintText: 'จากสถาบันการศึกษา',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color(0xFFDEE2E6),
                                    ),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกข้อมูลนี้ ';
                                      }
                                      return null;
                                    },
                                    enabled: false,
                                    controller: resume_language_ability,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Color.fromARGB(255, 226, 1, 1),
                                      ),
                                      labelText: 'ความสามารถด้านภาษา *',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF868E96),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 5, 4, 4),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              10, 10, 10, 10),
                                    ),
                                    style: GoogleFonts.getFont(
                                      'Prompt',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.arrow_drop_down),
                                onSelected: (String value) {
                                  resume_language_ability.text = value;
                                },
                                itemBuilder: (BuildContext context) {
                                  return language_ability
                                      .map<PopupMenuItem<String>>(
                                          (String value) {
                                    return new PopupMenuItem(
                                        child: new Text(value), value: value);
                                  }).toList();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color(0xFFDEE2E6),
                                    ),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกข้อมูลนี้ ';
                                      }
                                      return null;
                                    },
                                    enabled: false,
                                    controller: resume_computer_skills,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Color.fromARGB(255, 226, 1, 1),
                                      ),
                                      labelText: 'ความสามารถด้านคอมพิวเตอร์ *',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF868E96),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 5, 4, 4),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              10, 10, 10, 10),
                                    ),
                                    style: GoogleFonts.getFont(
                                      'Prompt',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.arrow_drop_down),
                                onSelected: (String value) {
                                  resume_computer_skills.text = value;
                                },
                                itemBuilder: (BuildContext context) {
                                  return computer_skills
                                      .map<PopupMenuItem<String>>(
                                          (String value) {
                                    return new PopupMenuItem(
                                        child: new Text(value), value: value);
                                  }).toList();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color(0xFFDEE2E6),
                                    ),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกข้อมูลนี้ ';
                                      }
                                      return null;
                                    },
                                    enabled: false,
                                    controller: resume_job_type_interested,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Color.fromARGB(255, 226, 1, 1),
                                      ),
                                      labelText: 'ลักษณะงานที่ต้องการ *',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF868E96),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 5, 4, 4),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              10, 10, 10, 10),
                                    ),
                                    style: GoogleFonts.getFont(
                                      'Prompt',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.arrow_drop_down),
                                onSelected: (String value) {
                                  resume_job_type_interested.text = value;
                                },
                                itemBuilder: (BuildContext context) {
                                  return type_interested
                                      .map<PopupMenuItem<String>>(
                                          (String value) {
                                    return new PopupMenuItem(
                                        child: new Text(value), value: value);
                                  }).toList();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูลนี้ ';
                        }
                        return null;
                      },
                      controller: resume_required_salary,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        labelText: 'เงินเดือนที่ต้องการ *',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 226, 1, 1),
                        ),
                        hintText: 'เงินเดือนที่ต้องการ',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: resume_history_work,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 30,
                        ),
                        labelText: 'ประสบการณ์ในการทำงาน',
                        hintText: 'ประสบการณ์ในการทำงาน',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: resume_training,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 30,
                        ),
                        labelText: 'ประสบการณ์ในการอบรม',
                        hintText: 'ประสบการณ์ในการอบรม',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: resume_awarded,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 30,
                        ),
                        labelText: 'เกียรติบัตร/รางวัลที่ได้รับ',
                        hintText: 'เกียรติบัตร/รางวัลที่ได้รับ',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _resumeEdit();
                        }
                      },
                      icon: Icon(Icons.insert_chart, size: 18),
                      label: Text('บันทึก'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
