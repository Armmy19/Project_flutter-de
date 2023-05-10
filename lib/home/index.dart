import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/showprofile.dart';
import 'package:test/chatbot/chatbot_main.dart';
import 'package:test/chatroom/chr_main_menu.dart';
import 'package:test/complaint/complaint_main.dart';
import 'package:test/doctor/doctormain.dart';
import 'package:test/hospital/hospital.dart';
import 'package:test/job/job_main.dart';
import 'package:test/login/login_form.dart';
import 'package:test/profile/user_profile.dart';
import 'package:test/train/train.dart';
import 'package:url_launcher/url_launcher.dart';

MaterialColor mycolor = MaterialColor(
  Color(0xCC45156C).value,
  <int, Color>{
    50: Color.fromRGBO(0, 137, 123, 0.1),
    100: Color.fromRGBO(0, 137, 123, 0.2),
    200: Color.fromRGBO(0, 137, 123, 0.3),
    300: Color.fromRGBO(0, 137, 123, 0.4),
    400: Color.fromRGBO(0, 137, 123, 0.5),
    500: Color.fromRGBO(0, 137, 123, 0.6),
    600: Color.fromRGBO(0, 137, 123, 0.7),
    700: Color.fromRGBO(0, 137, 123, 0.8),
    800: Color.fromRGBO(0, 137, 123, 0.9),
    900: Color.fromRGBO(0, 137, 123, 1),
  },
);

// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     theme: ThemeData(
//        primarySwatch: mycolor
//     ),
//     home: Home1(),
//   );
// }

class Home1 extends StatelessWidget {
  // const Home1({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  Home1(bool bool);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: index_test(),
      theme: ThemeData(primarySwatch: mycolor),
    );
  }
}

class index_test extends StatefulWidget {
  const index_test({Key? key}) : super(key: key);

  @override
  _index_testState createState() => _index_testState();
}

class _index_testState extends State<index_test> {
  late Timer _timer;
  StreamSubscription? connection;
  bool isoffline = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? name;
  String? lname;
  String? email;
  String? img;
  late ProfileShow show;
  Future<void> checkversion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('====== $userid');
    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=checkversion');
    var response = await http.post(url, body: {
      "os": '',
      "version": '',
    });
    final responseJson = json.decode(response.body);
    print(responseJson);

    if (responseJson['status'] == 'success') {
      if (responseJson['message'] == 'ok') {}
      if (responseJson['message'] == 'new') {
        _showMynaw();
      }
      if (responseJson['message'] == 'update') {
        _showMyupdate();
      }
    } else {}
  }

  Future<void> _showMyDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nameuser = prefs.getString('userid');
    var name = prefs.getString('name');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$name คุณต้องการออกจากระบบใช่หรือไม่'),
          actions: <Widget>[
            TextButton(
              child: const Text('ไม่'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('ออก'),
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.clear();

                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => Login()));

                // Do not allow user to go back to current screen
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> noopen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nameuser = prefs.getString('userid');
    var name = prefs.getString('name');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยังไม่เปิดใช้งาน'),
          actions: <Widget>[
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // TextButton(
            //   child: const Text('ออก'),
            //   onPressed: () {
            //     logout();
            //   },
            // ),
          ],
        );
      },
    );
  }

  // Future<Null> logout() async {

  // }

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

  Future<void> _showMynaw() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('แจ้งเตียมพร้อมเวอร์ชั่นใหม่'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'พบกันเร็ว ๆ นี้ กับเวอร์ชั่นใหม่ เพื่อการใช้งานที่ดีขึ้น'),
                Text('ที่ App stor และ pay stor'),
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

  Future<void> _showMyupdate() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('อัพเดทเวอร์ชั่นใหม่'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('อัพเดทเวอร์ชั่นใหม่ เพื่อการใช้งานที่ดีขึ้น'),
                Text('ที่ App stor และ pay stor'),
              ],
            ),
          ),
          actions: <Widget>[],
        );
      },
    );
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      Profile();
    });
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        setState(() {
          isoffline = false;
        });
      }
    });
    Profile();
    checkversion();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Container(child: new Text('foo'));
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: Scaffold(
              backgroundColor: Color(0xFFF6F7F9),
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
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
                                              '$img'
                                              // 'http://www.thewowstyle.com/wp-content/uploads/2015/01/nature-image.jpg'
                                              ,
                                              fit: BoxFit.fitWidth,
                                            )),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$name $lname',
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

