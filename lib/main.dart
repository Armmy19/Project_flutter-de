import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/home/image.dart';
import 'package:test/home/index.dart';
import 'package:test/login/login_form.dart';
import 'package:test/test.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

////// จำค่า id เพื่อไม่ให้ app login หลายรอบ //////////////////////////////////
Future<Null> main() async {
  HttpOverrides.global = new PostHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? typeid = prefs.getString('userid');
  String? checkstatus = prefs.getString('status');
  print('Userid ==== $typeid');
  print('checkstatus ==== $checkstatus');
  if (typeid?.isEmpty ?? true) {
    runApp(MaterialApp(home: SplashFuturePage()));
  } else {
    runApp(MaterialApp(home: Home1(false)));
  }
}

/////////////////////////////////////////////////////////////////////
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: SplashFuturePage(),
    );
  }

  static init() {}
}
