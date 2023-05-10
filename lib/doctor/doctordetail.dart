import 'package:flutter/material.dart';

class doc_detail extends StatefulWidget {
  // const doc_detail({Key key}) : super(key: key);

  @override
  _doc_detailState createState() => _doc_detailState();
}

class _doc_detailState extends State<doc_detail> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0xffF5F5F5),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: Text(
                                'รายละเอียดหัวข้อ : อาการตาพร่ามัวเป็นอีกหนึ่งปัญหาของการมองเห็นผิดปกติ ผู้ป่วยจะมองภาพไม่ชัดเจน หรือเห็นภาพเลือนลาง ถ้าหากเป็นมากจะไม่สามารถจำแนกได้ว่าภาพนั้นคืออะไร ส่งผลต่อการใช้ชีวิตประจำวันโดยตรง อาการตาพร่ามัวยังเป็นสัญญาณอันตรายของโรคร้ายบางอย่าง ที่ทำให้เกิดภาวะพิการทางสายตาได้ อาทิ โรคต้อหิน โรคต้อกระจก เป็นต้น',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      'https://picsum.photos/seed/453/600',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ผู้ให้คำปรึกษา',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'นาย อภิชาติ บาดาล',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            'เลขที่ใบอนุญาต : 2550123456',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'วันที่เปิด : อังคาร/พฤหัสบดี/เสาร์',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Text(
                              'เปิด - ปิด ทำการเวลา  : 10.00 - 18.00  น.',
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
                                    child: Text('ลงทะเบียน'),
                                  )
                                      // RaisedButton.icon(
                                      //   shape: RoundedRectangleBorder(
                                      //     borderRadius: BorderRadius.circular(5),
                                      //   ),
                                      //   label: Text(
                                      //     'ลงทะเบียน',
                                      //     style: TextStyle(
                                      //       // color: Color.fromARGB(
                                      //       //     255, 255, 255, 255),
                                      //       fontSize: 12,
                                      //       fontWeight: FontWeight.normal,
                                      //     ),
                                      //   ),
                                      //   icon: Icon(
                                      //     Icons.how_to_reg,
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
