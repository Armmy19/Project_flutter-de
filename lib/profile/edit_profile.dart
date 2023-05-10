import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test/api/showprofile.dart';

class edit_profile extends StatefulWidget {
  final ProfileShow profile_show;
  final Future<void> Function() refresh;
  const edit_profile(
      {Key? key, required this.profile_show, required this.refresh})
      : super(key: key);

  @override
  _edit_profileState createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  late ProfileShow profile_edit;
  final scaffoldKey = GlobalKey<FormState>();
  String? myfile;
  String? myfiles;
  List<PlatformFile>? _files;
  var type = ['ผู้สูงอายุ', 'คนพิการ'];
  var sex = ['ชาย', 'หญิง'];
  var tit = ['นาย', 'นาง', 'นางสาว'];
  TextEditingController user_class = new TextEditingController();
  TextEditingController user_titlename = new TextEditingController();
  TextEditingController user_name = new TextEditingController();
  TextEditingController user_lastname = new TextEditingController();
  TextEditingController user_phone = new TextEditingController();
  TextEditingController user_gender = new TextEditingController();
  TextEditingController user_birthday = new TextEditingController();
//API สำหรับการ login รับค่าเป็น POST
  Future<void> Edit_profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=user_profile_edit');
    var response = await http.post(url, body: {
      "id": userid,
      "user_class": user_class.text,
      "user_titlename": user_titlename.text,
      "user_name": user_name.text,
      "user_lastname": user_lastname.text,
      "user_phone": user_phone.text,
      "user_gender": user_gender.text,
      "user_birthday": user_birthday.text,
    });
    var data = json.decode(response.body);
    print(data);
    if (data["status"] == "success") {
      _showMyDialog();
      widget.refresh();
      Navigator.of(context).pop();
      print('yes');
    } else {
      setState(() {
        _showMyerror();
      });
      print('error');
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('สำเร็จ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('แก้ไขข้อมูลสำเร็จ'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyerror() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('เกิดข้อผิดพลาด'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('มีข้อผิกพลาด กรุณาตรวจสอบข้อมูล'),
              ],
            ),
          ),
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

  @override
  void initState() {
    super.initState();
    user_birthday.text = "";
    profile_edit = widget.profile_show;
    setState(() {
      user_class.text = profile_edit.message.userClass ??= "";
      user_name.text = profile_edit.message.userEmail ??= "";
      user_birthday.text = profile_edit.message.userBirthday ??= "";
      user_gender.text = profile_edit.message.userGender ??= "";
      user_name.text = profile_edit.message.userName ??= "";
      user_lastname.text = profile_edit.message.userLastname ??= "";
      user_titlename.text = profile_edit.message.userTitlename ??= "";
      user_phone.text = profile_edit.message.userPhone ??= "";
    });
    print(profile_edit.message.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7F9),
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Form(
        key: scaffoldKey,
        child: ListView(
          padding: EdgeInsets.zero,
          primary: false,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: FaIcon(
                            FontAwesomeIcons.solidEdit,
                            color: Color(0xFF584A7F),
                            size: 20,
                          ),
                        ),
                        Text(
                          'แก้ไขโปรไฟล์',
                          style: GoogleFonts.getFont(
                            'Prompt',
                            color: Color(0xFF584A7F),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xFFDEE2E6),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'ประเภทกลุ่ม',
                                            style: GoogleFonts.getFont(
                                              'Prompt',
                                              color: Color(0xFF434C5E),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Color(0xFFC92A2A),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(0xFFDEE2E6),
                                            ),
                                          ),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรุณากรอกข้อมูลนี้ ';
                                              }
                                              return null;
                                            },
                                            controller: user_class,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(),
                                              hintText: 'เลือกกลุ่มผู้ใช้งาน',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF868E96),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
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
                                          user_class.text = value;
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return type
                                              .map<PopupMenuItem<String>>(
                                                  (String value) {
                                            return new PopupMenuItem(
                                                child: new Text(value),
                                                value: value);
                                          }).toList();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'เพศ',
                                            style: GoogleFonts.getFont(
                                              'Prompt',
                                              color: Color(0xFF434C5E),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Color(0xFFC92A2A),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(0xFFDEE2E6),
                                            ),
                                          ),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรุณากรอกข้อมูลนี้ ';
                                              }
                                              return null;
                                            },
                                            controller: user_gender,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(),
                                              hintText: 'เลือกเพศกำเนิด',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF868E96),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
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
                                          user_gender.text = value;
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return sex.map<PopupMenuItem<String>>(
                                              (String value) {
                                            return new PopupMenuItem(
                                                child: new Text(value),
                                                value: value);
                                          }).toList();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'คำนำหน้าชื่อ',
                                            style: GoogleFonts.getFont(
                                              'Prompt',
                                              color: Color(0xFF434C5E),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Color(0xFFC92A2A),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(0xFFDEE2E6),
                                            ),
                                          ),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรุณากรอกข้อมูลนี้ ';
                                              }
                                              return null;
                                            },
                                            controller: user_titlename,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(),
                                              hintText: 'คำนำหน้าชื่อ',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF868E96),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
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
                                          user_titlename.text = value;
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return tit.map<PopupMenuItem<String>>(
                                              (String value) {
                                            return new PopupMenuItem(
                                                child: new Text(value),
                                                value: value);
                                          }).toList();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'ชื่อ',
                                            style: GoogleFonts.getFont(
                                              'Prompt',
                                              color: Color(0xFF434C5E),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Color(0xFFC92A2A),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(0xFFDEE2E6),
                                            ),
                                          ),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรุณากรอกข้อมูลนี้ ';
                                              }
                                              return null;
                                            },
                                            controller: user_name,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(),
                                              hintText: 'กรอกชื่อจริง',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF868E96),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
                                            ),
                                            style: GoogleFonts.getFont(
                                              'Prompt',
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // PopupMenuButton<String>(
                                      //   icon: const Icon(Icons.arrow_drop_down),
                                      //   onSelected: (String value) {
                                      //     _sexcontroller.text = value;
                                      //   },
                                      //   itemBuilder: (BuildContext context) {
                                      //     return sex.map<PopupMenuItem<String>>(
                                      //         (String value) {
                                      //       return new PopupMenuItem(
                                      //           child: new Text(value),
                                      //           value: value);
                                      //     }).toList();
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'นามสกุล',
                                            style: GoogleFonts.getFont(
                                              'Prompt',
                                              color: Color(0xFF434C5E),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Color(0xFFC92A2A),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(0xFFDEE2E6),
                                            ),
                                          ),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรุณากรอกข้อมูลนี้ ';
                                              }
                                              return null;
                                            },
                                            controller: user_lastname,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(),
                                              hintText: 'กรอกนามกสุล',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF868E96),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
                                            ),
                                            style: GoogleFonts.getFont(
                                              'Prompt',
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'วันเกิด',
                                            style: GoogleFonts.getFont(
                                              'Prompt',
                                              color: Color(0xFF434C5E),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Color(0xFFC92A2A),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: Color(0xFFDEE2E6),
                                                    ),
                                                  ),
                                                  child: TextFormField(
                                                    onTap: () async {
                                                      DateTime? pickedDate =
                                                          await showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate:
                                                                  DateTime(
                                                                      1950),
                                                              //DateTime.now() - not to allow to choose before today.
                                                              lastDate:
                                                                  DateTime(
                                                                      2100));

                                                      if (pickedDate != null) {
                                                        String formattedDate =
                                                            DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    pickedDate);
                                                        // If date more than today's date show popup error
                                                        if (DateTime.parse(
                                                                formattedDate)
                                                            .isAfter(DateTime
                                                                .now())) {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'วันเกิดไม่ถูกต้อง'),
                                                                content: Text(
                                                                    'กรุณาเลือกวันเกิดใหม่อีกครั้ง'),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    child: Text(
                                                                        'ตกลง'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        } else {
                                                          setState(() {
                                                            user_birthday.text =
                                                                formattedDate; //set output date to TextField value.
                                                          });
                                                        }
                                                        setState(() {
                                                          user_birthday.text =
                                                              formattedDate; //set output date to TextField value.
                                                        });
                                                      } else {}
                                                    },
                                                    controller: user_birthday,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelStyle: TextStyle(),
                                                      hintText: 'เลือกวันเกิด',
                                                      hintStyle: TextStyle(
                                                        color:
                                                            Color(0xFF868E96),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(10, 10,
                                                                  10, 10),
                                                      icon: Icon(
                                                          Icons.calendar_today),
                                                    ),
                                                    style: GoogleFonts.getFont(
                                                      'Prompt',
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'หมายเลขโทรศัพท์',
                                            style: GoogleFonts.getFont(
                                              'Prompt',
                                              color: Color(0xFF434C5E),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color: Color(0xFFC92A2A),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(0xFFDEE2E6),
                                            ),
                                          ),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              // for below version 2 use this
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                              LengthLimitingTextInputFormatter(
                                                  10)
// for version 2 and greater youcan also use this
//  FilteringTextInputFormatter.digitsOnly
                                            ],

                                            // validate after each user interaction
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรอก\'เบอร์มือถือของคุณ';
                                              }
                                              if (value.length < 10) {
                                                return 'ยังไม่ถูกต้อง หมายเลขต้องครบ 10 หลัก';
                                              }
                                              return null;
                                            },
                                            controller: user_phone,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(),
                                              hintText: 'กรอกหมายเลขโทรศัพท์',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF868E96),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
                                            ),
                                            style: GoogleFonts.getFont(
                                              'Prompt',
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //               ElevatedButton(
                            //   onPressed: () {
                            //     // Validate returns true if the form is valid, or false otherwise.
                            //     if (scaffoldKey.currentState!.validate()) {
                            //       // If the form is valid, display a snackbar. In the real world,
                            //       // you'd often call a server or save the information in a database.
                            //       Edit_profile();
                            //     }
                            //   },
                            //   child: const Text('บันทึกแก้ไขข้อมูล'),
                            // ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    if (scaffoldKey.currentState!.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      Edit_profile();
                                    }
                                  },
                                  icon: Icon(Icons.edit, size: 18),
                                  label: Text("บันทึกแก้ไขข้อมูล"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
