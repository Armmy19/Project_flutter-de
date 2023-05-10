import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class com_add_voice extends StatefulWidget {
  // const com_add_voice({Key key}) : super(key: key);

  @override
  _com_add_voiceState createState() => _com_add_voiceState();
}

class _com_add_voiceState extends State<com_add_voice> {
  String? myfile;
  String? myfiles;
  List<PlatformFile>? _files;
  TextEditingController title = new TextEditingController();
  TextEditingController dateInput = new TextEditingController();

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

  Future<void> _Addvoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');
    _loadding();

    var uri = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_sound_add');
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = '$userid';
    request.fields['title'] = title.text;
    request.files.add(await http.MultipartFile.fromPath(
      'sound',
      myfile.toString(),
    ));
    request.fields['date'] = dateInput.text;
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        _showMyDialog();
        Navigator.pop(context);
      });
      print(response);
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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    dateInput.text = ""; //set the initial value of text field
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
                            'สร้างรายการข้อความเสียงร้องเรียน',
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
                                'เลือก Up Load File Voice',
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
                            //       EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
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
                            //   padding:
                            //       EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            //   child: Column(
                            //     mainAxisSize: MainAxisSize.max,
                            //     children: [
                            //       Padding(
                            //         padding: EdgeInsetsDirectional.fromSTEB(
                            //             0, 5, 0, 10),
                            //         child: ClipRRect(
                            //           borderRadius: BorderRadius.circular(5),
                            //           child: Image.network(
                            //             'https://picsum.photos/seed/186/600',
                            //             width:
                            //                 MediaQuery.of(context).size.width,
                            //             height: 120,
                            //             fit: BoxFit.cover,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding:
                            //       EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
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
                            //         splashColor:
                            //             Color.fromARGB(255, 238, 144, 233),
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
                                        "Enter Date" //label text of field
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 20, 20, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: ElevatedButton.icon(
                                    onPressed: () {
                                      _Addvoice();
                                    },
                                    icon: Icon(Icons.arrow_right_outlined,
                                        size: 18),
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
                                      //     _Addvoice();
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
