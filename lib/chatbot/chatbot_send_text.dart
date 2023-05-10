import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/chatbot.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class chatbot_send_text extends StatefulWidget {
  // const chatbot_send_text({Key key}) : super(key: key);

  @override
  _chatbot_send_textState createState() => _chatbot_send_textState();
}

class _chatbot_send_textState extends State<chatbot_send_text>
    with SingleTickerProviderStateMixin {
  // TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController question = new TextEditingController(text: '');
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final _formKey = GlobalKey<FormState>();

  late Chatbot chat;
  var name;
  var linktoc;
  var v;
  // Get json result and convert it to model. Then add
  Future<void> loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');

    Uri url =
        Uri.parse('https://d4all-onde.com/api/webservice.php?service=chatbot');
    var response = await http.post(url, body: {
      "id": userid,
      "question": question.text,
    });
    var data = json.decode(response.body);
    if (data['status'] == 'success') {
      chat = chatbotFromJson(response.body);
      setState(() {
        name = chat.message.replies;
        linktoc = chat.message.link;
        v = question.text;
        question.text = '';
      });
    } else {
      setState(() {
        name = 'ต้องขออภัยด้วยนะครับ ไม่พบข้อมูลจากข้อความที่คุณส่งมาครับ';
        linktoc = '';
        v = question.text;
        question.text = '';
      });
    }
    _playAnimation();
  }

  late AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 1000),
  );

  // Create async function to bring the controller controller.repeat() for 500 ms
  Future<void> _playAnimation() async {
    _controller.repeat();
    await Future.delayed(Duration(milliseconds: 500));
    _controller.stop();
    _controller.forward();
  }

  @override
  void initState() {
    loadList();
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: name == null
          ? LinearProgressIndicator()
          : RefreshIndicator(
              key: _refreshIndicatorKey,
              color: Colors.white,
              backgroundColor: Color(0xFF7968A6),
              strokeWidth: 4.0,
              onRefresh: () async {
                // Replace this delay with the code to be executed during refresh
                // and return a Future when code finishs execution.
                return Future<void>.delayed(const Duration(seconds: 3));
              },
              // Pull from top to show refresh indicator.
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return SafeArea(
                    child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // chatlist(),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: SingleChildScrollView(
                                  reverse: true,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(20, 20, 20, 20),
                                              child: v == ''
                                                  ? Text('')
                                                  : Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFF9EAFE),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xFFFBD4F2),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          10),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                    v,
                                                                    style:
                                                                        TextStyle(),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.arrow_right,
                                                          color: Colors.black,
                                                          size: 24,
                                                        ),
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          child: Container(
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                          Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: AnimatedBuilder(
                                                animation: _controller,
                                                builder: (context, child) {
                                                  return AnimatedOpacity(
                                                    opacity:
                                                        _controller.value >= 0.5
                                                            ? 1
                                                            : 0,
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(20, 20,
                                                                  20, 20),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xffe5e9f0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: Container(
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                'https://d4all-onde.com/bot/image_bot/robot.png',
                                                              ),
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.arrow_left,
                                                            color: Colors.black,
                                                            size: 24,
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border:
                                                                    Border.all(
                                                                  color: Color(
                                                                      0xFFF3D9FA),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            10,
                                                                            10,
                                                                            10),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      name,
                                                                      style:
                                                                          TextStyle(),
                                                                    ),
                                                                    Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                        child: linktoc !=
                                                                                ''
                                                                            ? ElevatedButton.icon(
                                                                                onPressed: () async {
                                                                                  launch("$linktoc");
                                                                                },
                                                                                icon: Icon(Icons.input, size: 18),
                                                                                label: Text("เข้าดูรายละเอียด"),
                                                                              )
                                                                            :
                                                                            // Do nothing.
                                                                            Container())
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xCC62297B),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          controller: question,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle: TextStyle(),
                                            hintText: 'Send message ...',
                                            hintStyle: TextStyle(),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(0),
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          style: TextStyle(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(5),
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.send,
                                          color: Color(0xCC45156C),
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          loadList();
                                          _refreshIndicatorKey.currentState
                                              ?.show();
                                        },
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
                },
              ),
            ),
    );
  }
}
