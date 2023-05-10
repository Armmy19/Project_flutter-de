// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:http/http.dart' as http;
// import 'package:floating_action_bubble/floating_action_bubble.dart';
// import 'package:flutter/material.dart';

// import 'package:http/http.dart';
// import 'package:projectmdes/api/loginusers.dart';
// import 'package:projectmdes/appeal/appeal.dart';

// import 'package:projectmdes/complaint/complaint_main.dart';
// import 'package:projectmdes/doctor/doctormain.dart';
// import 'package:projectmdes/hospital/hospital.dart';
// import 'package:projectmdes/hospital/map_sos.dart';
// import 'package:projectmdes/job/job_main.dart';
// import 'package:projectmdes/train/train.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);

//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: MyStatefulWidget(),
//       theme: ThemeData(primarySwatch: Colors.purple),
//     );
//   }
// }

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget>
//     with SingleTickerProviderStateMixin {
//   Animation<double>? _animation;
//   AnimationController? _animationController;
//   late SharedPreferences localStorage;
//   late Loginuser Usersapi;

//   @override
//   void initState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 260),
//     );

//     final curvedAnimation =
//         CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
//     _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
//     // getExchangeRate();
//     Token();
//     super.initState();
//   }

//   ///การดึงข้อมูลที่เก็บ ไว้ของ userslogin มาใช้งาน

//   // Uri url = Uri.parse(
//   //     'https://addpaycrypto.com/mdes_new/api/webservice.php?service=hospital_map');
//   // Future<void> getExchangeRate() async {
//   //   var myReq = {};
//   //   String jsonReq = jsonEncode(myReq);
//   //   var response = await http.get(url);
//   //   setState(() {
//   //     // Usersapi = loginuserFromJson(response.body);
//   //   });
//   //   if (response.statusCode == 200) {
//   //     var msg = jsonDecode(response.body);
//   //     print(msg);
//   //   }
//   // }

//   //////////////////////////////////////////

//   List<int> top = <int>[];
//   List<int> bottom = <int>[0];

//   _Progarm1() async {
//     final url = 'https://addpaycrypto.com/mdes/health/member/user_login.php';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   _Progarm2() async {
//     const url = 'https://addpaycrypto.com/mdes/bot/';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   _Progarm3() async {
//     const url = 'https://addpaycrypto.com/mdes/complaint_new/user_login.php';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   _Progarm4() async {
//     const url = 'https://addpaycrypto.com/mdes/hospital/';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

// /////////////////Token//////////////////

// //  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging;
//   Future<Null> Token() async {
//     //    _firebaseMessaging.getToken().then((token) {
//     //   assert(token != null);
//     //   print("teken is: " + token!);
//     // });

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var idtokin = prefs.getString('userid');
//   }
// //////////////////////////////////////

// ///////////////////////////ออกจากระบบ//////////////////////////////////////////////

// ///////////////////////////////////////////////////////////////////////////////////

