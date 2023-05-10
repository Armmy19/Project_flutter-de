import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/chat_member.dart';
import 'package:test/api/chat_room_owner.dart';

class chr_user_edit_room extends StatefulWidget {
  final ChatRoomOwner room_id_user;
  const chr_user_edit_room({Key? key, required this.room_id_user})
      : super(key: key);

  @override
  _chr_user_edit_roomState createState() => _chr_user_edit_roomState();
}

class _chr_user_edit_roomState extends State<chr_user_edit_room> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<ChatMember> user_edit_room = [];
  late ChatRoomOwner id_room_user;
  Future<Null> getliseditroom() async {
    id_room_user = widget.room_id_user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');
    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=chat_member');
    var response = await http.post(url, body: {
      "room": id_room_user.room,
    });
    final responseJson = json.decode(response.body);
    print(responseJson);
    if (responseJson['status'] == 'success') {
      for (var user in responseJson['message']) {
        user_edit_room.add(ChatMember.fromJson(user));
      }
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user_edit_room.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'การจัดการสมาชิกในห้องสนทนา',
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
              Container(height: 500, child: list_edit_reg()),
            ],
          ),
        ),
      ),
    );
  }

  Widget list_edit_reg() {
    return FutureBuilder(
      future: getliseditroom(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: user_edit_room.length,
            itemBuilder: (context, index) {
              return Padding(
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
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 5, 0),
                                      child: Text(
                                        user_edit_room[index].name,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.timesCircle,
                                    color: Color(0xFFF75D59),
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
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
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
