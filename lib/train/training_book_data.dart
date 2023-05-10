import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:test/train/training_book.dart';
import 'package:test/train/view_file_pdf.dart';

class Training_bookdata extends StatefulWidget {
  final Trainingbook Showidbook;
  const Training_bookdata({Key? key, required this.Showidbook})
      : super(key: key);

  @override
  State<Training_bookdata> createState() => _Training_bookdataState();
}

class _Training_bookdataState extends State<Training_bookdata> {
  late Trainingbook bookid;
  late Trainingbookdata bookdata;

  //API สำหรับการ แสดงรายการ รับค่าเป็น POST
  Future<Null> _Showbookdata() async {
    bookid = widget.Showidbook;
    var id = bookid.id;
    print('book ===== ${id}');
    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=training_book_data&id=$id');

    final response = await http.get(url);
    final data = json.decode(response.body);
    bookdata = trainingbookdataFromJson(response.body);
    print(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Showbookdata();
    bookid = widget.Showidbook;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${bookid.name}'),
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
                            '${bookdata.message.name}',
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            ' จาก : ${bookdata.message.author} ',
                            style: TextStyle(
                                color: Color.fromARGB(255, 11, 10, 10)
                                    .withOpacity(0.9)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            'รายละเอียด : ${bookdata.message.details}',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.9)),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ViewPDF(
                                    Showpdf: bookdata,
                                  );
                                }));
                              },
                              icon: Icon(Icons.add, size: 18),
                              label: Text("อ่านรายละเอียด"),
                            )
                            // FlatButton(
                            //   textColor: const Color(0xFF6200EE),
                            //   onPressed: () {
                            //     Navigator.push(context,
                            //         MaterialPageRoute(builder: (context) {
                            //       return ViewPDF(Showpdf: bookdata,);
                            //     }));
                            //   },
                            //   child: const Text('อ่านรายละเอียด'),
                            // ),
                          ],
                        ),
                        Image.network(bookdata.message.picture),
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
//     final trainingbookdata = trainingbookdataFromJson(jsonString);

Trainingbookdata trainingbookdataFromJson(String str) =>
    Trainingbookdata.fromJson(json.decode(str));

String trainingbookdataToJson(Trainingbookdata data) =>
    json.encode(data.toJson());

class Trainingbookdata {
  Trainingbookdata({
    required this.status,
    required this.message,
  });

  String status;
  Message message;

  factory Trainingbookdata.fromJson(Map<String, dynamic> json) =>
      Trainingbookdata(
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
