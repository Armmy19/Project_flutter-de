import 'package:flutter/material.dart';
import 'package:test/complaint/com_add_text.dart';
import 'package:test/complaint/com_add_video.dart';
import 'package:test/complaint/com_add_voice.dart';
import 'package:test/complaint/com_list_text.dart';
import 'package:test/complaint/com_list_video.dart';
import 'package:test/complaint/com_list_voice.dart';

class com_main extends StatefulWidget {
  // const com_main({Key key}) : super(key: key);

  @override
  _com_mainState createState() => _com_mainState();
}

class _com_mainState extends State<com_main> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController controller = TextEditingController(
      text:
          'ระบบร้องเรียน เมนูร้องเรียน มีสามรูปแบบ ร้องเรียนด้วยเสียง  ร้องเรียนด้วยข้อความ ร้องเรียนด้วยวิดิโอ');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'ระบบร้องเรียน',
          style: TextStyle(
            fontFamily: 'Prompt',
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.keyboard_voice),
          //   tooltip: 'Show Snackbar',
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('อธิบายด้วยเสียง')));
          //     tts.speak(controller.text);
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute<void>(
              //   builder: (BuildContext context) {
              //     return Scaffold(
              //       appBar: AppBar(
              //         title: const Text('Next page'),
              //       ),
              //       body: const Center(
              //         child: Text(
              //           'อธิบายด้วยเสียง',
              //           style: TextStyle(fontSize: 24),
              //         ),
              //       ),
              //     );
              //   },
              // ));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Text(
                                'เมนูระบบร้องเรียน',
                                style: TextStyle(
                                  fontFamily: 'Prompt',
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
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 0, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFAFAFA),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xFFF0E4FF),
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 10, 10, 10),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                child: Image.network(
                                                  'https://d4all-onde.com/images/icon_text_02.png',
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 10, 10, 0),
                                            child: Text(
                                              'ข้อความร้องเรียน',
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 10, 0),
                                            child: Text(
                                              'ท่านสามารถจัดการ การร้องเรียนรูปแบบข้อความได้ที่เมนูนี้',
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 20, 5, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            com_list_text()));
                                              },
                                              icon: Icon(Icons.list, size: 18),
                                              label: Text("รายการร้องเรียน"),
                                            )
                                            // RaisedButton.icon(
                                            //   shape: RoundedRectangleBorder(
                                            //     borderRadius:
                                            //         BorderRadius.circular(5),
                                            //   ),
                                            //   label: Text(
                                            //     'รายการร้องเรียน',
                                            //     style: TextStyle(
                                            //       // color: Color.fromARGB(
                                            //       //     255, 255, 255, 255),
                                            //       fontSize: 12,
                                            //       fontWeight: FontWeight.normal,
                                            //     ),
                                            //   ),
                                            //   icon: Icon(
                                            //     Icons.list,
                                            //     // color:
                                            //     //     Color.fromARGB(255, 255, 255, 255),
                                            //   ),
                                            //   textColor: Colors.white,
                                            //   color: Color.fromARGB(
                                            //       255, 141, 62, 165),
                                            //   splashColor: Color.fromARGB(
                                            //       255, 238, 144, 233),
                                            //   onPressed: () {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 com_list_text()));
                                            //   },
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // ElevatedButton.icon(
                                            //   onPressed: () {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 com_add_text()));
                                            //   },
                                            //   icon: Icon(Icons.add, size: 18),
                                            //   label: Text("ร้องเรียน"),
                                            // )
                                            // RaisedButton.icon(
                                            //   shape: RoundedRectangleBorder(
                                            //     borderRadius:
                                            //         BorderRadius.circular(5),
                                            //   ),
                                            //   label: Text(
                                            //     'ร้องเรียน',
                                            //     style: TextStyle(
                                            //       // color: Color.fromARGB(
                                            //       //     255, 255, 255, 255),
                                            //       fontSize: 12,
                                            //       fontWeight: FontWeight.normal,
                                            //     ),
                                            //   ),
                                            //   icon: Icon(
                                            //     Icons.add,
                                            //     // color:
                                            //     //     Color.fromARGB(255, 255, 255, 255),
                                            //   ),
                                            //   textColor: Colors.white,
                                            //   color: Color.fromARGB(
                                            //       255, 141, 62, 165),
                                            //   splashColor: Color.fromARGB(
                                            //       255, 238, 144, 233),
                                            //   onPressed: () {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 com_add_text()));
                                            //   },
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 0, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFAFAFA),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xFFF0E4FF),
                                            width: 2,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 10, 10, 10),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                child: Image.network(
                                                  'https://d4all-onde.com/images/icon_voice_02.png',
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 10, 10, 0),
                                            child: Text(
                                              'ข้อความเสียงร้องเรียน',
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 10, 0),
                                            child: Text(
                                              'ท่านสามารถจัดการ การร้องเรียนรูปแบบข้อความเสียงได้ที่เมนูนี้',
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 20, 5, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            com_list_voice()));
                                              },
                                              icon: Icon(Icons.list, size: 18),
                                              label: Text("รายการร้องเรียน"),
                                            )
                                            // RaisedButton.icon(
                                            //   shape: RoundedRectangleBorder(
                                            //     borderRadius:
                                            //         BorderRadius.circular(5),
                                            //   ),
                                            //   label: Text(
                                            //     'รายการร้องเรียน',
                                            //     style: TextStyle(
                                            //       // color: Color.fromARGB(
                                            //       //     255, 255, 255, 255),
                                            //       fontSize: 12,
                                            //       fontWeight: FontWeight.normal,
                                            //     ),
                                            //   ),
                                            //   icon: Icon(
                                            //     Icons.list,
                                            //     // color:
                                            //     //     Color.fromARGB(255, 255, 255, 255),
                                            //   ),
                                            //   textColor: Colors.white,
                                            //   color: Color.fromARGB(
                                            //       255, 141, 62, 165),
                                            //   splashColor: Color.fromARGB(
                                            //       255, 238, 144, 233),
                                            //   onPressed: () {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 com_list_voice()));
                                            //   },
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // ElevatedButton.icon(
                                            //   onPressed: () {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 com_add_voice()));
                                            //   },
                                            //   icon: Icon(Icons.add, size: 18),
                                            //   label: Text("ร้องเรียน"),
                                            // )
                                            // RaisedButton.icon(
                                            //   shape: RoundedRectangleBorder(
                                            //     borderRadius:
                                            //         BorderRadius.circular(5),
                                            //   ),
                                            //   label: Text(
                                            //     'ร้องเรียน',
                                            //     style: TextStyle(
                                            //       // color: Color.fromARGB(
                                            //       //     255, 255, 255, 255),
                                            //       fontSize: 12,
                                            //       fontWeight: FontWeight.normal,
                                            //     ),
                                            //   ),
                                            //   icon: Icon(
                                            //     Icons.add,
                                            //     // color:
                                            //     //     Color.fromARGB(255, 255, 255, 255),
                                            //   ),
                                            //   textColor: Colors.white,
                                            //   color: Color.fromARGB(
                                            //       255, 141, 62, 165),
                                            //   splashColor: Color.fromARGB(
                                            //       255, 238, 144, 233),
                                            //   onPressed: () {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 com_add_voice()));
                                            //   },
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 0, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFAFAFA),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xFFF0E4FF),
                                            width: 2,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 10, 10, 10),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                child: Image.network(
                                                  'https://d4all-onde.com/images/icon_video_02.png',
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 10, 10, 0),
                                            child: Text(
                                              'วิดีโอร้องเรียน',
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 10, 0),
                                            child: Text(
                                              'ท่านสามารถจัดการ การร้องเรียนรูปแบบวิดีโอได้ที่เมนูนี้',
                                              style: TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 20, 5, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            com_list_video()));
                                              },
                                              icon: Icon(Icons.list, size: 18),
                                              label: Text("รายการร้องเรียน"),
                                            )
                                            // RaisedButton.icon(
                                            //   shape: RoundedRectangleBorder(
                                            //     borderRadius:
                                            //         BorderRadius.circular(5),
                                            //   ),
                                            //   label: Text(
                                            //     'รายการร้องเรียน',
                                            //     style: TextStyle(
                                            //       // color: Color.fromARGB(
                                            //       //     255, 255, 255, 255),
                                            //       fontSize: 12,
                                            //       fontWeight: FontWeight.normal,
                                            //     ),
                                            //   ),
                                            //   icon: Icon(
                                            //     Icons.list,
                                            //     // color:
                                            //     //     Color.fromARGB(255, 255, 255, 255),
                                            //   ),
                                            //   textColor: Colors.white,
                                            //   color: Color.fromARGB(
                                            //       255, 141, 62, 165),
                                            //   splashColor: Color.fromARGB(
                                            //       255, 238, 144, 233),
                                            //   onPressed: () {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 com_list_video()));
                                            //   },
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // ElevatedButton.icon(
                                            //   onPressed: () {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 com_add_video()));
                                            //   },
                                            //   icon: Icon(Icons.add, size: 18),
                                            //   label: Text("ร้องเรียน"),
                                            // )
                                            // RaisedButton.icon(
                                            //   shape: RoundedRectangleBorder(
                                            //     borderRadius:
                                            //         BorderRadius.circular(5),
                                            //   ),
                                            //   label: Text(
                                            //     'ร้องเรียน',
                                            //     style: TextStyle(
                                            //       // color: Color.fromARGB(
                                            //       //     255, 255, 255, 255),
                                            //       fontSize: 12,
                                            //       fontWeight: FontWeight.normal,
                                            //     ),
                                            //   ),
                                            //   icon: Icon(
                                            //     Icons.add,
                                            //     // color:
                                            //     //     Color.fromARGB(255, 255, 255, 255),
                                            //   ),
                                            //   textColor: Colors.white,
                                            //   color: Color.fromARGB(
                                            //       255, 141, 62, 165),
                                            //   splashColor: Color.fromARGB(
                                            //       255, 238, 144, 233),
                                            //   onPressed: () {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 com_add_video()));
                                            //   },
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ระบบการร้องเรียน',
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      color: Color(0xFF8D45AA),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 0, 5),
                                    child: Text(
                                      'ระบบการร้องเรียน  : เป็นระบบที่ช่วยให้สมาชิกส่งเรื่องร้องเรียนแจ้งปัญหามายังหน่วยงาน โดยจะแบ่งออกเป็น 3 รูปแบบ\n1. ข้อความร้องเรียน\n2. ข้อความเสียงร้องเรียน\n3. วิดีโอร้องเรียน',
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => com_add_video()));
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Editresume()));
        },
        label: Text("ร้องเรียน"),
        icon: Icon(Icons.edit),
        backgroundColor: Color.fromARGB(204, 200, 70, 81),
      ),
    );
  }
}
