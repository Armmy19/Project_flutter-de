import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/home/index.dart';

class edit_profile_image extends StatefulWidget {
  final Future<void> Function() refresh;
  const edit_profile_image({Key? key, required this.refresh}) : super(key: key);

  @override
  _edit_profile_imageState createState() => _edit_profile_imageState();
}

class _edit_profile_imageState extends State<edit_profile_image> {
  // TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool showSpinner = false;
  String? myfile;
  String? myfiles;
  List<PlatformFile>? _files;

  _pickFile() async {
    final _files = (await FilePicker.platform.pickFiles(
            type: FileType.image,
            allowMultiple: false,
            allowedExtensions: null))!
        .files;
    setState(() {
      myfile = _files.first.path;
      myfiles = _files.first.name;
    });
    print('Loaded file path is : ${_files.first.path}');
  }

  Future<void> Editprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');
    setState(() {
      showSpinner = true;
    });
    var uri = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=user_profile_img');
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = '$userid';
    // request.fields['title'] = title.text;
    // request.fields['content'] = content.text;
    request.files.add(await http.MultipartFile.fromPath(
      'img',
      myfile.toString(),
    ));
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        setState(() {
          showSpinner = false;
        });
        // _check_img();
        widget.refresh();
        Navigator.pop(context);
      });
      print(userid);
      print('Uploaded ...');
    } else {
      print('Something went wrong!');
    }
  }

  Future<void> _check_img() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('สำเร็จ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('เปลี่ยนรูปภาพโปรไฟล์สำเร็จ'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home1(false)));
                // Navigator.pop(context);
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
      key: scaffoldKey,
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
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
                          'แก้ไขรูปภาพโปรไฟล์',
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
                                            'ภาพโปรไฟล์',
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 10),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: myfile == null
                                            ? Image.network(
                                                'https://picsum.photos/seed/362/600',
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File('$myfile'),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              )),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Color(0xFFDEE2E6),
                                              ),
                                            ),
                                            child: TextFormField(
                                              // controller: textController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(),
                                                hintText: myfiles,
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
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                          child: ElevatedButton.icon(
                                        onPressed: () {
                                          _pickFile();
                                        },
                                        icon: Icon(Icons.add, size: 18),
                                        label: Text("เลือกภาพโปรไฟล์"),
                                      )

                                          // RaisedButton.icon(
                                          //   onPressed: () {
                                          //     _pickFile();
                                          //   },
                                          //   shape: RoundedRectangleBorder(
                                          //       borderRadius: BorderRadius.all(
                                          //           Radius.circular(5.0))),
                                          //   label: Text(
                                          //     'เลือกภาพโปรไฟล์',
                                          //     style: GoogleFonts.getFont(
                                          //       'Prompt',
                                          //       color: Color(0xFFFFFFFF),
                                          //       fontWeight: FontWeight.normal,
                                          //       // fontSize: 20,
                                          //     ),
                                          //   ),
                                          //   icon: FaIcon(
                                          //     FontAwesomeIcons.image,
                                          //     size: 15,
                                          //   ),
                                          //   textColor: Colors.white,
                                          //   splashColor: Color.fromARGB(
                                          //       255, 197, 182, 236),
                                          //   color: Color(0xFF584A7F),
                                          // ),
                                          ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Editprofile();
                                    },
                                    icon: Icon(Icons.edit, size: 18),
                                    label: Text("บันทึก"),
                                  )
                                  // RaisedButton.icon(
                                  //   onPressed: () {
                                  //     Editprofile();
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
