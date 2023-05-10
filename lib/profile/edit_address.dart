import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test/api/showaddress.dart';
import 'address_db.dart';

class edit_address extends StatefulWidget {
  final Youaddress show_address_edit;
  final Future<void> Function() refresh;
  const edit_address(
      {Key? key, required this.show_address_edit, required this.refresh})
      : super(key: key);

  @override
  _edit_addressState createState() => _edit_addressState();
}

class _edit_addressState extends State<edit_address> {
  late Youaddress edit_address_show;
  final scaffoldKey = GlobalKey<FormState>();

  //  _selectedProvince variable
  String? _selectedProvince;
  String? _selectedDistrict;
  String? _selectedSubDistrict;
  String? _selectedPostalCode;

  TextEditingController user_houseNum = new TextEditingController();
  TextEditingController user_villageNum = new TextEditingController();
  TextEditingController user_alleylane = new TextEditingController();
  TextEditingController user_road = new TextEditingController();

  //

  //API สำหรับการ login รับค่าเป็น POST
  Future<void> edit_address() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=user_address_edit');
    var response = await http.post(url, body: {
      "id": userid,
      "user_houseNum": user_houseNum.text,
      "user_villageNum": user_villageNum.text,
      "user_alleylane": user_alleylane.text,
      "user_road": user_road.text,
      "user_subdistrict": _selectedSubDistrict,
      "user_district": _selectedDistrict,
      "user_province": _selectedProvince,
      "user_postalcode": _selectedPostalCode,
    });
    var data = json.decode(response.body);
    print(data);
    if (data["status"] == "success") {
      _showMyDialog();
      widget.refresh();
      Navigator.of(context).pop();
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
    edit_address_show = widget.show_address_edit;

    setState(() {
      user_alleylane.text = edit_address_show.message.userAlleylane ??= "";
      user_houseNum.text = edit_address_show.message.userHouseNum ??= "";
      user_road.text = edit_address_show.message.userRoad ??= "";
      user_villageNum.text = edit_address_show.message.userVillageNum ??= "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Form(
        key: scaffoldKey,
        child: ListView(
          padding: EdgeInsets.zero,
          primary: false,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: FaIcon(
                            FontAwesomeIcons.solidEdit,
                            color: Color(0xFF584A7F),
                            size: 20,
                          ),
                        ),
                        Text(
                          'แก้ไขที่อยู่',
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
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'บ้านเลขที่',
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
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรุณากรอกข้อมูลนี้ ';
                                              }
                                              return null;
                                            },
                                            controller: user_houseNum,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(),
                                              hintText: 'กรอกบ้านเลขที่',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF868E96),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'หมู่',
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
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรุณากรอกข้อมูลนี้ ';
                                              }
                                              return null;
                                            },
                                            controller: user_villageNum,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(),
                                              hintText: 'กรอกหมู่',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF868E96),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'ถนน',
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
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'กรุณากรอกข้อมูลนี้ ';
                                              }
                                              return null;
                                            },
                                            controller: user_road,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(),
                                              hintText: 'กรอกถนน',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF868E96),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'จังหวัด',
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
                                            // color: FlutterFlowTheme.of(context)
                                            //     .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(0xFFDEE2E6),
                                            ),
                                          ),

                                          // Dropdown that will show data from province_list
                                          child: DropdownButtonFormField(
                                            value: (_selectedProvince == '' ||
                                                    _selectedProvince == null)
                                                ? null
                                                : _selectedProvince,
                                            items: province_list
                                                .map(
                                                    (value) => DropdownMenuItem(
                                                          child: Text(value),
                                                          value: value,
                                                        ))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedProvince =
                                                    value.toString();
                                                _selectedSubDistrict = null;
                                                _selectedDistrict = null;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(),
                                              hintText: 'เลือกจังหวัด',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF868E96),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'อำเภอ/เขต',
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
                                            // color: FlutterFlowTheme.of(context)
                                            //     .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(0xFFDEE2E6),
                                            ),
                                          ),
                                          child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              hintText: 'เลือก อำเภอ/เขต',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
                                            ),
                                            value: _selectedDistrict,
                                            items: ((_selectedProvince == null)
                                                    ? []
                                                    : district_list[
                                                            _selectedProvince] ??
                                                        [])
                                                .map((e) => DropdownMenuItem(
                                                    value: e, child: Text(e)))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedDistrict =
                                                    value.toString();
                                                _selectedSubDistrict = null;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'ตำบล/แขวง',
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
                                          // Dropdown that shows the list of subdistricts from sub_district_list
                                          child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              hintText: 'เลือก ตำบล/แขวง',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
                                            ),
                                            value: _selectedSubDistrict,
                                            items: ((_selectedDistrict == null)
                                                    ? []
                                                    : sub_district_list[
                                                            _selectedDistrict] ??
                                                        [])
                                                .map((e) => DropdownMenuItem(
                                                    value: e, child: Text(e)))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedSubDistrict =
                                                    value.toString();

                                                _selectedPostalCode = post_code[
                                                        _selectedProvince
                                                                .toString() +
                                                            ' ' +
                                                            _selectedDistrict
                                                                .toString() +
                                                            ' ' +
                                                            _selectedSubDistrict
                                                                .toString()]
                                                    .toString();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'รหัสไปรษณีย์',
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
                                          child: DropdownButtonFormField(
                                            value: post_code[_selectedProvince
                                                    .toString() +
                                                ' ' +
                                                _selectedDistrict.toString() +
                                                ' ' +
                                                _selectedSubDistrict
                                                    .toString()],
                                            items:
                                                (_selectedSubDistrict == null)
                                                    ? null
                                                    : [
                                                        DropdownMenuItem(
                                                          child: Text(post_code[_selectedProvince.toString() +
                                                                  ' ' +
                                                                  _selectedDistrict
                                                                      .toString() +
                                                                  ' ' +
                                                                  _selectedSubDistrict
                                                                      .toString()]
                                                              .toString()),
                                                          value: post_code[_selectedProvince
                                                                  .toString() +
                                                              ' ' +
                                                              _selectedDistrict
                                                                  .toString() +
                                                              ' ' +
                                                              _selectedSubDistrict
                                                                  .toString()],
                                                        )
                                                      ],
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedPostalCode =
                                                    value.toString();
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(),
                                              hintText: 'เลือกรหัสไปรษณีย์',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF868E96),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
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
                                    if (scaffoldKey.currentState!.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      edit_address();
                                    }
                                  },
                                  icon: Icon(Icons.edit, size: 18),
                                  label: Text("บันทึกแก้ไขข้อมูล"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
