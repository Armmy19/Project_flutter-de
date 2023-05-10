import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:test/train/training_book_data.dart';


class Listbook extends StatefulWidget {
  const Listbook({Key? key}) : super(key: key);

  @override
  State<Listbook> createState() => _ListbookState();
}

class _ListbookState extends State<Listbook> {
  ////////////////////////
  TextEditingController searchTextController = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> _training_book() async {
    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=training_book');
    final response = await http.get(url);
    final responseJson = json.decode(response.body);
print(response);
    setState(() {
      for (var user in responseJson['message']) {
        _userDetails.add(Trainingbook.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _userDetails.clear(); //การลบข้อมูลก่อนหน้า
    _training_book(); //อัพเดทข้อมูลใหม่
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการหนังสือออนไลน์'),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Color(0xCC45156C),
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                elevation: 8.0,
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: searchTextController,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      searchTextController.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            child: _searchResult.length != 0 ||
                    searchTextController.text.isNotEmpty
                ? new ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, i) {
                      return new Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                              _searchResult[i].picture,
                              //https://via.placeholder.com/150
                              height: 100,
                              width: 100,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    '\n${_searchResult[i].name}',
                                    style: TextStyle(
                                        color: Colors.deepPurple, fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    _searchResult[i].author,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      String id = _searchResult[i].id;
                                      print(id);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Training_bookdata(
                                                      Showidbook:
                                                          _searchResult[i])));
                                    },
                                    child: Text("รายละเอียด"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : new ListView.builder(
                    itemCount: _userDetails.length,
                    itemBuilder: (context, index) {
                      return new Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                              _userDetails[index].picture,
                              //https://via.placeholder.com/150
                              height: 100,
                              width: 100,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '${_userDetails[index].name}${_userDetails[index].id}',
                                    style: TextStyle(
                                        color: Colors.deepPurple, fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    _userDetails[index].author,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      String id = _userDetails[index].id;
                                      print(id);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Training_bookdata(
                                                      Showidbook: _userDetails[
                                                          index])));
                                    },
                                    child: Text("รายละเอียด"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.name.toLowerCase().contains(text) ||
          userDetail.id.toLowerCase().contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<Trainingbook> _searchResult = [];

List<Trainingbook> _userDetails = [];

// To parse this JSON data, do
//
//     final trainingbook = trainingbookFromJson(jsonString);

List<Trainingbook> trainingbookFromJson(String str) => List<Trainingbook>.from(
    json.decode(str).map((x) => Trainingbook.fromJson(x)));

String trainingbookToJson(List<Trainingbook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trainingbook {
  Trainingbook({
    required this.id,
    required this.name,
    required this.picture,
    required this.author,
  });

  String id;
  String name;
  String picture;
  String author;

  factory Trainingbook.fromJson(Map<String, dynamic> json) => Trainingbook(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        picture: json["picture"] == null ? null : json["picture"],
        author: json["author"] == null ? null : json["author"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "picture": picture == null ? null : picture,
        "author": author == null ? null : author,
      };
}
