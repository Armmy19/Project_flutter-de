import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test/api/chat_member_request.dart';
import 'package:test/api/chat_room_owner.dart';

class chr_user_reg_room extends StatefulWidget {
  final ChatRoomOwner room_id;
  const chr_user_reg_room({Key? key, required this.room_id}) : super(key: key);

  @override
  _chr_user_reg_roomState createState() => _chr_user_reg_roomState();
}

class _chr_user_reg_roomState extends State<chr_user_reg_room> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<ChatMemberRequest> user_reg_room = [];
  late ChatRoomOwner id_room;
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('รายการส่งคำขอเข้าร่วมห้อง'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(''),
                Text('ยังไม่มีรายการคำขอเข้าร่วม'),
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

  Future<Null> getlisuserroom() async {
    id_room = widget.room_id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');
    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=chat_member_request');
    var response = await http.post(url, body: {
      "room": id_room.room,
    });
    final responseJson = json.decode(response.body);
    print(responseJson);
    if (responseJson['status'] == 'success') {
      for (var user in responseJson['message']) {
        user_reg_room.add(ChatMemberRequest.fromJson(user));
      }
    } else {
      _showMyDialog();
    }
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
      body: SafeArea(
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                        child: Text(
                          'รายการส่งคำขอเข้าร่วมห้องสนทนา',
                          style: GoogleFonts.getFont(
                            'Prompt',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // color: Colors.blue,
                  height: 500,
                  child: list_user_reg(),
                )
              ],
            )),
      ),
    );
  }

  Widget list_user_reg() {
    return FutureBuilder(
      future: getlisuserroom(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: user_reg_room.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          'https://picsum.photos/seed/581/600',
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 0, 5, 0),
                                          child: Text(
                                            user_reg_room[index].name,
                                            style: GoogleFonts.getFont(
                                              'Prompt',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 5, 0),
                                      child: IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.userCheck,
                                          color: Color(0xFF74B816),
                                          size: 20,
                                        ),
                                        onPressed: () async {
                                          id_room = widget.room_id;

                                          final Uri url = Uri.parse(
                                              'https://d4all-onde.com/api/webservice.php?service=chat_member_approve');
                                          var response =
                                              await http.post(url, body: {
                                            "id": user_reg_room[index].id,
                                            "room": id_room.room,
                                          });
                                          var data = json.decode(response.body);
                                          if (data['status'] == 'success') {
                                            Navigator.pop(context);
                                          } else {
                                            print('error');
                                          }
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: FaIcon(
                                        FontAwesomeIcons.timesCircle,
                                        color: Color(0xFFF75D59),
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             chr_member_room()));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
