import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/train/list_to_train.dart';
import 'package:test/train/list_train_register.dart';

class Listtrain extends StatefulWidget {
  const Listtrain({Key? key}) : super(key: key);

  @override
  State<Listtrain> createState() => _ListtrainState();
}

class _ListtrainState extends State<Listtrain> {
  ////////////////////////
  TextEditingController searchTextController = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=training_course');
    final response = await http.get(url);
    final responseJson = json.decode(response.body);
    print('training_course');
    print(responseJson);

    setState(() {
      for (var user in responseJson['message']) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _userDetails.clear(); //การลบข้อมูลก่อนหน้า
    getUserDetails(); //อัพเดทข้อมูลใหม่
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการฝึกอบรม'),
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
                                    _searchResult[i].date,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    _searchResult[i].location,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      // Respond to button press
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
                                    _userDetails[index].date,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    _userDetails[index].location,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      String id = _userDetails[index].id;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Onetrain(
                                                  Trinid:
                                                      _userDetails[index])));
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListRegistertrain()));
        },
        label: Text("รายการลงทะเบียน"),
        icon: Icon(Icons.access_time),
        backgroundColor: Colors.purple,
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

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

List<UserDetails> userDetailsFromJson(String str) => List<UserDetails>.from(
    json.decode(str).map((x) => UserDetails.fromJson(x)));

String userDetailsToJson(List<UserDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDetails {
  UserDetails({
    required this.id,
    required this.name,
    required this.picture,
    required this.date,
    required this.location,
  });

  String id;
  String name;
  String picture;
  String date;
  String location;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"],
        name: json["name"],
        picture: json["picture"],
        date: json["date"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture": picture,
        "date": date,
        "location": location,
      };
}
