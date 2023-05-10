import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class edit_map extends StatefulWidget {
  final Future<void> Function() refresh;
  const edit_map({Key? key, required this.refresh}) : super(key: key);

  @override
  _edit_mapState createState() => _edit_mapState();
}

class _edit_mapState extends State<edit_map> {
  // TextEditingController textController1;
  // TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Position userLocation;
  String? lat;
  String? long;
  TextEditingController latitude = new TextEditingController();
  TextEditingController longitude = new TextEditingController();
  //// ตำแหน่งปัจจุบัน ///////
  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    userLocation = await Geolocator.getCurrentPosition();

    return userLocation;
  }

  //API สำหรับการ login รับค่าเป็น POST
  Future<void> edit_maps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=user_map_edit');
    var response = await http.post(url, body: {
      "id": userid,
      "latitude": latitude.text,
      "longitude": longitude.text,
    });
    var data = json.decode(response.body);
    print(data);
    if (data["status"] == "success") {
      _showMyDialog();
      Navigator.of(context).pop();
      widget.refresh();
      print('yes');
    } else {
      setState(() {
        _showMyerror();
      });
      print('error');
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('สำเร็จ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('แก้ไขข้อมูลสำเร็จ'),
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

  Future<void> _showMyerror() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('เกิดข้อผิดพลาด'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('มีข้อผิกพลาด กรุณาตรวจสอบข้อมูล'),
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

  @override
  void initState() {
    super.initState();
    _getLocation();
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          primary: false,
          scrollDirection: Axis.vertical,
          children: [
            FutureBuilder(
              future: _getLocation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.solidEdit,
                                  color: Color(0xFF584A7F),
                                  size: 20,
                                ),
                              ),
                              Text(
                                'แก้ไขตำแหน่งปัจจุบัน',
                                style: GoogleFonts.getFont(
                                  'Prompt',
                                  color: Color(0xFF584A7F),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xFFDEE2E6),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 20, 20, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 20),
                                          // child: FlutterFlowStaticMap(
                                          //   location: LatLng(9.341465, -79.891704),
                                          //   apiKey: 'ENTER_YOUR_MAPBOX_API_KEY_HERE',
                                          //   style: MapBoxStyle.Streets,
                                          //   width: 300,
                                          //   height: 300,
                                          //   fit: BoxFit.cover,
                                          //   borderRadius: BorderRadius.circular(5),
                                          //   zoom: 12,
                                          //   tilt: 0,
                                          //   rotation: 0,
                                          // ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 5, 0),
                                                child: Text(
                                                  'Latitude',
                                                  style: GoogleFonts.getFont(
                                                    'Prompt',
                                                    color: Color(0xFF434C5E),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '*',
                                                style: TextStyle(
                                                  color: Color(0xFFC92A2A),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: Color(0xFFDEE2E6),
                                                  ),
                                                ),
                                                child: TextFormField(
                                                  controller: latitude =
                                                      new TextEditingController(
                                                          text:
                                                              '${userLocation.latitude}'),
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelStyle: TextStyle(),
                                                    hintText: 'Latitude',
                                                    hintStyle: TextStyle(
                                                      color: Color(0xFF868E96),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 10, 10, 10),
                                                  ),
                                                  style: GoogleFonts.getFont(
                                                    'Prompt',
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 5, 0),
                                                child: Text(
                                                  'Longitude',
                                                  style: GoogleFonts.getFont(
                                                    'Prompt',
                                                    color: Color(0xFF434C5E),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '*',
                                                style: TextStyle(
                                                  color: Color(0xFFC92A2A),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: Color(0xFFDEE2E6),
                                                  ),
                                                ),
                                                child: TextFormField(
                                                  controller: longitude =
                                                      new TextEditingController(
                                                          text:
                                                              '${userLocation.longitude}'),
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelStyle: TextStyle(),
                                                    hintText: 'Longitude',
                                                    hintStyle: TextStyle(
                                                      color: Color(0xFF868E96),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 10, 10, 10),
                                                  ),
                                                  style: GoogleFonts.getFont(
                                                    'Prompt',
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          edit_maps();
                                        },
                                        icon: Icon(Icons.edit, size: 18),
                                        label: Text("บันทึกแก้ไขข้อมูล"),
                                      )
                                      // RaisedButton.icon(
                                      //   onPressed: () {
                                      //     edit_maps();
                                      //   },
                                      //   shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.all(
                                      //           Radius.circular(5.0))),
                                      //   label: Text(
                                      //     'บันทึกแก้ไขข้อมูล',
                                      //     style: GoogleFonts.getFont(
                                      //       'Prompt',
                                      //       color: Color(0xFFFFFFFF),
                                      //       fontWeight: FontWeight.normal,
                                      //       // fontSize: 20,
                                      //     ),
                                      //   ),
                                      //   icon: FaIcon(
                                      //     FontAwesomeIcons.save,
                                      //     size: 15,
                                      //   ),
                                      //   textColor: Colors.white,
                                      //   splashColor:
                                      //       Color.fromARGB(255, 197, 182, 236),
                                      //   color: Color(0xFF584A7F),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
