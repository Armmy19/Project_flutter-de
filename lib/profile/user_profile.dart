import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/showaddress.dart';
import 'package:test/api/showmaps.dart';
import 'package:test/api/showprofile.dart';
import 'package:test/profile/edit_address.dart';
import 'package:test/profile/edit_map.dart';
import 'package:test/profile/edit_profile.dart';
import 'package:test/profile/edit_profile_image.dart';
import 'package:test/profile/edit_profile_password.dart';
import 'package:test/test.dart';

class user_profile extends StatefulWidget {
  const user_profile({Key? key}) : super(key: key);

  @override
  _user_profileState createState() => _user_profileState();
}

class _user_profileState extends State<user_profile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? name;
  String? lname;
  String? email;
  String? img;
  late ProfileShow show;
  late Youaddress address;
  late Youmaps maps;

  final TextEditingController controller = TextEditingController(
      text: 'เมนูสำหรับการแก้ไข รูปภาพโปรไฟล์ เปลี่ยนรหัสผ่าน แก้ไขที่อยู่');

  Future<void> Profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=user_profile');
    var response = await http.post(url, body: {
      "id": '$userid',
    });
    var data = json.decode(response.body);
    print('user_profile');
    print(data);
    show = profileShowFromJson(response.body);

    if (data["status"] == "success") {
      setState(() {
        GotoHome(show);
        img = show.message.profileImg;
        name = show.message.userName;
        lname = show.message.userLastname;
        email = show.message.userEmail;
      });
      print(data);
    } else {
      print('error');
    }
  }

  Future<void> GotoHome(ProfileShow show) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profile', show.message.profileImg);
    String? c = prefs.getString('profile');
    print(c);
    // print(email);
    // runApp(MaterialApp(home: email == null ? Login() : Home()));
  }

  Future<void> data_Profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=user_profile');
    var response = await http.post(url, body: {
      "id": '$userid',
    });
    var data = json.decode(response.body);
    show = profileShowFromJson(response.body);

    if (data["status"] == "success") {
      print(data);
    } else {
      print('error');
    }
  }

  Future<void> data_address() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=user_address');
    var response = await http.post(url, body: {
      "id": '$userid',
    });
    var datadderss = json.decode(response.body);
    address = youaddressFromJson(response.body);
    return datadderss;
  }

  Future<void> data_maps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    Uri url =
        Uri.parse('https://d4all-onde.com/api/webservice.php?service=user_map');
    var response = await http.post(url, body: {
      "id": '$userid',
    });
    var datamap = json.decode(response.body);
    maps = youmapsFromJson(response.body);
    return datamap;
  }

  @override
  void initState() {
    Profile();
    // data_maps();
    super.initState();
  }

  Future<void> refresh() async {
    // Delay 1 second
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      Profile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF6F7F9),
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        primary: false,
        scrollDirection: Axis.vertical,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xCC45156C),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Color(0xFFE0E3E7),
                            ),
                          ),
                          child: Container(
                              width: 120,
                              height: 120,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: img == null
                                  ? Image.network(
                                      'https://img.freepik.com/free-photo/lifestyle-network-career-working-adult_1262-2430.jpg?w=826&t=st=1660034004~exp=1660034604~hmac=40bf432ca8ffe20b4707b30886cc9ccb6ae55b0fa5a0b665bd9f6ac510040413',
                                      fit: BoxFit.fitWidth,
                                    )
                                  : Image.network(
                                      '$img',
                                      // 'https://d4all-onde.com/images_profile/$img',
                                      fit: BoxFit.fitWidth,
                                    )),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$name  $lname',
                                  style: GoogleFonts.getFont(
                                    'Prompt',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '$email',
                                  style: GoogleFonts.getFont(
                                    'Prompt',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
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
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => edit_profile_image(
                                    refresh: refresh,
                                  )));
                    },
                    icon: Icon(Icons.edit, size: 18),
                    label: Text("เปลี่ยนภาพโปรไฟล์"),
                  ),

                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => edit_profile_password()));
                    },
                    icon: Icon(Icons.edit, size: 18),
                    label: Text("เปลี่ยนรหัสผ่าน"),
                  )
                  // RaisedButton.icon(
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => edit_profile_password()));
                  //   },
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  //   label: Text(
                  //     'เปลี่ยนรหัสผ่าน',
                  //     style: GoogleFonts.getFont(
                  //       'Prompt',
                  //       color: Color(0xFFFFFFFF),
                  //       fontWeight: FontWeight.normal,
                  //       // fontSize: 20,
                  //     ),
                  //   ),
                  //   icon: FaIcon(
                  //     FontAwesomeIcons.solidEdit,
                  //     size: 15,
                  //   ),
                  //   textColor: Colors.white,
                  //   splashColor: Color.fromARGB(255, 197, 182, 236),
                  //   color: Color(0xFF584A7F),
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                child: Text(
                  'โปรไฟล์',
                  style: GoogleFonts.getFont(
                    'Prompt',
                    color: Color(0xFF6B5B95),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          You_Profile(),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                child: Text(
                  'ที่อยู่',
                  style: GoogleFonts.getFont(
                    'Prompt',
                    color: Color(0xFF6B5B95),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          You_Address(),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                child: Text(
                  'ตำแหน่งปัจจุบัน',
                  style: GoogleFonts.getFont(
                    'Prompt',
                    color: Color(0xFF6B5B95),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          You_Map(),
        ],
      ),
    );
  }

  Widget You_Profile() {
    return FutureBuilder(
      // กำหนดชนิดข้อมูล
      future: data_Profile(), // ข้อมูล Future
      //builder: (BuildContext context, AsyncSnapshot snapshot) {
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Color(0xFFD9D9D9),
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0x00FFFFFF),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      'ประเภทกลุ่ม',
                                      style: GoogleFonts.getFont(
                                        'Prompt',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Text(
                                      '${show.message.userClass}',
                                      style: GoogleFonts.getFont(
                                        'Prompt',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      'เพศ',
                                      style: GoogleFonts.getFont(
                                        'Prompt',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Text(
                                      '${show.message.userGender}',
                                      style: GoogleFonts.getFont(
                                        'Prompt',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   width: 130,
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.white,
                                  //   ),
                                  //   child: Text(
                                  //     'วันเกิด',
                                  //     style: GoogleFonts.getFont(
                                  //       'Prompt',
                                  //       fontWeight: FontWeight.w500,
                                  //     ),
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: EdgeInsetsDirectional.fromSTEB(
                                  //       0, 0, 0, 5),
                                  //   child: Text(
                                  //     '${show.message.}',
                                  //     style: GoogleFonts.getFont(
                                  //       'Prompt',
                                  //       color: Colors.black,
                                  //       fontWeight: FontWeight.w200,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      'อีเมล',
                                      style: GoogleFonts.getFont(
                                        'Prompt',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Text(
                                      '${show.message.userEmail}',
                                      style: GoogleFonts.getFont(
                                        'Prompt',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      'หมายเลขติดต่อ',
                                      style: GoogleFonts.getFont(
                                        'Prompt',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Text(
                                      '${show.message.userPhone}',
                                      style: GoogleFonts.getFont(
                                        'Prompt',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    OutlinedButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    edit_profile(
                                                      profile_show: show,
                                                      refresh: refresh,
                                                    )));
                                      },
                                      icon: Icon(Icons.edit, size: 18),
                                      label: Text("แก้ไขข้อมูล"),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // ถ้ามี error
          return Text('${snapshot.error}');
        }
        // ค่าเริ่มต้น, แสดงตัว Loading.
        return Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ));
      },
    );
  }

  Widget You_Address() {
    return FutureBuilder(
      // กำหนดชนิดข้อมูล
      future: data_address(), // ข้อมูล Future
      //builder: (BuildContext context, AsyncSnapshot snapshot) {
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('====You_Address========${snapshot.data}');
        if (snapshot.data == null) {
          return Column(
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                  )),
              Text('คุณยังไม่มีข้อมูล'),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => edit_address(
                                show_address_edit: address,
                                refresh: refresh,
                              )));
                },
                icon: Icon(Icons.add, size: 18),
                label: Text("เพิ่มข้อมูล"),
              )
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (address.message.userDistrict == null) {
            return Column(
              children: [
                Text('คุณยังไม่มีข้อมูล'),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => edit_address(
                                  show_address_edit: address,
                                  refresh: refresh,
                                )));
                  },
                  icon: Icon(Icons.add, size: 18),
                  label: Text("เพิ่มข้อมูล"),
                )
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: Color(0xFFD9D9D9),
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0x00FFFFFF),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        'บ้านเลขที่',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      child: Text(
                                        address.message.userHouseNum,
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        'หมู่',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      child: Text(
                                        address.message.userVillageNum,
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        'ถนน',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      child: Text(
                                        address.message.userRoad,
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        'ตำบล/แขวง',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      child: Text(
                                        address.message.userSubdistrict,
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        'อำเภอ/เขต',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      child: Text(
                                        address.message.userDistrict,
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        'จังหวัด',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      child: Text(
                                        address.message.userProvince,
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        'รหัสไปรษณีย์',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      child: Text(
                                        address.message.userPostalcode,
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      edit_address(
                                                        show_address_edit:
                                                            address,
                                                        refresh: refresh,
                                                      )));
                                        },
                                        icon: Icon(Icons.edit, size: 18),
                                        label: Text("แก้ไขข้อมูล"),
                                      )
                                      // RaisedButton.icon(
                                      //   onPressed: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 edit_address()));
                                      //   },
                                      //   shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.all(
                                      //           Radius.circular(5.0))),
                                      //   label: Text(
                                      //     'แก้ไขข้อมูล',
                                      //     style: GoogleFonts.getFont(
                                      //       'Prompt',
                                      //       color: Color(0xFFFFFFFF),
                                      //       fontWeight: FontWeight.normal,
                                      //       // fontSize: 20,
                                      //     ),
                                      //   ),
                                      //   icon: FaIcon(
                                      //     FontAwesomeIcons.solidEdit,
                                      //     size: 15,
                                      //   ),
                                      //   textColor: Colors.white,
                                      //   splashColor:
                                      //       Color.fromARGB(255, 197, 182, 236),
                                      //   color: Color(0xFF584A7F),
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
                  ],
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          // ถ้ามี error
          return Text('${snapshot.error}');
        }
        // ค่าเริ่มต้น, แสดงตัว Loading.
        return Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ));
      },
    );
  }

  Widget You_Map() {
    return FutureBuilder(
      // กำหนดชนิดข้อมูล
      future: data_maps(), // ข้อมูล Future
      //builder: (BuildContext context, AsyncSnapshot snapshot) {
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Column(
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                  )),
              Text('คุณยังไม่มีข้อมูล'),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => edit_map(
                                refresh: refresh,
                              )));
                },
                icon: Icon(Icons.edit, size: 18),
                label: Text("เพิ่มข้อมูล"),
              )
              // RaisedButton.icon(
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => edit_map()));
              //   },
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(5.0))),
              //   label: Text(
              //     'เพิ่มข้อมูล',
              //     style: GoogleFonts.getFont(
              //       'Prompt',
              //       color: Color(0xFFFFFFFF),
              //       fontWeight: FontWeight.normal,
              //       // fontSize: 20,
              //     ),
              //   ),
              //   icon: FaIcon(
              //     FontAwesomeIcons.solidEdit,
              //     size: 15,
              //   ),
              //   textColor: Colors.white,
              //   splashColor: Color.fromARGB(255, 197, 182, 236),
              //   color: Color(0xFF584A7F),
              // ),
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print(maps.message.latitude);
          if (maps.message.latitude == null) {
            print('=======You_Map==111====${snapshot.data['message']}');
            return Column(
              children: [
                Text('คุณยังไม่มีข้อมูล'),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => edit_map(
                                  refresh: refresh,
                                )));
                  },
                  icon: Icon(Icons.add, size: 18),
                  label: Text("เพิ่มข้อมูล"),
                )
                // RaisedButton.icon(
                //   onPressed: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => edit_map()));
                //   },
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(5.0))),
                //   label: Text(
                //     'เพิ่มข้อมูล',
                //     style: GoogleFonts.getFont(
                //       'Prompt',
                //       color: Color(0xFFFFFFFF),
                //       fontWeight: FontWeight.normal,
                //       // fontSize: 20,
                //     ),
                //   ),
                //   icon: FaIcon(
                //     FontAwesomeIcons.solidEdit,
                //     size: 15,
                //   ),
                //   textColor: Colors.white,
                //   splashColor: Color.fromARGB(255, 197, 182, 236),
                //   color: Color(0xFF584A7F),
                // ),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: Color(0xFFD9D9D9),
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0x00FFFFFF),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 20),
                                        // child: FlutterFlowStaticMap(
                                        //   location: LatLng(15.242238096697896,
                                        //       104.83932078668786),
                                        //   apiKey:
                                        //       'AIzaSyAu51v1bRU7wRHqiZ8YFnffpcG',
                                        //   style: MapBoxStyle.Streets,
                                        //   width: 300,
                                        //   height: 300,
                                        //   fit: BoxFit.cover,
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   markerColor: Color(0xFF9775FA),
                                        //   zoom: 12,
                                        //   tilt: 0,
                                        //   rotation: 0,
                                        // ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        'ละติจูด',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      child: Text(
                                        maps.message.latitude,
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        'ลองจิจูด',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      child: Text(
                                        maps.message.longitude,
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      edit_map(
                                                        refresh: refresh,
                                                      )));
                                        },
                                        icon: Icon(Icons.edit, size: 18),
                                        label: Text("แก้ไขข้อมูล"),
                                      )
                                      // RaisedButton.icon(
                                      //   onPressed: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 edit_map()));
                                      //   },
                                      //   shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.all(
                                      //           Radius.circular(5.0))),
                                      //   label: Text(
                                      //     'แก้ไขข้อมูล',
                                      //     style: GoogleFonts.getFont(
                                      //       'Prompt',
                                      //       color: Color(0xFFFFFFFF),
                                      //       fontWeight: FontWeight.normal,
                                      //       // fontSize: 20,
                                      //     ),
                                      //   ),
                                      //   icon: FaIcon(
                                      //     FontAwesomeIcons.solidEdit,
                                      //     size: 15,
                                      //   ),
                                      //   textColor: Colors.white,
                                      //   splashColor:
                                      //       Color.fromARGB(255, 197, 182, 236),
                                      //   color: Color(0xFF584A7F),
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
                  ],
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          // ถ้ามี error
          return Text('${snapshot.error}');
        }
        // ค่าเริ่มต้น, แสดงตัว Loading.
        return Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ));
      },
    );
  }
}
