import 'dart:convert';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class com_add_video extends StatefulWidget {
  // const com_add_video({Key key}) : super(key: key);

  @override
  _com_add_videoState createState() => _com_add_videoState();
}

class _com_add_videoState extends State<com_add_video> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String chacttext;
  String? myfile;
  String? myfiles;
  bool showSpinner = false;
  List<PlatformFile>? _files;
  TextEditingController title = new TextEditingController();
  TextEditingController dateInput = new TextEditingController();
  TextEditingController content = new TextEditingController();

  _pickFile_video() async {
    final _files = (await FilePicker.platform.pickFiles(
            type: FileType.video,
            allowMultiple: false,
            allowedExtensions: null))!
        .files;
    setState(() {
      myfile = _files.first.path;
      myfiles = _files.first.path.toString();
    });
    print('Loaded file path is : ${_files.first.path}');
  }

  _pickFile_voice() async {
    final _files = (await FilePicker.platform.pickFiles(
            type: FileType.audio,
            allowMultiple: false,
            allowedExtensions: null))!
        .files;
    setState(() {
      myfile = _files.first.path;
      myfiles = _files.first.path.toString();
    });
    print('Loaded file path is : ${_files.first.path}');
  }

  _pickFile_text() async {
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

  Future<void> _Addvdieo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');
    setState(() {
      showSpinner = true;
    });

    var uri = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_video_add');
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = '$userid';
    request.fields['title'] = title.text;
    request.fields['date'] = dateInput.text;
    request.files.add(await http.MultipartFile.fromPath(
      'video',
      myfile.toString(),
    ));
    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        setState(() {
          showSpinner = false;
        });
        _showMyDialog();
        Navigator.pop(context);
      });
      // Convert to json
      var json = await response.stream.bytesToString();
      print(json);
      print(userid);
      print('Uploaded ...');
    } else {
      setState(() {
        _showMyerror();
      });
    }
  }

  Future<void> _AddVoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');
    setState(() {
      showSpinner = true;
    });

    var uri = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_all_add');
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = '$userid';
    request.fields['title'] = title.text;
    request.fields['content'] = content.text;
    request.fields['date'] = dateInput.text;
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      myfile.toString(),
    ));
    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        setState(() {
          showSpinner = false;
        });
        _showMyDialog();
        Navigator.pop(context);
      });
      // Convert to json
      var json = await response.stream.bytesToString();
      print(json);
      print(userid);
      print('Uploaded ...');
    } else {
      setState(() {
        _showMyerror();
      });
    }
  }

  Future<void> _AddText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');
    setState(() {
      showSpinner = true;
    });

    var uri = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_text_add');
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = '$userid';
    request.fields['title'] = title.text;
    request.fields['content'] = content.text;
    request.fields['date'] = dateInput.text;
    request.files.add(await http.MultipartFile.fromPath(
      'picture',
      myfile.toString(),
    ));
    print("JJJJJJ");
    print('====== $request');
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        setState(() {
          showSpinner = false;
        });
        _showMyDialog();
        Navigator.pop(context);
      });
      var json = await response.stream.bytesToString();

      print("KKKKK");
      print(json);
      print(userid);
      print('Uploaded ...');
    } else {
      setState(() {
        _showMyerror();
      });
    }
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

  Future<void> _showMyimg() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$chacttext'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('มีข้อผิกพลาด กรุณาตรวจสอบข้อมูล $chacttext'),
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
    dateInput.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'วีดีโอ'),
                Tab(text: 'เสียง'),
                Tab(text: 'ข้อความ/รูปภาพ'),
                // Tab(icon: Icon(Icons.directions_transit)),
                // Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('เมนูการร้องเรียน'),
          ),
          body: TabBarView(
            children: [
              video(),
              voice(),
              text(),
            ],
          ),
        ),
      ),
    );
  }

  Widget video() {
    return SafeArea(
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
                          'สร้างรายการร้องเรียน วีดีโอ',
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                              'รายละเอียด',
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                              'เลือกอัฟโหลดไฟล์',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xCC62297B),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
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
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _pickFile_video();
                                  },
                                  icon: Icon(Icons.upload_sharp, size: 18),
                                  label: Text("อัฟโหลดไฟล์"),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                            child: Text(
                              'วันที่ส่งการร้องเรียน',
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
                            child: TextField(
                              controller: dateInput,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText:
                                      "วัน/เดือน/ปี" //label text of field
                                  ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateInput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (myfile == null) {
                                      chacttext = 'กรุณาอัพโหลดไฟล์วีดีโอ';
                                      print(chacttext);
                                      _showMyimg();
                                    } else {
                                      _Addvdieo();
                                    }
                                  },
                                  icon: Icon(Icons.arrow_right_outlined,
                                      size: 18),
                                  label: Text("ส่งข้อมูลร้องเรียน"),
                                )),
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
    );
  }

  Widget voice() {
    return SafeArea(
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
                          'สร้างรายการร้องเรียน เสียง',
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                              'รายละเอียด',
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                              'เลือกอัฟโหลดไฟล์',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xCC62297B),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
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
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _pickFile_voice();
                                  },
                                  icon: Icon(Icons.upload_sharp, size: 18),
                                  label: Text("อัฟโหลดไฟล์"),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                            child: Text(
                              'วันที่ส่งการร้องเรียน',
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
                            child: TextField(
                              controller: dateInput,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText:
                                      "วัน/เดือน/ปี" //label text of field
                                  ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateInput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (myfile == null) {
                                      chacttext = 'กรุณาอัพโหลดไฟล์เสียง';
                                      print(chacttext);
                                      _showMyimg();
                                    } else {
                                      _AddVoice();
                                    }
                                  },
                                  icon: Icon(Icons.arrow_right_outlined,
                                      size: 18),
                                  label: Text("ส่งข้อมูลร้องเรียน"),
                                )),
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
    );
  }

  Widget text() {
    return SafeArea(
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
                          'สร้างรายการร้องเรียน ข้อความ',
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                              'รายละเอียด',
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                              'เลือกอัฟโหลดไฟล์',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xCC62297B),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
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
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _pickFile_text();
                                  },
                                  icon: Icon(Icons.upload_sharp, size: 18),
                                  label: Text("อัฟโหลดไฟล์"),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                            child: Text(
                              'วันที่ส่งการร้องเรียน',
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
                            child: TextField(
                              controller: dateInput,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText:
                                      "วัน/เดือน/ปี" //label text of field
                                  ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateInput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: ElevatedButton.icon(
                                  onPressed: () {
                                    //       _showMyDialog();
                                    if (myfile == null) {
                                      chacttext = 'กรุณาใส่รูปภาพ';
                                      print(chacttext);
                                      _showMyimg();
                                    } else {
                                      _AddText();
                                    }
                                  },
                                  icon: Icon(Icons.arrow_right_outlined,
                                      size: 18),
                                  label: Text("ส่งข้อมูลร้องเรียน"),
                                )),
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
    );
  }
}





 

