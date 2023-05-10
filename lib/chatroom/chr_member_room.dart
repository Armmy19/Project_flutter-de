import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/chat_room_owner.dart';
import 'package:test/api/chat_room_registed.dart';
import 'package:test/chatroom/chr_chat_room.dart';
import 'package:test/chatroom/chr_chat_user.dart';

class chr_member_room extends StatefulWidget {
  const chr_member_room({Key? key}) : super(key: key);

  @override
  _chr_member_roomState createState() => _chr_member_roomState();
}

class _chr_member_roomState extends State<chr_member_room> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<ChatRoomRegisted> member_room = [];

  Future<void> getlistmemberroom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');
    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=chat_room_registed');
    var response = await http.post(url, body: {
      "id": userid,
    });
    final responseJson = json.decode(response.body);
    print(responseJson);
    if (responseJson['status'] == 'success') {
      member_room.clear();
      for (var user in responseJson['message']) {
        member_room.add(ChatRoomRegisted.fromJson(user));
      }
    } else {
      print('no data');
    }
  }

  @override
  void initState() {
    member_room.clear();
    super.initState();
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
      body: SafeArea(child: list_member_room()),
    );
  }

  Widget list_member_room() {
    return FutureBuilder(
      future: getlistmemberroom(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (member_room.length == 0) {
            return Center(
              child: Text('ไม่มีข้อมูล'),
            );
          } else {
            return ListView.builder(
              itemCount: member_room.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 10, 20, 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    member_room[index].title,
                                    style: GoogleFonts.getFont(
                                      'Prompt',
                                      color: Color(0xFF8562C4),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 5),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Color(0xFFE0E3E7),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    member_room[index].detail,
                                                    style: GoogleFonts.getFont(
                                                      'Prompt',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 5, 0, 0),
                                                    child: Text(
                                                      'เมื่อวันที่ : ${member_room[index].datetime} น.',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Prompt',
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 5, 0, 0),
                                                    child: Text(
                                                      'จำนวนสมาชิกปัจจุบัน ${member_room[index].member} คน',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Prompt',
                                                        fontWeight:
                                                            FontWeight.normal,
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
                                  ),
                                ],
                              ),
                            ),
                            // Generated code for this Row Widget...
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 5, 20, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.solidCommentDots,
                                          color: Color(0xCC45156C),
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      chr_chat_user(
                                                          room_id_chat:
                                                              member_room[
                                                                  index])));
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.timesCircle,
                                          color: Color(0xFFF75D59),
                                          size: 20,
                                        ),
                                        onPressed: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? userid =
                                              prefs.getString('userid');
                                          final Uri url = Uri.parse(
                                              'https://d4all-onde.com/api/webservice.php?service=chat_request_delete');
                                          var response =
                                              await http.post(url, body: {
                                            "room": member_room[index].room,
                                            "id": userid,
                                          });
                                          var data = json.decode(response.body);
                                          if (data['status'] == 'success') {
                                            Navigator.pop(context);
                                          } else {
                                            print('error');
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
