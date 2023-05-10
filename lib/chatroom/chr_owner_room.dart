import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/chat_room_owner.dart';
import 'package:test/chatroom/chr_chat_room.dart';
import 'package:test/chatroom/chr_edit_room.dart';
import 'package:test/chatroom/chr_open_room.dart';
import 'package:test/chatroom/chr_user_edit_room.dart';
import 'package:test/chatroom/chr_user_reg_room.dart';

class chr_owner_room extends StatefulWidget {
  const chr_owner_room({Key? key}) : super(key: key);

  @override
  _chr_owner_roomState createState() => _chr_owner_roomState();
}

class _chr_owner_roomState extends State<chr_owner_room> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isApiCallProcess = false;

  List<ChatRoomOwner> ilst_memberroom = [];
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยังไม่เปิดห้องสนทนา'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: FaIcon(
                          Icons.add,
                          color: Color(0xFFFFFFFF),
                          size: 20,
                        ),
                        label: Text("เปิดห้องสนทนา"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => chr_open_room(
                                        doRefresh: _refresh,
                                      )));
                        },
                      ),
                    ],
                  ),
                ),
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

  Future<void> getlistmemberroom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    if (_isApiCallProcess == false) {
      final Uri url = Uri.parse(
          'https://d4all-onde.com/api/webservice.php?service=chat_room_owner');
      var response = await http.post(url, body: {
        "id": userid,
      });
      final responseJson = json.decode(response.body);
      print("Chat room owner");
      print(responseJson);
      if (responseJson['status'] == 'success') {
        _isApiCallProcess = true;
        ilst_memberroom.clear();
        for (var user in responseJson['message']) {
          ilst_memberroom.add(ChatRoomOwner.fromJson(user));
        }
      } else {
        ilst_memberroom.clear();
      }
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _isApiCallProcess = false;
      getlistmemberroom();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ilst_memberroom.clear();
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'รายการการเปิดห้องสนทนา',
                    style: GoogleFonts.getFont(
                      'Prompt',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    icon: FaIcon(
                      Icons.add,
                      color: Color(0xFFFFFFFF),
                      size: 20,
                    ),
                    label: Text("เปิดห้องสนทนา"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => chr_open_room(
                                    doRefresh: _refresh,
                                  )));
                    },
                  ),
                ],
              ),
            ),
            Container(
              // color: Colors.black,
              height: 400,
              child: list_show(),
            )
          ],
        ));
  }

  Widget list_show() {
    return FutureBuilder(
      future: getlistmemberroom(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (ilst_memberroom.length == 0) {
            return Center(
              child: Text(
                'ไม่มีรายการ',
                style: GoogleFonts.getFont(
                  'Prompt',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: ilst_memberroom.length,
              itemBuilder: (context, index) {
                return Padding(
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                ilst_memberroom[index].title,
                                style: GoogleFonts.getFont(
                                  'Prompt',
                                  color: Color(0xFF8562C4),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
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
                                                ilst_memberroom[index].detail,
                                                style: GoogleFonts.getFont(
                                                  'Prompt',
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 5, 0, 0),
                                                child: Text(
                                                  'เมื่อวันที่ : ${ilst_memberroom[index].datetime} น.',
                                                  style: GoogleFonts.getFont(
                                                    'Prompt',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 5, 0, 0),
                                                child: Text(
                                                  'จำนวนสมาชิกปัจจุบัน ${ilst_memberroom[index].member} คน',
                                                  style: GoogleFonts.getFont(
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
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 5, 20, 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.userClock,
                                      color: Color(0xCC45156C),
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  chr_user_reg_room(
                                                      room_id: ilst_memberroom[
                                                          index])));
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: IconButton(
                                      icon: FaIcon(
                                        FontAwesomeIcons.usersCog,
                                        color: Color(0xCC45156C),
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    chr_user_edit_room(
                                                      room_id_user:
                                                          ilst_memberroom[
                                                              index],
                                                    )));
                                      },
                                    ),
                                  ),
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
                                                  chr_chat_room(
                                                    room_id_chat:
                                                        ilst_memberroom[index],
                                                  )));
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 10, 0),
                                    child: IconButton(
                                      icon: FaIcon(
                                        FontAwesomeIcons.edit,
                                        color: Color(0xCC45156C),
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    chr_edit_room(
                                                      data: ilst_memberroom[
                                                          index],
                                                      refresh: _refresh,
                                                    )));
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.timesCircle,
                                      color: Color(0xFFF75D59),
                                      size: 20,
                                    ),
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      String? userid =
                                          prefs.getString('userid');
                                      final Uri url = Uri.parse(
                                          'https://d4all-onde.com/api/webservice.php?service=chat_delete');
                                      var response =
                                          await http.post(url, body: {
                                        "room": ilst_memberroom[index].room,
                                      });
                                      var data = json.decode(response.body);
                                      print("Chat Request Delete");
                                      print("User id : $userid");
                                      print(
                                          "Room id : ${ilst_memberroom[index].room}");
                                      print(data);
                                      if (data['status'] == 'success') {
                                        // Navigator.pop(context);
                                        _refresh();
                                      } else {
                                        print('error');
                                      }
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

  // ListView(
  //   padding: EdgeInsets.zero,
  //   scrollDirection: Axis.vertical,
  //   children: [
  //   ],
  // ),
}