// Generated code for this Row Widget...
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => user_profile()));
                          },
                          icon: Icon(Icons.account_box, size: 18),
                          label: Text("โปรไฟล์"),
                        ),
                        IconButton(
                          icon: Icon(Icons.wifi_outlined),
                          color: isoffline ? Colors.red : Colors.lightGreen,
                          tooltip: 'Show Snackbar',
                          onPressed: () {},
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            _showMyDialog();
                          },
                          icon: Icon(Icons.logout, size: 18),
                          label: Text("ออกจากระบบ"),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'เมนู',
                              style: GoogleFonts.getFont(
                                'Prompt',
                                color: Color(0xFF584A7F),
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Job_main()));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                splashRadius: 100,
                                iconSize: 80,
                                icon: Ink.image(
                                  image: const NetworkImage(
                                      'https://d4all-onde.com/images/job_hover.png'),
                                  width: 80,
                                  height: 80,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Job_main()));
                                },
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ค้นหางาน',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontSize: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                        child: Text(
                                          'ระบบประกาศรับสมัครงานสำหรับผู้สูงอายุและคนพิการ',
                                          style: GoogleFonts.getFont(
                                            'Prompt',
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Train()));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                splashRadius: 100,
                                iconSize: 80,
                                icon: Ink.image(
                                  image: const NetworkImage(
                                      'https://d4all-onde.com/images/training_hover.png'),
                                  width: 80,
                                  height: 80,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Train()));
                                },
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ฝึกอบรม',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontSize: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                        child: Text(
                                          'ระบบการเรียนรู้ให้คำแนะนำการสร้างอาชีพ สำหรับผู้สูงอายุและคนพิการ',
                                          style: GoogleFonts.getFont(
                                            'Prompt',
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => doc_main()));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                splashRadius: 100,
                                iconSize: 80,
                                icon: Ink.image(
                                  image: const NetworkImage(
                                      'https://d4all-onde.com/images/health_hover.png'),
                                  width: 80,
                                  height: 80,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => doc_main()));
                                },
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'สุขภาพ',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontSize: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                        child: Text(
                                          'ระบบช่วยให้คำแนะนำทางด้านสุขภาพรูปแบบออนไลน์ สำหรับผู้สูงอายุและคนพิการ',
                                          style: GoogleFonts.getFont(
                                            'Prompt',
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Hospitals(
                                          title: 'ค้นหาโรงพยาบาล',
                                        )));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                splashRadius: 100,
                                iconSize: 80,
                                icon: Ink.image(
                                  image: const Image(
                                          image: AssetImage(
                                              'assets/images/medic_hover.png'))
                                      .image,
                                  width: 80,
                                  height: 80,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Hospitals(
                                                title: 'ค้นหาโรงพยาบาล',
                                              )));
                                },
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'โรงพยาบาลใกล้ฉัน',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontSize: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                        child: Text(
                                          'ระบบช่วยค้นหาสถานพยาบาลที่อยู่ในพื้นที่ของจังหวัดที่ทำการค้นหา',
                                          style: GoogleFonts.getFont(
                                            'Prompt',
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => chr_main_menu()));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                splashRadius: 100,
                                iconSize: 80,
                                icon: Ink.image(
                                  image: const NetworkImage(
                                      'https://d4all-onde.com/images/chat_hover.png'),
                                  width: 80,
                                  height: 80,
                                ),
                                onPressed: () {
                                  // noopen();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              chr_main_menu()));
                                },
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'สนทนาออนไลน์',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontSize: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                        child: Text(
                                          'ระบบสนทนาออนไลน์กับเพื่อนที่มีในระบบ สำหรับผู้สูงอายุและคนพิการ',
                                          style: GoogleFonts.getFont(
                                            'Prompt',
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => com_main()));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                  splashRadius: 100,
                                  iconSize: 80,
                                  icon: Ink.image(
                                    image: const NetworkImage(
                                        'https://d4all-onde.com/images/complaint_hover.png'),
                                    width: 80,
                                    height: 80,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => com_main()));
                                  }),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ร้องเรียน',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontSize: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                        child: Text(
                                          'ระบบช่วยในการแจ้งปัญหาร้องทุกข์ สำหรับผู้สูงอายุและคนพิการ',
                                          style: GoogleFonts.getFont(
                                            'Prompt',
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => chatbot_main()));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                splashRadius: 100,
                                iconSize: 80,
                                icon: Ink.image(
                                  image: const NetworkImage(
                                      'https://d4all-onde.com/images/chat_bot.png'),
                                  width: 80,
                                  height: 80,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              chatbot_main()));
                                },
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'แชทบอท',
                                        style: GoogleFonts.getFont(
                                          'Prompt',
                                          fontSize: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                        child: Text(
                                          'ระบบตอบคำถามเกี่ยวกับการให้บริการ ของหน่วยงาน ด้วยการแชท',
                                          style: GoogleFonts.getFont(
                                            'Prompt',
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                          ),
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'ช่องทางการติดต่อ',
                                style: GoogleFonts.getFont(
                                  'Prompt',
                                  color: Color(0xFF6B5B95),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '120 หมู่ 3 ชั้น 9 อาคารรัฐประศาสนภักดี ศูนย์ราชการเฉลิมพระเกียรติ 80 พรรษา 5 ธันวาคม 2550',
                                style: GoogleFonts.getFont(
                                  'Prompt',
                                  color: Color(0xFF999999),
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: Text(
                                  'ถนนแจ้งวัฒนะ แขวงทุ่งสองห้อง เขตหลักสี่ กรุงเทพฯ 10210',
                                  style: GoogleFonts.getFont(
                                    'Prompt',
                                    color: Color(0xFF999999),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: Text(
                                  'โทร. 0982848126',
                                  style: GoogleFonts.getFont(
                                    'Prompt',
                                    color: Color(0xFF999999),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ช่องทางข่าวสาร',
                                style: GoogleFonts.getFont(
                                  'Prompt',
                                  color: Color(0xFF6B5B95),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: IconButton(
                                  splashRadius: 100,
                                  iconSize: 60,
                                  icon: Ink.image(
                                    image: const NetworkImage(
                                        'https://d4all-onde.com/images/facebook_hover.png'),
                                    width: 70,
                                    height: 70,
                                  ),
                                  onPressed: () async {
                                    launch(
                                        "https://www.facebook.com/ONDE.GO.TH/?_rdc=1&_rdr");
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: IconButton(
                                  splashRadius: 100,
                                  iconSize: 60,
                                  icon: Ink.image(
                                    image: const NetworkImage(
                                        'https://d4all-onde.com/images/twitter_hover.png'),
                                    width: 60,
                                    height: 70,
                                  ),
                                  onPressed: () async {
                                    launch("https://twitter.com/ONDE_GO_TH");
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: IconButton(
                                  splashRadius: 100,
                                  iconSize: 60,
                                  icon: Ink.image(
                                    image: const NetworkImage(
                                        'https://d4all-onde.com/images/instagram_hover.png'),
                                    width: 70,
                                    height: 70,
                                  ),
                                  onPressed: () async {
                                    launch(
                                        "https://www.instagram.com/onde_go_th/");
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: IconButton(
                                  splashRadius: 100,
                                  iconSize: 60,
                                  icon: Ink.image(
                                    image: const NetworkImage(
                                        'https://d4all-onde.com/images/youtube_hover.png'),
                                    width: 70,
                                    height: 70,
                                  ),
                                  onPressed: () async {
                                    launch(
                                        "https://www.youtube.com/channel/UCuCrGM49GT0kFdXMRDYqQRA/playlists");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: IconButton(
                                  splashRadius: 100,
                                  iconSize: 60,
                                  icon: Ink.image(
                                    image: const NetworkImage(
                                        'https://d4all-onde.com/images/line_hover.png'),
                                    width: 70,
                                    height: 70,
                                  ),
                                  onPressed: () async {
                                    launch("http://line.me/ti/p/%40uvj2550p");
                                  },
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              //   child: IconButton(
                              //     splashRadius: 100,
                              //     iconSize: 60,
                              //     icon: Ink.image(
                              //       image: const NetworkImage(
                              //           'https://d4all-onde.com/images/mail_hover.png'),
                              //       width: 70,
                              //       height: 70,
                              //     ),
                              //     onPressed: () {
                              //       mail_URL();
                              //     },
                              //   ),
                              // ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: IconButton(
                                  splashRadius: 100,
                                  iconSize: 60,
                                  icon: Ink.image(
                                    image: const NetworkImage(
                                        'https://d4all-onde.com/images/rss_hover.png'),
                                    width: 70,
                                    height: 70,
                                  ),
                                  onPressed: () async {
                                    launch(
                                        "https://www.onde.go.th/view/1/rss/TH-TH");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '©2565 สงวนลิขสิทธิ์',
                                style: GoogleFonts.getFont(
                                  'Prompt',
                                  color: Color(0xFF6B5B95),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'สำนักงานคณะกรรมการดิจิทัลเพื่อเศรษฐกิจและสังคมแห่งชาติ',
                                style: GoogleFonts.getFont(
                                  'Prompt',
                                  color: Color(0xFF999999),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}

// // icon images link_external
// facebook_URL() async {
//   const url = 'https://www.facebook.com/ONDE.GO.TH/?_rdc=1&_rdr';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// twitter_URL() async {
//   const url = 'https://twitter.com/ONDE_GO_TH';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// instagram_URL() async {
//   const url = 'https://www.instagram.com/onde_go_th/';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// youtube_URL() async {
//   const url =
//       'https://www.youtube.com/channel/UCuCrGM49GT0kFdXMRDYqQRA/playlists';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// line_URL() async {
//   const url = 'http://line.me/ti/p/%40uvj2550p';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// // mail_URL() async {
// //   const url = 'mailto:pr.onde@onde.go.th';
// //   if (await canLaunch(url)) {
// //     await launch(url);
// //   } else {
// //     throw 'Could not launch $url';
// //   }
// // }

// rss_URL() async {
//   const url = 'https://www.onde.go.th/view/1/rss/TH-TH';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
