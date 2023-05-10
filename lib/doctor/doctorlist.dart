import 'package:flutter/material.dart';
import 'package:test/doctor/doctordetail.dart';

class doc_list extends StatefulWidget {
  // const doc_list({Key key}) : super(key: key);

  @override
  _doc_listState createState() => _doc_listState();
}

class _doc_listState extends State<doc_list> {
  // TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'รายการห้องให้คำปรึกษา',
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
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xffF5F5F5),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: TextFormField(
                            // controller: textController,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'กรอกคำค้นหา ...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffF5F5F5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffF5F5F5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xffF5F5F5),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'อาการตาพร่ามัว',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xCC62297B),
                                  fontSize: 24,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 10),
                                child: Text(
                                  'รายละเอียดหัวข้อ : อาการตาพร่ามัวเป็นอีกหนึ่งปัญหาของการมองเห็นผิดปกติ ผู้ป่วยจะมองภาพไม่ชัดเจน',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Text(
                                'ผู้ให้คำปรึกษา : อภิชาติ บาดาล',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: Text(
                                  'จำนวนที่เปิดรับต่อวัน : 20 ท่าน',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    doc_detail()));
                                      },
                                      child: Text('รายละเอียด'),
                                    )
                                        // RaisedButton.icon(
                                        //   shape: RoundedRectangleBorder(
                                        //     borderRadius:
                                        //         BorderRadius.circular(5),
                                        //   ),
                                        //   label: Text(
                                        //     'รายละเอียด',
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
                                        //   color:
                                        //       Color.fromARGB(255, 141, 62, 165),
                                        //   splashColor:
                                        //       Color.fromARGB(255, 238, 144, 233),
                                        //   onPressed: () {
                                        //     Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //             builder: (context) =>
                                        //                 doc_detail()));
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
