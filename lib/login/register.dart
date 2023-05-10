// import 'package:flutter/material.dart';


// class register extends StatefulWidget {
//   // const register({Key key}) : super(key: key);

//   @override
//   _registerState createState() => _registerState();
// }

// class _registerState extends State<register> {
//   // String dropDownValue1;
//   // String radioButtonValue1;
//   // String radioButtonValue2;
//   // TextEditingController textController1;
//   // TextEditingController textController2;
//   // TextEditingController textController3;
//   // TextEditingController textController4;
//   // TextEditingController textController5;
//   // String dropDownValue2;
//   // String dropDownValue3;
//   // TextEditingController textController6;
//   // TextEditingController textController7;
//   // TextEditingController textController8;
//   // TextEditingController textController9;
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     // textController1 = TextEditingController();
//     // textController2 = TextEditingController();
//     // textController3 = TextEditingController();
//     // textController4 = TextEditingController();
//     // textController5 = TextEditingController();
//     // textController6 = TextEditingController();
//     // textController7 = TextEditingController();
//     // textController8 = TextEditingController();
//     // textController9 = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Color(0xFFF6F7F9),
//       appBar: AppBar(
//         title: Text(
//           '',
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             color: Colors.white,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//       ),
//       body: ListView(
//         padding: EdgeInsets.zero,
//         primary: false,
//         scrollDirection: Axis.vertical,
//         children: [
//           Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
//                         child: Image.network(
//                           'https://addpaycrypto.com/mdes_new/images/mdes.png',
//                           height: 50,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Text(
//                         'MDES',
//                         style: TextStyle(
//                           color: Color(0xFF6B5B95),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 40,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
//                         child: Icon(
//                           Icons.person,
//                           color: Color(0xFF6B5B95),
//                           size: 25,
//                         ),
//                       ),
//                       Text(
//                         'USER REGISTER',
//                         style: TextStyle(
//                           color: Color(0xFF6B5B95),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(
//                         color: Color(0xFFDEE2E6),
//                       ),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 0, 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 5, 0),
//                                         child: Text(
//                                           'กลุ่มผู้ใช้งาน',
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             color: Color(0xFF434C5E),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '*',
//                                         style: TextStyle(
//                                           color: Color(0xFFC92A2A),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           border: Border.all(
//                                             color: Color(0xFFDEE2E6),
//                                           ),
//                                         ),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Radio(
//                                                     value: 1,
//                                                     groupValue: 'null',
//                                                     onChanged: (index) {}),
//                                                 Text('ผู้สูงอายุ')
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Radio(
//                                                     value: 1,
//                                                     groupValue: 'null',
//                                                     onChanged: (index) {}),
//                                                 Text('ผู้พิการ')
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 0, 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 5, 0),
//                                         child: Text(
//                                           'เพศ',
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             color: Color(0xFF434C5E),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '*',
//                                         style: TextStyle(
//                                           color: Color(0xFFC92A2A),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           border: Border.all(
//                                             color: Color(0xFFDEE2E6),
//                                           ),
//                                         ),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Radio(
//                                                     value: 1,
//                                                     groupValue: 'null',
//                                                     onChanged: (index) {}),
//                                                 Text('ชาย')
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Radio(
//                                                     value: 1,
//                                                     groupValue: 'null',
//                                                     onChanged: (index) {}),
//                                                 Text('หญิง')
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 0, 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 5, 0),
//                                         child: Text(
//                                           'คำนำหน้าชื่อ',
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             color: Color(0xFF434C5E),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '*',
//                                         style: TextStyle(
//                                           color: Color(0xFFC92A2A),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           border: Border.all(
//                                             color: Color(0xFFDEE2E6),
//                                           ),
//                                         ),
//                                         // child: DropDown(
//                                         //   options: ['นาย', 'นาง', 'นางสาว'],
//                                         //   onChanged: (val) =>
//                                         //       setState(() => Value = val),
//                                         //   textStyle: GoogleFonts.getFont(
//                                         //     'Prompt',
//                                         //     color: Color(0xFF868E96),
//                                         //     fontWeight: FontWeight.w300,
//                                         //   ),
//                                         //   hintText: 'เลือกคำนำหน้า',
//                                         //   fillColor: Colors.white,
//                                         //   elevation: 2,
//                                         //   borderColor: Colors.transparent,
//                                         //   borderWidth: 0,
//                                         //   borderRadius: 5,
//                                         //   margin:
//                                         //       EdgeInsetsDirectional.fromSTEB(
//                                         //           10, 10, 10, 10),
//                                         //   hidesUnderline: true,
//                                         // ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 0, 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 5, 0),
//                                         child: Text(
//                                           'ชื่อ',
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             color: Color(0xFF434C5E),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '*',
//                                         style: TextStyle(
//                                           color: Color(0xFFC92A2A),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           border: Border.all(
//                                             color: Color(0xFFDEE2E6),
//                                           ),
//                                         ),
//                                         child: TextFormField(
//                                           // controller: textController1,
//                                           obscureText: false,
//                                           decoration: InputDecoration(
//                                             labelStyle: TextStyle(),
//                                             hintText: 'กรอกชื่อจริง',
//                                             hintStyle: TextStyle(
//                                               color: Color(0xFF868E96),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             contentPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     10, 10, 10, 10),
//                                           ),
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 0, 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 5, 0),
//                                         child: Text(
//                                           'นามสกุล',
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             color: Color(0xFF434C5E),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '*',
//                                         style: TextStyle(
//                                           color: Color(0xFFC92A2A),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           border: Border.all(
//                                             color: Color(0xFFDEE2E6),
//                                           ),
//                                         ),
//                                         child: TextFormField(
//                                           // controller: textController2,
//                                           obscureText: false,
//                                           decoration: InputDecoration(
//                                             labelStyle: TextStyle(),
//                                             hintText: 'กรอกนามกสุล',
//                                             hintStyle: TextStyle(
//                                               color: Color(0xFF868E96),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             contentPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     10, 10, 10, 10),
//                                           ),
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 0, 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 5, 0),
//                                         child: Text(
//                                           'รหัสผู้ใช้งาน',
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             color: Color(0xFF434C5E),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '*',
//                                         style: TextStyle(
//                                           color: Color(0xFFC92A2A),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           border: Border.all(
//                                             color: Color(0xFFDEE2E6),
//                                           ),
//                                         ),
//                                         child: TextFormField(
//                                           // controller: textController3,
//                                           obscureText: false,
//                                           decoration: InputDecoration(
//                                             labelStyle: TextStyle(),
//                                             hintText: 'กรอกรหัสผู้ใช้งาน',
//                                             hintStyle: TextStyle(
//                                               color: Color(0xFF868E96),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             contentPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     10, 10, 10, 10),
//                                           ),
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 0, 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 5, 0),
//                                         child: Text(
//                                           'รหัสผ่าน',
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             color: Color(0xFF434C5E),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '*',
//                                         style: TextStyle(
//                                           color: Color(0xFFC92A2A),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           border: Border.all(
//                                             color: Color(0xFFDEE2E6),
//                                           ),
//                                         ),
//                                         child: TextFormField(
//                                           // controller: textController4,
//                                           obscureText: false,
//                                           decoration: InputDecoration(
//                                             labelStyle: TextStyle(),
//                                             hintText: 'กรอกรหัสผ่าน',
//                                             hintStyle: TextStyle(
//                                               color: Color(0xFF868E96),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             contentPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     10, 10, 10, 10),
//                                           ),
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 0, 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 5, 0),
//                                         child: Text(
//                                           'รหัสผ่าน',
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             color: Color(0xFF434C5E),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '*',
//                                         style: TextStyle(
//                                           color: Color(0xFFC92A2A),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           border: Border.all(
//                                             color: Color(0xFFDEE2E6),
//                                           ),
//                                         ),
//                                         child: TextFormField(
//                                           // controller: textController5,
//                                           obscureText: false,
//                                           decoration: InputDecoration(
//                                             labelStyle: TextStyle(),
//                                             hintText: 'กรอกรหัสผ่าน',
//                                             hintStyle: TextStyle(
//                                               color: Color(0xFF868E96),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             contentPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     10, 10, 10, 10),
//                                           ),
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 0, 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 5, 0),
//                                         child: Text(
//                                           'วัน / เดือน / ปี (พ.ศ.) เกิด',
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             color: Color(0xFF434C5E),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '*',
//                                         style: TextStyle(
//                                           color: Color(0xFFC92A2A),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           children: [
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: EdgeInsetsDirectional
//                                                     .fromSTEB(0, 0, 5, 0),
//                                                 // child: FlutterFlowDropDown(
//                                                 //   options: [
//                                                 //     '01',
//                                                 //     '02',
//                                                 //     '03',
//                                                 //     '04',
//                                                 //     '05',
//                                                 //     '06',
//                                                 //     '07',
//                                                 //     '08',
//                                                 //     '09',
//                                                 //     '10',
//                                                 //     '11',
//                                                 //     '12',
//                                                 //     '13',
//                                                 //     '14',
//                                                 //     '15',
//                                                 //     '16',
//                                                 //     '17',
//                                                 //     '18',
//                                                 //     '19',
//                                                 //     '20',
//                                                 //     '21',
//                                                 //     '22',
//                                                 //     '23',
//                                                 //     '24',
//                                                 //     '25',
//                                                 //     '26',
//                                                 //     '27',
//                                                 //     '28',
//                                                 //     '29',
//                                                 //     '30',
//                                                 //     '31'
//                                                 //   ],
//                                                 //   onChanged: (val) => setState(
//                                                 //       () =>
//                                                 //           dropDownValue2 = val),
//                                                 //   width: MediaQuery.of(context)
//                                                 //           .size
//                                                 //           .width *
//                                                 //       0.25,
//                                                 //   height: 47,
//                                                 //   textStyle:
//                                                 //       GoogleFonts.getFont(
//                                                 //     'Prompt',
//                                                 //     color: Color(0xFF868E96),
//                                                 //     fontWeight: FontWeight.w300,
//                                                 //   ),
//                                                 //   hintText: 'วัน',
//                                                 //   fillColor: Colors.white,
//                                                 //   elevation: 2,
//                                                 //   borderColor:
//                                                 //       Color(0xFFDEE2E6),
//                                                 //   borderWidth: 0,
//                                                 //   borderRadius: 5,
//                                                 //   margin: EdgeInsetsDirectional
//                                                 //       .fromSTEB(10, 10, 10, 10),
//                                                 //   hidesUnderline: true,
//                                                 // ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: EdgeInsetsDirectional
//                                                     .fromSTEB(0, 0, 5, 0),
//                                                 // child: FlutterFlowDropDown(
//                                                 //   options: [
//                                                 //     '01',
//                                                 //     '02',
//                                                 //     '03',
//                                                 //     '04',
//                                                 //     '05',
//                                                 //     '06',
//                                                 //     '07',
//                                                 //     '08',
//                                                 //     '09',
//                                                 //     '10',
//                                                 //     '11',
//                                                 //     '12'
//                                                 //   ],
//                                                 //   onChanged: (val) => setState(
//                                                 //       () =>
//                                                 //           dropDownValue3 = val),
//                                                 //   width: MediaQuery.of(context)
//                                                 //           .size
//                                                 //           .width *
//                                                 //       0.25,
//                                                 //   height: 47,
//                                                 //   textStyle:
//                                                 //       GoogleFonts.getFont(
//                                                 //     'Prompt',
//                                                 //     color: Color(0xFF868E96),
//                                                 //     fontWeight: FontWeight.w300,
//                                                 //   ),
//                                                 //   hintText: 'เดือน',
//                                                 //   fillColor: Colors.white,
//                                                 //   elevation: 2,
//                                                 //   borderColor:
//                                                 //       Color(0xFFDEE2E6),
//                                                 //   borderWidth: 0,
//                                                 //   borderRadius: 5,
//                                                 //   margin: EdgeInsetsDirectional
//                                                 //       .fromSTEB(10, 10, 10, 10),
//                                                 //   hidesUnderline: true,
//                                                 // ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: TextFormField(
//                                                 // controller: textController6,
//                                                 obscureText: false,
//                                                 decoration: InputDecoration(
//                                                   labelStyle: TextStyle(
//                                                     color: Color(0xFF868E96),
//                                                   ),
//                                                   hintText: 'ปี (พ.ศ.)',
//                                                   hintStyle: TextStyle(
//                                                     color: Color(0xFF868E96),
//                                                   ),
//                                                   enabledBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color(0xFFDEE2E6),
//                                                       width: 1,
//                                                     ),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                   ),
//                                                   focusedBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color(0xFFDEE2E6),
//                                                       width: 1,
//                                                     ),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                   ),
//                                                   filled: true,
//                                                   fillColor: Colors.white,
//                                                   contentPadding:
//                                                       EdgeInsetsDirectional
//                                                           .fromSTEB(
//                                                               10, 10, 10, 10),
//                                                 ),
//                                                 style: GoogleFonts.getFont(
//                                                   'Prompt',
//                                                   color: Color(0xFF868E96),
//                                                   fontWeight: FontWeight.w300,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 0, 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 5, 0),
//                                         child: Text(
//                                           'เลขบัตรประชาชน',
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             color: Color(0xFF434C5E),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '*',
//                                         style: TextStyle(
//                                           color: Color(0xFFC92A2A),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           border: Border.all(
//                                             color: Color(0xFFDEE2E6),
//                                           ),
//                                         ),
//                                         child: TextFormField(
//                                           // controller: textController7,
//                                           obscureText: false,
//                                           decoration: InputDecoration(
//                                             labelStyle: TextStyle(),
//                                             hintText: 'กรอกเลขบัตรประชาชน',
//                                             hintStyle: TextStyle(
//                                               color: Color(0xFF868E96),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             contentPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     10, 10, 10, 10),
//                                           ),
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 0, 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 5, 0),
//                                         child: Text(
//                                           'หมายเลขโทรศัพท์',
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             color: Color(0xFF434C5E),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '*',
//                                         style: TextStyle(
//                                           color: Color(0xFFC92A2A),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           border: Border.all(
//                                             color: Color(0xFFDEE2E6),
//                                           ),
//                                         ),
//                                         child: TextFormField(
//                                           // controller: textController8,
//                                           obscureText: false,
//                                           decoration: InputDecoration(
//                                             labelStyle: TextStyle(),
//                                             hintText: 'กรอกหมายเลขโทรศัพท์',
//                                             hintStyle: TextStyle(
//                                               color: Color(0xFF868E96),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             contentPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     10, 10, 10, 10),
//                                           ),
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 0, 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 5, 0),
//                                         child: Text(
//                                           'อีเมล',
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             color: Color(0xFF434C5E),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '*',
//                                         style: TextStyle(
//                                           color: Color(0xFFC92A2A),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           border: Border.all(
//                                             color: Color(0xFFDEE2E6),
//                                           ),
//                                         ),
//                                         child: TextFormField(
//                                           // controller: textController9,
//                                           obscureText: false,
//                                           decoration: InputDecoration(
//                                             labelStyle: TextStyle(),
//                                             hintText: 'กรอกอีเมล',
//                                             hintStyle: TextStyle(
//                                               color: Color(0xFF868E96),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             contentPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     10, 10, 10, 10),
//                                           ),
//                                           style: GoogleFonts.getFont(
//                                             'Prompt',
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
