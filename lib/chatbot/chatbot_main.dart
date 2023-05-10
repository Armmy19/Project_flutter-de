import 'package:flutter/material.dart';
import 'package:test/chatbot/chatbot_send_text.dart';

class chatbot_main extends StatefulWidget {
  // const chatbot_main({Key key}) : super(key: key);

  @override
  _chatbot_mainState createState() => _chatbot_mainState();
}

class _chatbot_mainState extends State<chatbot_main> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController controller = TextEditingController(
      text:
          'ระบบ สอบถามข้อมูล  เป็นระบบประมวลข้อมูล ที่ช่วยให้ผู้ใช้สามารถสอบถามโต้ตอบกับระบบบริการเว็บหรือแอป สามารถตอบคำถามของท่านแบบอัตโนมัติได้ ซึ่งระบบจะให้ข้อมูลเกี่ยวกับผู้สูงอายุและคนพิการ ท่านสามารถสอบถามข้อมูลได้ด้วยการพิมพ์ข้อความผ่านช่องแชท เมื่อมีข้อมูลส่งเข้ามายังระบบ ระบบจะประมวลผลออกมาให้ตามข้อมูลที่ได้สอบถามนั้นๆ  เข้าใช้งานด้วยการกดที่ปุ่มด้านล่างขวาของหน้าจอ');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xCC45156C),
        automaticallyImplyLeading: true,
        title: Text(
          'Chat Bot',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: <Widget>[],
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
                      'ระบบแชทบอทสอบถามข้อมูล',
                      style: TextStyle(
                        color: Color(0xFF543062),
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
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
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                        child: Text(
                          'แชทบอท เป็นระบบประมวลข้อมูล ที่ช่วยให้ผู้ใช้สามารถสอบถามโต้ตอบกับระบบบริการเว็บหรือแอป สามารถตอบคำถามของท่านแบบอัตโนมัติได้ ซึ่งระบบจะให้ข้อมูลเกี่ยวกับผู้สูงอายุและคนพิการ ท่านสามารถสอบถามข้อมูลได้ด้วยการพิมพ์ข้อความผ่านช่องแชท เมื่อมีข้อมูลส่งเข้ามายังระบบ ระบบจะประมวลผลออกมาให้ตามข้อมูลที่ได้สอบถามนั้นๆ',
                          style: TextStyle(
                            color: Color(0xCC62297B),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            chatbot_send_text()));
                              },
                              icon: Icon(Icons.input, size: 18),
                              label: Text("เข้าใช้งานระบบ"),
                            )
                            // RaisedButton.icon(
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(5),
                            //   ),
                            //   label: Text(
                            //     'เข้าใช้งานระบบ',
                            //     style: TextStyle(
                            //       // color: Color.fromARGB(
                            //       //     255, 255, 255, 255),
                            //       fontSize: 12,
                            //       fontWeight: FontWeight.normal,
                            //     ),
                            //   ),
                            //   icon: Icon(
                            //     Icons.upload_sharp,
                            //   ),
                            //   textColor: Colors.white,
                            //   color: Color.fromARGB(255, 141, 62, 165),
                            //   splashColor: Color.fromARGB(255, 238, 144, 233),
                            //   onPressed: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 chatbot_send_text()));
                            //   },
                            // ),
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
