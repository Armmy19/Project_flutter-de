import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/complaint/com_list_voice.dart';

class com_edit_voice extends StatefulWidget {
  final Showlistvoice ideditvoice;
  const com_edit_voice({Key? key, required this.ideditvoice}) : super(key: key);

  @override
  _com_edit_voiceState createState() => _com_edit_voiceState();
}

class _com_edit_voiceState extends State<com_edit_voice> {
  // TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Showlistvoice editvoice;
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
            allowedExtensions: ['mp3']))!
        .files;
    setState(() {
      myfile = _files.first.path;
      myfiles = _files.first.path.toString();
    });
    print('Loaded file path is : ${_files.first.path}');
  }

  Future<void> _Editvoice() async {
    editvoice = widget.ideditvoice;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');

    var url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_sound_editdata');
    var responseedit = await http.post(url, body: {
      "id": editvoice.id,
      "id_user": userid,
      "title": title.text,
      "date": '${now.year}-${now.month}-${now.day}',
    });
    var data = json.decode(responseedit.body);
    print(data);
    if (data["status"] == "success") {
      print('yes');
      setState(() {
        Navigator.pop(context);
      });
    } else {
      print('error');
    }
  }

  Future<void> _editvoicefile() async {
    editvoice = widget.ideditvoice;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');

    var uri = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_sound_editfile');
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = editvoice.id;
    request.fields['id_user'] = '$userid';

    request.files.add(await http.MultipartFile.fromPath(
      'sound',
      myfile.toString(),
    ));
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
  void initState() {
    editvoice = widget.ideditvoice;
    print(editvoice.id);
    super.initState();
    // textController = TextEditingController(text: 'การทำร้ายร่างกายผู้สูงอายุ');
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
                      'แก้ไขรายการข้อความเสียงร้องเรียน',
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
                          // controller: textController,
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            // ignore: unnecessary_null_comparison
                            child: myfile == null
                                ? Image.network(
                                    'https://picsum.photos/seed/186/600',
                                    width: MediaQuery.of(context).size.width,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  )
                                : Text(myfile!)),
                      ),

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 5, 20, 10),
                        // child: FlutterFlowAudioPlayer(
                        //   audio: Audio.network(
                        //     'https://filesamples.com/samples/audio/mp3/sample3.mp3',
                        //     metas: Metas(
                        //       id: 'sample3.mp3-qe8ccqse',
                        //     ),
                        //   ),
                        //   titleTextStyle:
                        //       FlutterFlowTheme.of(context).bodyText1.override(
                        //             fontFamily: 'Poppins',
                        //             fontWeight: FontWeight.w600,
                        //           ),
                        //   playbackDurationTextStyle:
                        //       FlutterFlowTheme.of(context).bodyText1.override(
                        //             fontFamily: 'Poppins',
                        //             color: Color(0xFF9D9D9D),
                        //             fontSize: 12,
                        //           ),
                        //   fillColor: Color(0xFFEEEEEE),
                        //   playbackButtonColor: Color(0xFF926EDA),
                        //   activeTrackColor: Color(0xFF57636C),
                        //   elevation: 3,
                        // ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    _editvoicefile();
                                  },
                                  icon: Icon(Icons.edit, size: 18),
                                  label: Text("แก้ไชวีดีโอ"),
                                )
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
                                //       _editvoicefile();
                                //     },
                                // ),
                                ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _pickFile();
                              },
                              icon: Icon(Icons.upload_sharp, size: 18),
                              label: Text("Up Voice File"),
                            )
                            // RaisedButton.icon(
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(5),
                            //   ),
                            //   label: Text(
                            //     'Up Voice File',
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
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      //   child: Text(
                      //     'เลือก Up Load File Image',
                      //     style: TextStyle(
                      //       fontFamily: 'Poppins',
                      //       color: Color(0xCC62297B),
                      //       fontWeight: FontWeight.normal,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.max,
                      //     children: [
                      //       Padding(
                      //         padding:
                      //             EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                      //         child: ClipRRect(
                      //           borderRadius: BorderRadius.circular(5),
                      //           child: Image.network(
                      //             'https://picsum.photos/seed/186/600',
                      //             width: MediaQuery.of(context).size.width,
                      //             height: 120,
                      //             fit: BoxFit.cover,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.max,
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       RaisedButton.icon(
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5),
                      //         ),
                      //         label: Text(
                      //           'Up Image File',
                      //           style: TextStyle(
                      //             // color: Color.fromARGB(
                      //             //     255, 255, 255, 255),
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.normal,
                      //           ),
                      //         ),
                      //         icon: Icon(
                      //           Icons.upload_sharp,
                      //           // color:
                      //           //     Color.fromARGB(255, 255, 255, 255),
                      //         ),
                      //         textColor: Colors.white,
                      //         color: Color.fromARGB(255, 141, 62, 165),
                      //         splashColor: Color.fromARGB(255, 238, 144, 233),
                      //         onPressed: () {
                      //           // Navigator.push(
                      //           //     context,
                      //           //     MaterialPageRoute(
                      //           //         builder: (context) =>
                      //           //             doc_reg()));
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                                // Respond to button press
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
                                //     _Editvoice();
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
