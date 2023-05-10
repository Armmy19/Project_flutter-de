import 'package:flutter/material.dart';
import 'package:test/doctor/doctor_list.dart';
import 'package:test/doctor/doctorregister.dart';

class doc_main extends StatefulWidget {
  // const doc_main({Key key}) : super(key: key);

  @override
  _doc_mainState createState() => _doc_mainState();
}

class _doc_mainState extends State<doc_main> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController controller = TextEditingController(
      text:
          'ระบบสุขภาพ มีสองเมนู เข้าดูรายการลงทะเบียน  เข้าดูรายการห้องให้คำปรึกษา');

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
          'ระบบสุขภาพ',
          style: TextStyle(
            fontFamily: 'Poppins',
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
        ],
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
                            'เมนูระบบสุขภาพ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF8D45AA),
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
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFFE0D2E4),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://d4all-onde.com/images/doctor_call.png',
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 0, 10, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'รายการห้องให้คำปรึกษา',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF8D45AA),
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 5),
                                      child: Text(
                                        'ท่านสามารถค้นหารายการห้องให้คำปรึกษาและลงทะเบียนได้ จากเมนูนี้',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    doc_list()));
                                      },
                                      child: Text('เข้าดูรายการ'),
                                    )
                                    // RaisedButton.icon(
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(5),
                                    //   ),
                                    //   label: Text(
                                    //     'เข้าดูรายการ',
                                    //     style: TextStyle(
                                    //       // color: Color.fromARGB(
                                    //       //     255, 255, 255, 255),
                                    //       fontSize: 12,
                                    //       fontWeight: FontWeight.normal,
                                    //     ),
                                    //   ),
                                    //   icon: Icon(
                                    //     Icons.list,
                                    //   ),
                                    //   textColor: Colors.white,
                                    //   color: Color.fromARGB(255, 141, 62, 165),
                                    //   splashColor:
                                    //       Color.fromARGB(255, 238, 144, 233),
                                    //   onPressed: () {
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 doc_list()));
                                    //   },
                                    // ),
                                  ],
                                ),
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
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFFE0D2E4),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://d4all-onde.com/images/doctor.png',
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 0, 10, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'รายการลงทะเบียน',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF8D45AA),
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 5),
                                      child: Text(
                                        'ท่านสามารถตรวจสอบการลงทะเบียนขอรับคำปรึกษาได้ จากเมนูนี้',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    doc_reg()));
                                      },
                                      child: Text('เข้าดูรายการ'),
                                    ),
                                    // RaisedButton.icon(
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(5),
                                    //   ),
                                    //   label: Text(
                                    //     'เข้าดูรายการ',
                                    //     style: TextStyle(
                                    //       // color: Color.fromARGB(
                                    //       //     255, 255, 255, 255),
                                    //       fontSize: 12,
                                    //       fontWeight: FontWeight.normal,
                                    //     ),
                                    //   ),
                                    //   icon: Icon(
                                    //     Icons.list,
                                    //   ),
                                    //   textColor: Colors.white,
                                    //   color: Color.fromARGB(255, 141, 62, 165),
                                    //   splashColor:
                                    //       Color.fromARGB(255, 238, 144, 233),
                                    //   onPressed: () {
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 doc_reg()));
                                    //   },
                                    // ),
                                  ],
                                ),
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'รายการห้องให้คำปรึกษา',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF8D45AA),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                child: Text(
                                  'ระบบสุขภาพ  : เป็นระบบที่ช่วยให้สมาชิกได้เข้าลงทะเบียนเพื่อรับคำปรึกษาด้านสุขภาพแบบออนไลน์ ในรูปแบบการ Video Call สมาชิกสามารถสอบถามปัญหาด้านสุขภาพเบื้องต้นได้ก่อน ช่วยในการตัดสินใจที่จะเดินทางไปพบแพทย์หรือไม่สะดวกในทางเดินทางไปพบแพทย์ได้',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
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
        ),
      ),
    );
  }
}
