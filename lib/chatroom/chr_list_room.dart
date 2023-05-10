import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/chat_room_registed.dart';
import 'package:test/api/list_chat_room.dart';
import 'package:test/chatroom/chr_chat_room.dart';
import 'package:test/chatroom/chr_chat_user.dart';

import 'package:http/http.dart' as http;

class chr_list_room extends StatefulWidget {
  const chr_list_room({Key? key}) : super(key: key);

  @override
  _chr_list_roomState createState() => _chr_list_roomState();
}

class _chr_list_roomState extends State<chr_list_room> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchTextController = new TextEditingController();
  List<ListChatRoom> _searchResult = [];
  List<ListChatRoom> _userDetails = [];
  List<ListChatRoom> _sourceUserDetails = [];

  // Create variable to sotre if api is loaded
  bool _isLoading = false;

  Future<Null> getlistchat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    if (_isLoading == false) {
      print("Refresh");
      print('====== $userid');
      final Uri url = Uri.parse(
          'https://d4all-onde.com/api/webservice.php?service=chat_room');
      var response = await http.post(url, body: {
        "id": userid,
      });
      final responseJson = json.decode(response.body);
      _userDetails.clear();
      _sourceUserDetails.clear();

      for (var user in responseJson['message']) {
        _userDetails.add(ListChatRoom.fromJson(user));
        _sourceUserDetails.add(ListChatRoom.fromJson(user));
      }
      _isLoading = true;
    }
  }

  @override
  void initState() {
    super.initState();

    _userDetails.clear(); //การลบข้อมูลก่อนหน้า
  }

  @override
  void dispose() {
    textController?.dispose();
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
      body: SafeArea(
        child: GestureDetector(
            child: Column(
          children: <Widget>[
            new Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'รายการห้องสนทนา',
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
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'ค้นหาห้องสนทนา',
                          style: GoogleFonts.getFont(
                            'Prompt',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: searchTextController,
                            onChanged: onSearchTextChanged,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelStyle: GoogleFonts.getFont(
                                'Prompt',
                              ),
                              hintStyle: TextStyle(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFD9D8D8),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFD9D8D8),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                            ),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            new Expanded(
              child: _searchResult.length != 0
                  ? Text("ไม่พบข้อมูล")
                  : FutureBuilder(
                      future: getlistchat(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                            itemCount: _userDetails.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              _userDetails[index].title,
                                              style: GoogleFonts.getFont(
                                                'Prompt',
                                                color: Color(0xFF8562C4),
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 5, 0, 5),
                                              child: Text(
                                                _userDetails[index].detail,
                                                style: GoogleFonts.getFont(
                                                  'Prompt',
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'เมื่อวันที่ : ${_userDetails[index].datetime} น.',
                                              style: GoogleFonts.getFont(
                                                'Prompt',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 20),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(0xFFE0E3E7),
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 10, 10, 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Text(
                                                        'ผู้จัดการห้องสนทนา',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Prompt',
                                                          color:
                                                              Color(0xFF8562C4),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${_userDetails[index].name}',
                                                        style:
                                                            GoogleFonts.getFont(
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
                                                          'จำนวนสมาชิกปัจจุบัน ${_userDetails[index].member} คน',
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Prompt',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
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
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 10),
                                        child: _userDetails[index].status == 0
                                            ? Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                    child: Text('ขอเข้าร่วม'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      surfaceTintColor:
                                                          Color(0xCC45156C),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5), // <-- Radius
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      String? userid = prefs
                                                          .getString('userid');
                                                      final Uri url = Uri.parse(
                                                          'https://d4all-onde.com/api/webservice.php?service=chat_request');
                                                      var response = await http
                                                          .post(url, body: {
                                                        "id": userid,
                                                        "room":
                                                            _userDetails[index]
                                                                .room,
                                                      });
                                                      var data = json.decode(
                                                          response.body);
                                                      if (data['status'] ==
                                                          'success') {
                                                        _isLoading = false;
                                                        setState(() {
                                                          getlistchat();
                                                        });
                                                      } else {
                                                        print('error');
                                                      }
                                                    },
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: ElevatedButton(
                                                      child: Text('ไปที่ห้อง'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        surfaceTintColor:
                                                            Color(0xFFFFA94D),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  5), // <-- Radius
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        chr_chat_user(
                                                                          room_id_chat:
                                                                              ChatRoomRegisted(
                                                                            id: _userDetails[index].id,
                                                                            room:
                                                                                _userDetails[index].room,
                                                                            title:
                                                                                _userDetails[index].title,
                                                                            detail:
                                                                                _userDetails[index].detail,
                                                                            datetime:
                                                                                _userDetails[index].datetime,
                                                                            chatRoomRegistedClass:
                                                                                _userDetails[index].listChatRoomClass,
                                                                            name:
                                                                                _userDetails[index].name,
                                                                            status:
                                                                                _userDetails[index].status,
                                                                            member:
                                                                                _userDetails[index].member,
                                                                          ),
                                                                        )));
                                                      },
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    child: Text(
                                                        'ยกเลิกการเข้าร่วม'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      surfaceTintColor:
                                                          Color(0xFFFF6B6B),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5), // <-- Radius
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      String? userid = prefs
                                                          .getString('userid');
                                                      final Uri url = Uri.parse(
                                                          'https://d4all-onde.com/api/webservice.php?service=chat_request_delete');
                                                      var response = await http
                                                          .post(url, body: {
                                                        "id": userid,
                                                        "room":
                                                            _userDetails[index]
                                                                .room,
                                                      });
                                                      var data = json.decode(
                                                          response.body);
                                                      if (data['status'] ==
                                                          'success') {
                                                        _isLoading = false;
                                                        setState(() {
                                                          getlistchat();
                                                        });
                                                      } else {
                                                        print('error');
                                                      }
                                                    },
                                                  )
                                                ],
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
            ),
          ],
        )),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _userDetails.clear();
    if (text.isEmpty) {
      _userDetails.addAll(_sourceUserDetails);
      return;
    }

    _sourceUserDetails.forEach((userDetail) {
      if (userDetail.title.toLowerCase().contains(text) ||
          userDetail.id.toLowerCase().contains(text))
        _userDetails.add(userDetail);
    });
    print("_userDetails");
    print(_userDetails);
    // Print all _userDetails
    _userDetails.forEach((userDetail) {
      print(userDetail);
    });

    print("_sourceUserDetails");
    print(_sourceUserDetails);
  }
}