// class ttt extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _ttt();
//   }
// }
 
// class _ttt extends State<ttt> {
//   TextEditingController dateInput = TextEditingController();
 
//   @override
//   void initState() {
//     dateInput.text = ""; //set the initial value of text field
//     super.initState();
//   }
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("DatePicker in Flutter"),
//           backgroundColor: Colors.redAccent, //background color of app bar
//         ),
//         body: Container(
//             padding: EdgeInsets.all(15),
//             height: MediaQuery.of(context).size.width / 3,
//             child: Center(
//                 child: TextField(
//               controller: dateInput,
//               //editing controller of this TextField
//               decoration: InputDecoration(
//                   icon: Icon(Icons.calendar_today), //icon of text field
//                   labelText: "Enter Date" //label text of field
//                   ),
//               readOnly: true,
//               //set it true, so that user will not able to edit text
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(1950),
//                     //DateTime.now() - not to allow to choose before today.
//                     lastDate: DateTime(2100));
 
//                 if (pickedDate != null) {
//                   print(
//                       pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                   String formattedDate =
//                       DateFormat('yyyy-MM-dd').format(pickedDate);
//                   print(
//                       formattedDate); //formatted date output using intl package =>  2021-03-16
//                   setState(() {
//                     dateInput.text =
//                         formattedDate; //set output date to TextField value.
//                   });
//                 } else {}
//               },
//             )
//             )));
//   }
// }