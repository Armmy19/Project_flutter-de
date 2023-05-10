import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test/complaint/com_list_video.dart';

class com_edit_video extends StatefulWidget {
  final ComplaintVideo showid;
  final Future<void> Function() refresh;
  const com_edit_video({Key? key, required this.showid, required this.refresh})
      : super(key: key);

  @override
  _com_edit_videoState createState() => _com_edit_videoState();
}

class _com_edit_videoState extends State<com_edit_video> {
  late ComplaintVideo idshow;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController title = new TextEditingController();
  TextEditingController content = new TextEditingController();
  String? myfile;
  String? myfiles;
  List<PlatformFile>? _files;
  var now = DateTime.now();
  //API สำหรับการ ยกเลิกการลงทะเบียนฝึกอบรม รับค่าเป็น POST

  _pickFile() async {
    final _files = (await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowMultiple: false,
            allowedExtensions: ['mp4']))!
        .files;
    setState(() {
      myfile = _files.first.path;
      myfiles = _files.first.path.toString();
    });
    print('Loaded file path is : ${_files.first.path}');
  }

  Future<void> _Editvdieo() async {
    idshow = widget.showid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');

    var url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_video_editdata');
    var responseedit = await http.post(url, body: {
      "id": idshow.id,
      "id_user": userid,
      "title": title.text,
      "date": '${now.year}-${now.month}-${now.day}',
    });
    var data = json.decode(responseedit.body);
    print(data);
    if (data["status"] == "success") {
      print('yes');
      setState(() {
        widget.refresh();
        Navigator.pop(context);
      });
    } else {
      print('error');
    }
  }

  Future<void> _editvdieofile() async {
    idshow = widget.showid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');

    var uri = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_video_editfile');
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = idshow.id;
    request.fields['id_user'] = '$userid';

    request.files.add(await http.MultipartFile.fromPath(
      'video',
      myfile.toString(),
    ));
    // request.fields['date'] = '${now.day}/${now.month}/${now.year}';
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        _showMyDialog();
      });
      print(userid);
      print('Uploaded ...');
    } else {
      setState(() {
        _showMyerror();
      });
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
                Text('เพิ่มข้อมูลการร้องเรียนแล้วกรุณาตรวจสอบที่หน้าลิส'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.pop(context);
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'แก้ไขรายการร้องเรียน',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'แก้ไขรายการวิดีโอร้องเรียน',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF543062),
                        fontSize: 20,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFFE0D2E4),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                        child: Text(
                          'หัวข้อร้องเรียน',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xCC62297B),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: TextFormField(
                          controller: title,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF0E4FF),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF0E4FF),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          ),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                        child: Text(
                          'เลือก Up Load File Video',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xCC62297B),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                      //   child: TextFormField(
                      //     // controller: textController2,
                      //     autofocus: true,
                      //     obscureText: false,
                      //     decoration: InputDecoration(
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           color: Color(0xFFF0E4FF),
                      //           width: 1,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           color: Color(0xFFF0E4FF),
                      //           width: 1,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       filled: true,
                      //       fillColor: Colors.white,
                      //       contentPadding:
                      //           EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      //     ),
                      //     style: TextStyle(
                      //       fontFamily: 'Poppins',
                      //       fontWeight: FontWeight.normal,
                      //     ),
                      //   ),
                      // ),

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  // ignore: unnecessary_null_comparison
                                  child: myfile == null
                                      ? Image.network(
                                          'https://picsum.photos/seed/186/600',
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        )
                                      : Text(myfile!)),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _editvdieofile();
                                },
                                icon: Icon(Icons.edit, size: 18),
                                label: Text("แก้ไชวีดีโอ"),
                              ),
                              //     RaisedButton.icon(
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(5),
                              //     ),
                              //     label: Text(
                              //       'แก้ไชวีดีโอ',
                              //       style: TextStyle(
                              //         // color: Color.fromARGB(
                              //         //     255, 255, 255, 255),
                              //         fontSize: 12,
                              //         fontWeight: FontWeight.normal,
                              //       ),
                              //     ),
                              //     icon: Icon(
                              //       Icons.edit,
                              //       // color:
                              //       //     Color.fromARGB(255, 255, 255, 255),
                              //     ),
                              //     textColor: Colors.white,
                              //     color: Color.fromARGB(255, 141, 62, 165),
                              //     splashColor: Color.fromARGB(255, 238, 144, 233),
                              //     onPressed: () {
                              //       _editvdieofile();
                              //     },
                              // ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _pickFile();
                              },
                              icon: Icon(Icons.upload_sharp, size: 18),
                              label: Text("Up Video File"),
                            ),
                            // RaisedButton.icon(
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(5),
                            //   ),
                            //   label: Text(
                            //     'Up Video File',
                            //     style: TextStyle(
                            //       // color: Color.fromARGB(
                            //       //     255, 255, 255, 255),
                            //       fontSize: 12,
                            //       fontWeight: FontWeight.normal,
                            //     ),
                            //   ),
                            //   icon: Icon(
                            //     Icons.upload_sharp,
                            //     // color:
                            //     //     Color.fromARGB(255, 255, 255, 255),
                            //   ),
                            //   textColor: Colors.white,
                            //   color: Color.fromARGB(255, 141, 62, 165),
                            //   splashColor: Color.fromARGB(255, 238, 144, 233),
                            //   onPressed: () {
                            //     _pickFile();
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'วันที่ส่งการร้องเรียน ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xCC62297B),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '${now.year}-${now.month}-${now.day}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: ElevatedButton.icon(
                              onPressed: () {
                                _Editvdieo();
                              },
                              icon: Icon(Icons.arrow_right_outlined, size: 18),
                              label: Text("ส่งข้อมูลร้องเรียน"),
                            )
                                // RaisedButton.icon(
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(5),
                                //   ),
                                //   label: Text(
                                //     'ส่งข้อมูลร้องเรียน',
                                //     style: TextStyle(
                                //       // color: Color.fromARGB(
                                //       //     255, 255, 255, 255),
                                //       fontSize: 12,
                                //       fontWeight: FontWeight.normal,
                                //     ),
                                //   ),
                                //   icon: Icon(
                                //     Icons.arrow_right_outlined,
                                //     // color:
                                //     //     Color.fromARGB(255, 255, 255, 255),
                                //   ),
                                //   textColor: Colors.white,
                                //   color: Color.fromARGB(255, 141, 62, 165),
                                //   splashColor: Color.fromARGB(255, 238, 144, 233),
                                //   onPressed: () {
                                //     _Editvdieo();
                                //   },
                                // ),
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
