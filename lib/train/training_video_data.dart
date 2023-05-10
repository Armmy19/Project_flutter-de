import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:test/train/training_video.dart';
import 'package:url_launcher/url_launcher.dart';

class Training_vodeo_data extends StatefulWidget {
  final Trainingvideo showvideo;
  const Training_vodeo_data({Key? key, required this.showvideo})
      : super(key: key);

  @override
  State<Training_vodeo_data> createState() => _Training_vodeo_dataState();
}

class _Training_vodeo_dataState extends State<Training_vodeo_data> {
  late Trainingvideo idvideo;
  late Trainingvideodata videodata;

  //API สำหรับการ แสดงรายการ รับค่าเป็น POST
  Future<Null> _Showvideodata() async {
    idvideo = widget.showvideo;
    var id = idvideo.id;
    print('book ===== ${id}');
    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=training_video_data&id=$id');

    final response = await http.get(url);
    final data = json.decode(response.body);
    videodata = trainingvideodataFromJson(response.body);
    print(data);
  }

  // _Progarm1() async {
  //   final url = '${videodata.link}';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idvideo = widget.showvideo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${idvideo.name}'),
      ),
      body: FutureBuilder(
        future:
            _Showvideodata(), // a previously-obtained Future<String> or null
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
                            '${videodata.message.name}',
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            ' จาก : ${videodata.message.name} ',
                            style: TextStyle(
                                color: Color.fromARGB(255, 11, 10, 10)
                                    .withOpacity(0.9)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            'รายละเอียด : ${videodata.message.name}',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.9)),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () async {
                                final url = '${videodata.message.link}';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              icon: Icon(Icons.youtube_searched_for, size: 18),
                              label: Text("ดูวีดีโอ youtube"),
                            )
                            // FlatButton(
                            //   textColor: const Color(0xFF6200EE),
                            //   onPressed: () async {
                            //     final url = '${videodata.message.link}';
                            //     if (await canLaunch(url)) {
                            //       await launch(url);
                            //     } else {
                            //       throw 'Could not launch $url';
                            //     }
                            //   },
                            //   child: const Text('ดูวีดีโอ youtube'),
                            // ),
                          ],
                        ),
                        Image.network(videodata.message.picture),
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
//     final trainingvideodata = trainingvideodataFromJson(jsonString);

Trainingvideodata trainingvideodataFromJson(String str) =>
    Trainingvideodata.fromJson(json.decode(str));

String trainingvideodataToJson(Trainingvideodata data) =>
    json.encode(data.toJson());

class Trainingvideodata {
  Trainingvideodata({
    required this.status,
    required this.message,
  });

  String status;
  Message message;

  factory Trainingvideodata.fromJson(Map<String, dynamic> json) =>
      Trainingvideodata(
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
    required this.picture,
    required this.link,
  });

  String id;
  String name;
  String picture;
  String link;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        name: json["name"],
        picture: json["picture"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture": picture,
        "link": link,
      };
}
