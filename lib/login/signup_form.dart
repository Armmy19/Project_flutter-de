import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:test/login/login_form.dart';
import 'package:email_validator/email_validator.dart';

class Singup extends StatefulWidget {
  Singup({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SingupState createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  TextEditingController idcardlController = new TextEditingController();
  TextEditingController namelController = new TextEditingController();
  TextEditingController lnamelController = new TextEditingController();
  TextEditingController datelController = new TextEditingController();
  TextEditingController typelController = new TextEditingController();
  TextEditingController user_birthday = new TextEditingController();
  TextEditingController users = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController titlename = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  final scaffoldKey = GlobalKey<FormState>();
  var type = ['ผู้สูงอายุ', 'คนพิการ'];
  var teielee = ['นาย', 'นาง', 'นางสาว'];
  late String email;
  var chackdata;

  //API สำหรับการ login รับค่าเป็น POST
  Future<void> Register() async {
    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=user_register');
    var response = await http.post(url, body: {
      "user_class": typelController.text,
      "user_titlename": titlename.text,
      "user_name": namelController.text,
      "user_lastname": lnamelController.text,
      "user_user": users.text,
      "user_password": passController.text,
      "user_email": emailController.text,
    });
    var data = json.decode(response.body);
    // If user_user or user_password less than 6 characters
    if (users.text.length < 6 || passController.text.length < 6) {
      setState(() {
        email = 'username หรือ password ต้องมีความยาวมากกว่า 6 ตัวอักษร';
        _checkerror();
      });
    } else {
      if (data["status"] == "success") {
        setState(() {
          _success();
        });
      } else {
        setState(() {
          if (data["message"] == 'Duplicate user_user.') {
            email = 'บัญชีผู้ใช้นี้มีผู้ใช้งานแล้ว';
          }
          if (data["message"] == 'Duplicate user_email.') {
            email = 'อีเมลนี้มีผู้ใช้งานแล้ว';
          } else {
            email = 'กรุณากรอกข้อมูลให้ครบทุกช่อง';
          }
          _checkerror();
        });
      }
    }
  }

  Future<void> _success() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ลงทะเบียนเสร็จสิ้น'),
          actions: <Widget>[
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkerror() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('เกิดข้อผิดพลาดที่ $email'),
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

  Widget _entryidcardlField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFC92A2A),
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: idcardlController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),
        ],
      ),
    );
  }

  Widget _entrynamelField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFC92A2A),
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: namelController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entrylnamelField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFC92A2A),
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: lnamelController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryuserField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFC92A2A),
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              keyboardType: TextInputType.text,
              inputFormatters: <TextInputFormatter>[
                // for below version 2 use this
                // FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9]')),
                // Also allow _ and @
                FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9@_]')),
                LengthLimitingTextInputFormatter(20)
              ],

              // validate after each user interaction
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรอก\'บัญชีผู้ใช้งานของคุณ';
                }
                if (value.length < 6) {
                  return 'ยังไม่ถูกต้อง บัญชีต้องมี 6 หลัก';
                }
                return null;
              },
              controller: users,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entrytypelField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFC92A2A),
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          // TextFormField and PopupMenuButton same line
          Row(
            children: [
              Expanded(
                child: TextFormField(
                    enabled: false,
                    controller: typelController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true)),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  typelController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return type.map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _entrbirthdaylField(String title) {
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
          TextFormField(
            controller: user_birthday,
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today), //icon of text field
                labelText: "Enter Date" //label text of field
                ),
            readOnly: true,
            // onTap: () async {
            //   DateTime? pickedDate = await showDatePicker(
            //       context: context,
            //       initialDate: DateTime.now(),
            //       firstDate: DateTime(1950),
            //       //DateTime.now() - not to allow to choose before today.
            //       lastDate: DateTime(2100));

            //   if (pickedDate != null) {
            //     print(
            //         pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            //     String formattedDate =
            //         DateFormat('yyyy-MM-dd').format(pickedDate);
            //     print(
            //         formattedDate); //formatted date output using intl package =>  2021-03-16
            //     setState(() {
            //       user_birthday.text =
            //           formattedDate; //set output date to TextFormField value.
            //     });
            //   } else {}
            // },
          ),
          // PopupMenuButton<String>(
          //   icon: const Icon(Icons.arrow_drop_down),
          //   onSelected: (String value) {
          //     user_birthday.text = value;
          //   },
          //   itemBuilder: (BuildContext context) {
          //     return sex.map<PopupMenuItem<String>>((String value) {
          //       return new PopupMenuItem(child: new Text(value), value: value);
          //     }).toList();
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _entryEmailField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFC92A2A),
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onChanged: (val) {
              if (val.isEmpty) {
                setState(() {
                  _errorMessage = "ต้องระบุอีเมล";
                });
              } else if (!EmailValidator.validate(val, true)) {
                setState(() {
                  _errorMessage = "ที่อยู่อีเมลที่ไม่ถูกต้อง";
                });
              } else {
                setState(() {
                  _errorMessage = "";
                });
              }
            },
          ),
          Text(
            _errorMessage,
            style: TextStyle(color: Colors.red),
          ),
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
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFC92A2A),
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //name TextFormField
          Container(
            child: TextFormField(
              controller: passController,
              // keyboardType: TextInputType.phone,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
              autovalidateMode: AutovalidateMode.onUserInteraction,

              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรุณากรอกรหัสผ่าน';
                } else if (value.length < 6) {
                  return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryTitleField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFC92A2A),
                  fontSize: 20,
                ),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),
          // Container and PopupMenuButton same line
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  enabled: false,
                  controller: titlename,
                  keyboardType: TextInputType.phone,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true),
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  titlename.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return teielee.map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
            ],
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
                Register();
              },
              child: const Text('ลงทะเบียน')),
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
                'เข้าสู่ระบบ',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Login();
                  // _login();
                }));
              },
            ),
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
        _entrytypelField("กลุ่มผู้ใช้งาน"),
        _entryTitleField('คำนำหน้าชื่อ'),
        _entrynamelField("ชื่อ"),
        _entrylnamelField("นามสกุล"),
        // _entrbirthdaylField("วันเกิด"),
        _entryuserField("บัญชีผู้ใช้งาน"),
        _entryPasswordField("รหัสผ่าน", isPassword: true),
        _entryEmailField("อีเมล"),
        // _entryidcardlField("บัตรประชาชน"),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
// Register();
    // data_chack();
  }

  String _errorMessage = '';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Form(
      key: scaffoldKey,
      child: Stack(
        children: <Widget>[
          Container(
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
                    child: Text('',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
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
