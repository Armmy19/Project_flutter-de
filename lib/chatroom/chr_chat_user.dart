import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/chat_message.dart';
import 'package:test/api/chat_room_owner.dart';
import 'package:test/api/chat_room_registed.dart';
import 'dart:async';

class chr_chat_user extends StatefulWidget {
  final ChatRoomRegisted room_id_chat;
  const chr_chat_user({Key? key, required this.room_id_chat}) : super(key: key);

  @override
  _chr_chat_userState createState() => _chr_chat_userState();
}

class _chr_chat_userState extends State<chr_chat_user> {
  late Timer _timer;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController senr = TextEditingController();
  List<ChatMessage> user_chat_room = [];
  late ChatRoomRegisted id_room_chat;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController = ScrollController();
  String name = '1';
  var id_user;
  Future<void> getliseditroom() async {
    id_room_chat = widget.room_id_chat;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');
    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=chat_message');
    var response = await http.post(url, body: {
      "room": id_room_chat.room,
    });
    final responseJson = json.decode(response.body);
    print(responseJson);

    _refreshIndicatorKey.currentState?.show();
    if (responseJson['status'] == 'success') {
      setState(() {
        name = '1';
        id_user = userid;
      });
      user_chat_room.clear();
      for (var user in responseJson['message']) {
        user_chat_room.add(ChatMessage.fromJson(user));
      }
    } else {}
  }

  Future<Null> message_send() async {
    id_room_chat = widget.room_id_chat;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');
    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=chat_message_send');
    var response = await http.post(url, body: {
      "room": id_room_chat.room,
      "id": userid,
      "message": senr.text,
    });
    final responseJson = json.decode(response.body);
    if (responseJson['status'] == 'success') {
      getliseditroom();
      user_chat_room.clear();
      _refreshIndicatorKey.currentState?.show();
      senr.clear();
      print('yes');
    } else {}
  }

  void scrollDowd() {
    final double end = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(end,
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    getliseditroom();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getliseditroom();
      scrollDowd();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            'ระบบห้องสนทนา',
            style: GoogleFonts.getFont(
              'Prompt',
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 22,
            ),
          ),
        ),
        body: name == null
            ? LinearProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: list_user_chat()),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Color(0xCC45156C),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 10, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: senr,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintStyle: GoogleFonts.getFont(
                                  'Prompt',
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: GoogleFonts.getFont(
                                'Prompt',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.solidArrowAltCircleRight,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              message_send();
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.easeInBack);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }

  Widget list_user_chat() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: user_chat_room.length + 1,
      itemBuilder: (context, index) {
        if (index == user_chat_room.length) {
          return Container(
              // height: 100,
              );
        }
        return Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        'https://picsum.photos/seed/581/600',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                user_chat_room[index].sender,
                                style: GoogleFonts.getFont(
                                  'Prompt',
                                  color: Color(0xFF57636C),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 3, 0),
                              child: Icon(
                                Icons.access_time,
                                color: Color(0xFF57636C),
                                size: 10,
                              ),
                            ),
                            Text(
                              '${user_chat_room[index].datetime} น.',
                              style: GoogleFonts.getFont(
                                'Prompt',
                                color: Color(0xFF57636C),
                                fontWeight: FontWeight.normal,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  user_chat_room[index].senderId == '${id_user}'
                      ? IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () async {
                            id_room_chat = widget.room_id_chat;
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String? userid = prefs.getString('userid');
                            print('====== $userid');
                            final Uri url = Uri.parse(
                                'https://d4all-onde.com/api/webservice.php?service=chat_message_delete');
                            var response = await http.post(url, body: {
                              "id": userid,
                              "message": user_chat_room[index].id,
                            });
                            final responseJson = json.decode(response.body);
                            if (responseJson['status'] == 'success') {
                              getliseditroom();
                              user_chat_room.clear();
                              _refreshIndicatorKey.currentState?.show();
                              print('yes');
                            } else {}
                          })
                      : Text(
                          'สมาชิก',
                          style: GoogleFonts.getFont(
                            'Prompt',
                            color: Color(0xFF57636C),
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                          ),
                        )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 5, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xFFE0D2E4),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                        child: Text(
                          user_chat_room[index].message,
                          style: GoogleFonts.getFont(
                            'Prompt',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
