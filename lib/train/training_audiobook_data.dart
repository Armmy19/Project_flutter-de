import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'package:test/train/training_audiobook.dart';
import 'package:test/train/view_audio.dart';

class Training_audiobook_data extends StatefulWidget {
  final Trainingaudiobook showaudiobook;
  const Training_audiobook_data({Key? key, required this.showaudiobook})
      : super(key: key);

  @override
  State<Training_audiobook_data> createState() =>
      _Training_audiobook_dataState();
}

class _Training_audiobook_dataState extends State<Training_audiobook_data> {
  late Trainingaudiobook idaudiobook;
  late TrainingaudiobookData audiobookdata;
  // late AudioPlayer player;

  //API สำหรับการ แสดงรายการ รับค่าเป็น POST
  Future<Null> _Showbookdata() async {
    idaudiobook = widget.showaudiobook;
    var id = idaudiobook.id;
    print('book ===== ${id}');
    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=training_audiobook_data&id=$id');

    final response = await http.get(url);
    final data = json.decode(response.body);
    audiobookdata = trainingaudiobookDataFromJson(response.body);
    print(data);
  }

  // Future<void> pay() async {
  //   await player.setUrl(
  //       'https://addpaycrypto.com/mdes_new/backoffice/management_audiobook/file_audiobook/%E0%B9%80%E0%B8%82%E0%B9%87%E0%B8%99%E0%B8%84%E0%B8%A3%E0%B8%81%E0%B8%95%E0%B8%B1%E0%B8%A7%E0%B9%80%E0%B8%9A%E0%B8%B2%20%E0%B8%9A%E0%B8%97%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A1%20%E0%B8%A2%E0%B8%B4%E0%B9%89%E0%B8%A1%E0%B9%81%E0%B8%9A%E0%B8%9A%E0%B8%94%E0%B8%B9%E0%B9%82%E0%B8%AD_8a725574576544668cebf4b9fa145c51.mp3');
  //   player.play();
  // }

  // Future<void> stop() async {
  //   await player.setUrl(
  //       'https://addpaycrypto.com/mdes_new/backoffice/management_audiobook/file_audiobook/%E0%B9%80%E0%B8%82%E0%B9%87%E0%B8%99%E0%B8%84%E0%B8%A3%E0%B8%81%E0%B8%95%E0%B8%B1%E0%B8%A7%E0%B9%80%E0%B8%9A%E0%B8%B2%20%E0%B8%9A%E0%B8%97%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A1%20%E0%B8%A2%E0%B8%B4%E0%B9%89%E0%B8%A1%E0%B9%81%E0%B8%9A%E0%B8%9A%E0%B8%94%E0%B8%B9%E0%B9%82%E0%B8%AD_8a725574576544668cebf4b9fa145c51.mp3');
  //   player.stop();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // player = AudioPlayer();
    // player.dispose();
    idaudiobook = widget.showaudiobook;
  }

  // @override
  // void dispose() {
  //   player.play();
  //   player.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(idaudiobook.name),
      ),
      body: FutureBuilder(
        future: _Showbookdata(), // a previously-obtained Future<String> or null
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
                            '${audiobookdata.message.name}',
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            ' จาก : ${audiobookdata.message.author} ',
                            style: TextStyle(
                                color: Color.fromARGB(255, 11, 10, 10)
                                    .withOpacity(0.9)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            'รายละเอียด : ${audiobookdata.message.details}',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.9)),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Audio(fileaudio: audiobookdata)));
                              },
                              child: Text('ฟังบรรยาย'),
                            ),
                          ],
                        ),
                        Image.network(idaudiobook.picture),
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

/// To parse this JSON data, do
//
//     final trainingaudiobookData = trainingaudiobookDataFromJson(jsonString);



TrainingaudiobookData trainingaudiobookDataFromJson(String str) => TrainingaudiobookData.fromJson(json.decode(str));

String trainingaudiobookDataToJson(TrainingaudiobookData data) => json.encode(data.toJson());

class TrainingaudiobookData {
    TrainingaudiobookData({
        required this.status,
        required this.message,
    });

    String status;
    Message message;

    factory TrainingaudiobookData.fromJson(Map<String, dynamic> json) => TrainingaudiobookData(
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
        required this.author,
        required this.details,
        required this.picture,
        required this.file,
    });

    String id;
    String name;
    String author;
    String details;
    String picture;
    String file;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        name: json["name"],
        author: json["author"],
        details: json["details"],
        picture: json["picture"],
        file: json["file"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "author": author,
        "details": details,
        "picture": picture,
        "file": file,
    };
}
