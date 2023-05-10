import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/train/list_train.dart';
import 'package:test/train/list_train_register.dart';

class Onetrain extends StatefulWidget {
  /////////แสดงค่า ส่งค่าไอดี จากอีกหน้าสู่หน้่ ///////
  final UserDetails Trinid;
  const Onetrain({Key? key, required this.Trinid}) : super(key: key);

  @override
  State<Onetrain> createState() => _OnetrainState();
}

class _OnetrainState extends State<Onetrain> {
  late UserDetails showtrin;
  late Listtotrain Showdataapi;
  TextEditingController typeuserid = new TextEditingController(text: '26');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Showdata();
  }

  String convert_date(String date) {
    // Convert from 23/03/2566 to 2021-03-23
    var date_split = date.split('/');
    var year = int.parse(date_split[2]) - 543;
    var month = date_split[1];
    var day = date_split[0];
    var date_convert = '$year-$month-$day';
    return date_convert;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ลงทะเบียนสำเร็จ'),
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

  Future<void> _showMyDialogConfirm() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ยืนยันการลงทะเบียน'),
            content: Text('คุณต้องการลงทะเบียนหรือไม่'),
            actions: [
              TextButton(
                child: Text('ยกเลิก'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('ตกลง'),
                onPressed: () {
                  _Rgistertrain();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _showMyDialogDuplicated() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('คุณได้ลงทะเบียนไปแล้ว'),
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

  //API สำหรับการ แสดงรายการ รับค่าเป็น POST
  Future<Null> _Showdata() async {
    showtrin = widget.Trinid;
    final id = await showtrin.id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print('id = $userid');
    print('course = $id');
    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=training_course_data');

    var response = await http.post(url, body: {
      "id": userid,
      "course": id,
    });

    final data = json.decode(response.body);
    print("data = $data");
    Showdataapi = listtotrainFromJson(response.body);

    print(data);
    print('======${id}');
  }

  //API สำหรับการ _Rgistertrain ลงทะเบียนฝึกอบรม รับค่าเป็น POST
  Future<void> _Rgistertrain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    showtrin = widget.Trinid;
    final id = await showtrin.id;
    print('====== $userid');
    print('====== $id');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=training_course_register');
    var response = await http.post(url, body: {
      "id": userid,
      "course": id,
    });
    var data = json.decode(response.body);
    print(data);
    if (data["status"] == "success") {
      setState(() {
        _showMyDialog();
      });
    } else {
      if (data['message'] == "Duplicate") {
        _showMyDialogDuplicated();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${showtrin.name}'),
      ),
      body: FutureBuilder(
        future: _Showdata(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Widget> children;
          if (snapshot.connectionState == ConnectionState.done) {
            children = <Widget>[
              // Image.network(Showdataapi.picture),
              Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.arrow_drop_down_circle),
                          title: Text(
                            '${Showdataapi.message.name}',
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            'วันที่จัดอบรม : ${Showdataapi.message.dateStart} \nสิ้นสุดการอบรม: ${Showdataapi.message.dateEnd} \nสถานที่ : ${Showdataapi.message.location} \nจังหวัด : ${Showdataapi.message.province} \nวิทยากร : ${Showdataapi.message.caretaker}',
                            style: TextStyle(
                                color: Color.fromARGB(255, 227, 39, 39)
                                    .withOpacity(0.9)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            '${Showdataapi.message.content}',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.9)),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            // If today more than Showdataapi.message.dateEnd
                            DateTime.parse(
                                      convert_date(Showdataapi.message.dateEnd),
                                    ).isAfter(DateTime.now()) ||
                                    DateTime.parse(convert_date(
                                            Showdataapi.message.dateEnd))
                                        .isAtSameMomentAs(DateTime.now())
                                ? OutlinedButton.icon(
                                    onPressed: () {
                                      // Asking for confirmation
                                      _showMyDialogConfirm();
                                    },
                                    icon: Icon(Icons.app_registration_outlined,
                                        size: 18),
                                    label: Text("ลงทะเบียน"),
                                  )
                                : Text(''),
                            Text(
                                'รับสมัครจำนวน ${Showdataapi.message.participants} คน'),
                          ],
                        ),
                        Image.network(Showdataapi.message.picture),
                      ],
                    ),
                  ),
                ],
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[LinearProgressIndicator()];
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Container(
                child: ListView(
                  children: children,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final listtotrain = listtotrainFromJson(jsonString);

Listtotrain listtotrainFromJson(String str) =>
    Listtotrain.fromJson(json.decode(str));

String listtotrainToJson(Listtotrain data) => json.encode(data.toJson());

class Listtotrain {
  Listtotrain({
    required this.status,
    required this.message,
  });

  String status;
  Message message;

  factory Listtotrain.fromJson(Map<String, dynamic> json) => Listtotrain(
        status: json["status"],
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.id,
    required this.name,
    required this.content,
    required this.dateStart,
    required this.dateEnd,
    required this.location,
    required this.province,
    required this.picture,
    required this.lecturer,
    required this.caretaker,
    required this.participants,
  });

  String id;
  String name;
  String content;
  String dateStart;
  String dateEnd;
  String location;
  String province;
  String picture;
  String lecturer;
  String caretaker;
  String participants;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        name: json["name"],
        content: json["content"],
        dateStart: json["date_start"],
        dateEnd: json["date_end"],
        location: json["location"],
        province: json["province"],
        picture: json["picture"],
        lecturer: json["lecturer"],
        caretaker: json["caretaker "],
        participants: json["participants"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "content": content,
        "date_start": dateStart,
        "date_end": dateEnd,
        "location": location,
        "province": province,
        "picture": picture,
        "lecturer": lecturer,
        "caretaker ": caretaker,
        "participants": participants,
      };
}
