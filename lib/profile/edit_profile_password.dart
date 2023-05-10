import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class edit_profile_password extends StatefulWidget {
  const edit_profile_password({Key? key}) : super(key: key);

  @override
  _edit_profile_passwordState createState() => _edit_profile_passwordState();
}

class _edit_profile_passwordState extends State<edit_profile_password> {
  // TextEditingController textController;
  final scaffoldKey = GlobalKey<FormState>();
  TextEditingController new_pass = new TextEditingController();
  TextEditingController old_pass = new TextEditingController();

//API สำหรับการ login รับค่าเป็น POST
  Future<void> editpassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=user_password');
    var response = await http.post(url, body: {
      "id": userid,
      "old_pass": old_pass.text,
      "new_pass": new_pass.text,
    });
    var data = json.decode(response.body);
    print(data);
    if (data["status"] == "success") {
      setState(() {
        _showMyDialog();
        Navigator.of(context).pop();
      });
      print('yes');
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
          title: const Text('เปลี่ยนรหัสผ่าน'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('คุณได้ทำการเปลี่ยนรหัสผ่านของคุณแล้วกรุณาตรวจสอบ'),
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
    // textController = TextEditingController();
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
        child: SafeArea(
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
                              color: Color(0xFF6B5B95),
                              size: 20,
                            ),
                          ),
                          Text(
                            'Change Your Password',
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                              'รหัสผ่านเดิม',
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
                                              controller: old_pass,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(),
                                                hintText: 'กรอกรหัสใช้งานเดิม',
                                                hintStyle: TextStyle(
                                                  color: Color(0xFF868E96),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            10, 10, 10, 10),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                              'รหัสผ่านใหม่',
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
                                              controller: new_pass,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(),
                                                hintText: 'กรอกรหัสใช้งานใหม่',
                                                hintStyle: TextStyle(
                                                  color: Color(0xFF868E96),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            10, 10, 10, 10),
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
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      if (scaffoldKey.currentState!
                                          .validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        editpassword();
                                      }
                                    },
                                    icon: Icon(Icons.add, size: 18),
                                    label: Text("บันทึกแก้ไขข้อมูล"),
                                  )
                                  // RaisedButton.icon(
                                  //   onPressed: () {
                                  //     editpassword();
                                  //   },
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(5.0))),
                                  //   label: Text(
                                  //     'บันทึกแก้ไขข้อมูล',
                                  //     style: GoogleFonts.getFont(
                                  //       'Prompt',
                                  //       color: Color(0xFFFFFFFF),
                                  //       fontWeight: FontWeight.normal,
                                  //       // fontSize: 20,
                                  //     ),
                                  //   ),
                                  //   icon: FaIcon(
                                  //     FontAwesomeIcons.save,
                                  //     size: 15,
                                  //   ),
                                  //   textColor: Colors.white,
                                  //   splashColor:
                                  //       Color.fromARGB(255, 197, 182, 236),
                                  //   color: Color(0xFF584A7F),
                                  // ),
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
      ),
    );
  }
}
