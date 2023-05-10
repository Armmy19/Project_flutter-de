import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class com_add_text extends StatefulWidget {
  // const com_add_text({Key key}) : super(key: key);

  @override
  _com_add_textState createState() => _com_add_textState();
}

class _com_add_textState extends State<com_add_text> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var now = DateTime.now();
  String? myfile;
  String? myfiles;
  List<PlatformFile>? _files;
  TextEditingController title = new TextEditingController();
  TextEditingController content = new TextEditingController();
  //API สำหรับการ ยกเลิกการลงทะเบียนฝึกอบรม รับค่าเป็น POST
  bool _isLoading = false; //bool variable created
  Future<void> _Addtext() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    setState(() {
      _isLoading = true;
    });
    print('====== $userid');
    var uri = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_text_add');
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = '$userid';
    request.fields['title'] = title.text;
    request.fields['content'] = content.text;
    request.fields['date'] = '${now.day}/${now.month}/${now.year}';
    request.files.add(await http.MultipartFile.fromPath(
      'picture',
      myfile.toString(),
    ));
    // Print request
    print("JJJJJJ");
    print('====== $request');

    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        _showMyDialog();
        Navigator.pop(context);
      });
      var json = await response.stream.bytesToString();
      print("KKKKK");
      print(json);
      print(userid);
      print('Uploaded ...');
    } else {
      print('Something went wrong!');
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

  Future<void> _loadding() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              CircularProgressIndicator(),
              Text('รอประมวลผล'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ออก'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  _pickFile() async {
    final _files = (await FilePicker.platform.pickFiles(
            type: FileType.image,
            allowMultiple: false,
            allowedExtensions: null))!
        .files;
    setState(() {
      myfile = _files.first.path;
      myfiles = _files.first.path.toString();
    });
    print('Loaded file path is : ${_files.first.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'สร้างรายการร้องเรียน',
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
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                          child: Text(
                            'สร้างรายการข้อความร้องเรียน',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF543062),
                              fontSize: 20,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
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
                                      EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 10),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                              child: Text(
                                'เนื้อหาการร้องเรียน',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xCC62297B),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                              child: TextFormField(
                                controller: content,
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
                                      EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 10),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                                maxLines: 3,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                              child: Text(
                                'เลือก Up Load File Image',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xCC62297B),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 0, 10),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        // ignore: unnecessary_null_comparison
                                        child: myfile == null
                                            ? Image.network(
                                                'https://picsum.photos/seed/186/600',
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File('$myfile'),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              )),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _pickFile();
                                    },
                                    icon: Icon(Icons.upload_sharp, size: 18),
                                    label: Text("Up Image File'"),
                                  )
                                  // RaisedButton.icon(
                                  //   shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(5),
                                  //   ),
                                  //   label: Text(
                                  //     'Up Image File',
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
                                  //   splashColor:
                                  //       Color.fromARGB(255, 238, 144, 233),
                                  //   onPressed: () {
                                  //     _pickFile();
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding:
                            //       EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                            //   child: Text(
                            //     'วันที่ส่งการร้องเรียน',
                            //     style: TextStyle(
                            //       fontFamily: 'Poppins',
                            //       color: Color(0xCC62297B),
                            //       fontWeight: FontWeight.normal,
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding:
                            //       EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            //   child: TextFormField(
                            //     // controller: textController3,
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
                            //           EdgeInsetsDirectional.fromSTEB(
                            //               10, 10, 10, 10),
                            //     ),
                            //     style: TextStyle(
                            //       fontFamily: 'Poppins',
                            //       fontWeight: FontWeight.normal,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 20, 20, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: ElevatedButton.icon(
                                    onPressed: () {
                                      _Addtext();
                                    },
                                    icon: Icon(Icons.upload_sharp, size: 18),
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
                                      //   splashColor:
                                      //       Color.fromARGB(255, 238, 144, 233),
                                      //   onPressed: () {
                                      //     _Addtext();
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
            ],
          ),
        ),
      ),
    );
  }
}