// //////////////////////////class การสร้าง class เพื่อเรีอกใช้งาน /////////////////////////
//   Future<void> _showMyDialog() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var nameuser = prefs.getString('userid');
//     var name = prefs.getString('name');
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('nameUsres $name'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('ตกลง'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('ออกจากระบบ'),
//               onPressed: () {
//                 logout();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<Null> logout() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//     exit(0);
//     // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
//   }

//   //////////////////////////////////////////////////////////////////////////////

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(
//         //   title: Image(
//         //     alignment: AlignmentDirectional.centerEnd,
//         //     image: NetworkImage(
//         //         'https://www.onde.go.th/assets/portals/1/images/logo/Logo-onde_thai2.png'),
//         //     height: 100,
//         //     width: 100,
//         //   ),
//         //   leading: IconButton(
//         //     icon: const Icon(Icons.accessible_sharp),
//         //     onPressed: () {
//         //       setState(() {
//         //         _showMyDialog();
//         //       });
//         //     },
//         //   ),
//         // ),
//         body: SafeArea(
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: NetworkImage(
//                             'https://www.onde.go.th/assets/portals/1/images/logo/Logo-onde_thai2.png'),
//                         fit: BoxFit.cover)),
//                 child: Container(
//                   width: double.infinity,
//                   height: 200,
//                   // child: Container(
//                   //   alignment: Alignment(0.0, 2.5),
//                   //   child: CircleAvatar(
//                   //     backgroundImage: NetworkImage(
//                   //         'https://www.onde.go.th/assets/portals/1/images/logo/Logo-onde_thai2.png'),
//                   //     radius: 60.0,
//                   //   ),
//                   // ),
//                 ),
//               ),
//               SizedBox(
//                 height: 60,
//               ),
//               Text(
//                 "M D E S",
//                 style: TextStyle(
//                     fontSize: 25.0,
//                     color: Color.fromARGB(255, 5, 5, 5),
//                     letterSpacing: 2.0,
//                     fontWeight: FontWeight.w400),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "สำนักงานคณะกรรมการดิจิทัล",
//                 style: TextStyle(
//                     fontSize: 18.0,
//                     color: Colors.black45,
//                     letterSpacing: 1.0,
//                     fontWeight: FontWeight.w300),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "เพื่อเศรษฐกิจและสังคม",
//                 style: TextStyle(
//                     fontSize: 15.0,
//                     color: Colors.black45,
//                     letterSpacing: 1.0,
//                     fontWeight: FontWeight.w300),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Card(
//                   margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//                   elevation: 2.0,
//                   child: Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 12, horizontal: 30),
//                       child: Text(
//                         "ช่องทางการติดต่อ",
//                         style: TextStyle(
//                             letterSpacing: 1.0, fontWeight: FontWeight.w100),
//                       ))),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   SignInButton(
//                     Buttons.Facebook,
//                     mini: true,
//                     onPressed: () {},
//                   ),
//                   SignInButton(
//                     Buttons.Twitter,
//                     mini: true,
//                     onPressed: () {},
//                   ),
//                   SignInButton(
//                     Buttons.Email,
//                     mini: true,
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   _showMyDialog();
//                 },
//                 icon: Icon(Icons.logout, size: 20),
//                 label: Text("ออกจากระบบ"),
//               )
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionBubble(
//           items: <Bubble>[
//             Bubble(
//               title: "ค้นหาโรงพยาบาล",
//               iconColor: Colors.white,
//               bubbleColor: Colors.purple,
//               icon: Icons.local_hospital_sharp,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => Hospitals(
//                               title: 'ค้นหาโรงพยาบาล',
//                             )));
//               },
//             ),
//             Bubble(
//               title: "ร้องเรียน",
//               iconColor: Colors.white,
//               bubbleColor: Colors.purple,
//               icon: Icons.document_scanner,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => com_main()));
//               },
//             ),
//             Bubble(
//               title: "ฝึกอบรม",
//               iconColor: Colors.white,
//               bubbleColor: Colors.purple,
//               icon: Icons.model_training,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => Train()));
//               },
//             ),
//             Bubble(
//               title: "ค้นหางาน",
//               iconColor: Colors.white,
//               bubbleColor: Colors.purple,
//               icon: Icons.search_rounded,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Job_main()));
//               },
//             ),
//             // Bubble(
//             //   title: "สนทนาออนไล์",
//             //   iconColor: Colors.white,
//             //   bubbleColor: Colors.purple,
//             //   icon: Icons.chat,
//             //   titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//             //   onPress: () {
//             //     Navigator.push(
//             //         context, MaterialPageRoute(builder: (context) => Chat()));
//             //   },
//             // ),
//             // Bubble(
//             //   title: "chat bot",
//             //   iconColor: Colors.white,
//             //   bubbleColor: Colors.purple,
//             //   icon: Icons.chat_bubble_outline,
//             //   titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//             //   onPress: () {
//             //     Navigator.push(
//             //         context, MaterialPageRoute(builder: (context) => Appeal()));
//             //   },
//             // ),
//             Bubble(
//               title: "สุขภาพ",
//               iconColor: Colors.white,
//               bubbleColor: Colors.purple,
//               icon: Icons.health_and_safety,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => doc_main()));
//               },
//             ),
//           ],
//           animation: _animation!,
//           onPress: () => _animationController!.isCompleted
//               ? _animationController!.reverse()
//               : _animationController!.forward(),
//           backGroundColor: Colors.purple,
//           iconColor: Colors.white,
//           iconData: Icons.menu,
//         ));
//   }
// }
