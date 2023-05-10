import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

// class Hospital extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Hospitals(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class Hospitals extends StatefulWidget {
  const Hospitals({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  late Position userLocation;
  final TextEditingController controller =
      TextEditingController(text: 'ค้นหาโรงพยาบาลใกล้คุณ');

  //// ตำแหน่งปัจจุบัน ///////
  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    print(userLocation.latitude);
    var lat = userLocation.latitude;
    var long = userLocation.longitude;
    print("lat = $lat");
    print("long = $long");

    final Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=hospital_map&lat=$lat&lon=$long');
    final response = await http.get(url);
    final responseJson = json.decode(response.body);
    print(responseJson);

    for (var user in responseJson['message']) {
      _userDetails.add(UserDetails.fromJson(user));
    }
    print("Function _getLocation is called");
    return userLocation;
  }

  ////////////////////////
  TextEditingController searchTextController = new TextEditingController();

  // Get json result and convert it to model. Then add
  // Future<Null> getUserDetails() async {
  //   userLocation = await Geolocator.getCurrentPosition();
  //   var lat = userLocation.latitude;
  //   var long = userLocation.longitude;
  //   print(lat);
  //   print(long);
  //    print(userLocation.latitude);
  //   final Uri url = Uri.parse(
  //       'https://addpaycrypto.com/mdes_new/api/webservice.php?service=hospital_map&lat=$lat&lon=$long');
  //   final response = await http.get(url);
  //   final responseJson = json.decode(response.body);

  //     for (var user in responseJson['message']) {
  //       _userDetails.add(UserDetails.fromJson(user));
  //     }
  // }

  @override
  void initState() {
    super.initState();

    _userDetails.clear(); //การลบข้อมูลก่อนหน้า
    //อัพเดทข้อมูลใหม่
    _getLocation();
    // getUserDetails();
    ///ดึงตำแหน่งปัจจุบัน
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('ค้นหาโรงพยาบาลใกล้ฉัน'),
          backgroundColor: Color(0xCC45156C),
          elevation: 0.0,
          actions: <Widget>[],
        ),
        body: Column(
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
                        var lat = _searchResult[i].lat;
                        var lng = _searchResult[i].lng;
                        if (lat == '') {
                          lat = '0.0';
                        }
                        if (lng == '') {
                          lng = '0.0';
                        }
                        var lart2 = double.parse('$lat');
                        var long = double.parse('$lng');
                        return new Card(
                          child: new ListTile(
                            leading: new CircleAvatar(
                              backgroundImage: new NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/08/26/12/37/hospital-908436_1280.png',
                              ),
                            ),
                            title: new Text(_searchResult[i].title +
                                ' ' +
                                _searchResult[i].title +
                                ' ' +
                                _searchResult[i].district +
                                ' ' +
                                _searchResult[i].province +
                                ' ' +
                                'ระยะทาง' +
                                ' ' +
                                _searchResult[i].distance +
                                ' ' +
                                'กิโลเมตร'),
                            onTap: () {
                              MapsLauncher.launchCoordinates(
                                  lart2, long, 'Google Headquarters are here');
                            },
                          ),
                        );
                      },
                    )
                  : FutureBuilder(
                      future: _getLocation(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                            itemCount: _userDetails.length,
                            itemBuilder: (context, index) {
                              var lat = _userDetails[index].lat;
                              var lng = _userDetails[index].lng;
                              print("double2 debug begin");
                              print("lat = $lat");
                              print("lng = $lng");
                              if (lat == '') {
                                lat = '0.0';
                              }
                              if (lng == '') {
                                lng = '0.0';
                              }
                              print("lat = $lat");
                              print("lng = $lng");
                              var lart2 = double.parse('$lat');
                              var long = double.parse('$lng');
                              print("lar2 = $lart2");
                              print("long = $long");
                              return new Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, bottom: 4.0),
                                  child: new ListTile(
                                      leading: new CircleAvatar(
                                        backgroundImage: new NetworkImage(
                                          'https://cdn.pixabay.com/photo/2015/08/26/12/37/hospital-908436_1280.png',
                                          // _userDetails[index].profileUrl,
                                        ),
                                      ),
                                      title: new Text(
                                          _userDetails[index].title +
                                              ' ' +
                                              _userDetails[index].title +
                                              ' ' +
                                              _userDetails[index].district +
                                              ' ' +
                                              _userDetails[index].province +
                                              ' ' +
                                              'ระยะทาง' +
                                              ' ' +
                                              _userDetails[index].distance +
                                              ' ' +
                                              'กิโลเมตร'),
                                      onTap: () {
                                        print(lart2);
                                        print(long);
                                        MapsLauncher.launchCoordinates(
                                            lart2,
                                            long,
                                            'Google Headquarters are here');
                                        // MapUtils.openMap(lart2,long);
                                      }),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
            ),
          ],
        ));
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.title.toLowerCase().contains(text) ||
          userDetail.id.toLowerCase().contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

List<UserDetails> userDetailsFromJson(String str) => List<UserDetails>.from(
    json.decode(str).map((x) => UserDetails.fromJson(x)));

String userDetailsToJson(List<UserDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDetails {
  UserDetails({
    required this.id,
    required this.lat,
    required this.lng,
    required this.title,
    required this.district,
    required this.province,
    required this.distance,
  });

  String id;
  String lat;
  String lng;
  String title;
  String district;
  String province;
  String distance;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"] == null ? null : json["id"],
        lat: json["lat"] == null ? null : json["lat"],
        lng: json["lng"] == null ? null : json["lng"],
        title: json["title"] == null ? null : json["title"],
        district: json["district"] == null ? null : json["district"],
        province: json["province"] == null ? null : json["province"],
        distance: json["distance"] == null ? null : json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "title": title == null ? null : title,
        "district": district == null ? null : district,
        "province": province == null ? null : province,
        "distance": distance == null ? null : distance,
      };
}
