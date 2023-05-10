import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/loginusers.dart';
import 'package:test/home/index.dart';
import 'package:test/login/check_conten.dart';
import 'package:test/login/signup_form.dart';

class Login extends StatefulWidget {
  Login({Key? key, this.title}) : super(key: key);

  final String? title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _login();
  }

  //ตัวแปลสำหรับการจับคู่ Value
  late String email;
  late Loginuser Usersapi;
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  String? codeDialog;
  String? valueText;
  TextEditingController Forgetpassword = new TextEditingController();

//API สำหรับการ login รับค่าเป็น POST
  Future<Null> _login() async {
    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=checklogin');
    var response = await http.post(url, body: {
      "email": user.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    print(data);
    if (data["status"] == "success") {
      Usersapi = loginuserFromJson(response.body);
      // var _userDetails = Loginuser.fromJson(data);
      print(Usersapi.message.id);
      // Usersapi.add(Loginuser.fromJson(data));
      setState(() {
        GotoHome(Usersapi);
      });
    } else {
      setState(() {
        email = 'รหัสผ่าน หรือ อีเมลไม่ถูกต้อง';
        _showMyDialog();
      });
    }
  }

  Future<void> Forgetpass() async {
    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=user_forget');
    var response = await http.post(url, body: {
      "user_email": Forgetpassword.text,
    });
    var data = json.decode(response.body);
    print(data);
    if (data["status"] == "success") {
      setState(() {
        susses();
      });
    } else {
      setState(() {
        if (data["message"] == 'user_email not found.') {
          email = 'ไม่มีบัญชีอีเมลนี้ กรุณาตรวจสอบ';
        } else {
          email = 'กรอกอีเมลของคุณให้ถูกต้อง';
        }
        _showMyDialog();
      });
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('ลืมรหัสผ่าน'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: Forgetpassword,
              decoration: InputDecoration(hintText: "กรอก email ของท่าน"),
            ),
            actions: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0xCC45156C) // Background color
                    ),
                icon: Icon(Icons.cancel, size: 18),
                label: Text("CANCEL"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    Forgetpass();
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0xCC45156C) // Background color
                    ),
                icon: Icon(Icons.confirmation_num, size: 18),
                label: Text("OK"),
              ),
            ],
          );
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('กรุณาตรวจสอบข้อมูลให้ถูกต้อง $email'),
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

  Future<void> susses() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('กรุณาตรวจสอบที่ Email ของท่าน'),
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

  Future<void> _checkuserstatus() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('สิทธิ์ไม่ตรงกับระบบการใช้งาน'),
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

  Future<void> GotoHome(Loginuser Usersapi) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userid', Usersapi.message.id);
    prefs.setString('name', Usersapi.message.userName);
    prefs.setString('lname', Usersapi.message.userLastname);
    prefs.setString('status', Usersapi.message.userStatus);
    prefs.setString('email', Usersapi.message.userEmail);
    prefs.setString('class', Usersapi.message.userClass);
    String? checkstatus = prefs.getString('status');
    if (checkstatus == 'user') {
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return Home1(false);
      // }));

      // Also allow user to go back to the home screen
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home1(false)),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        _checkuserstatus();
      });
    }

    // print(email);
    // runApp(MaterialApp(home: email == null ? Login() : Home()));
  }

  Future<Null> Gotosingup() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return check();
      // _login();
    }));
  }

  Widget _entryEmailField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              keyboardType: TextInputType.emailAddress,
              controller: user,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryPasswordField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          //name textfield
          Container(
            child: TextField(
              controller: pass,
              keyboardType: TextInputType.text,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Center(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color.fromARGB(255, 96, 8, 198),
                    Color.fromARGB(255, 70, 6, 149),
                    Color.fromARGB(255, 92, 43, 152),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: () {
                _login();
                // AuthProvider().login(emailController.text, passController.text);
              },
              child: const Text('เข้าสู่ระบบ')),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: const Text(
                'สมัครสมาชิก',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Gotosingup();
              },
            ),
            // Text(
            //   'สมัครสมาชิก',
            //   style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Center(
      child: Container(
        child: Image(
          alignment: AlignmentDirectional.center,
          image: AssetImage('assets/images/D4ALL.png'),
          height: 100,
          width: 200,
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryEmailField("บัญชีผู้ใช้"),
        _entryPasswordField("รหัสผ่าน", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            // color: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const Text(
                        'ลืมรหัสผ่าน ?',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        _displayTextInputDialog(context);
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  _submitButton(),
                  SizedBox(height: height * .055),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
