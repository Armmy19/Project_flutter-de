
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:projectmdes/hospital/hospital.dart';

// class MapsPage extends StatefulWidget {
//   @override
//   _MapsPageState createState() => _MapsPageState();
// }

// class _MapsPageState extends State<MapsPage> {
//   late Position userLocation;
//   late GoogleMapController mapController;

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   Future<Position> _getLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     userLocation = await Geolocator.getCurrentPosition();
//     return userLocation;
//   }

//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SOS ขอความช่วยเหลือ '),
//       ),
//       body: FutureBuilder(
//         future: _getLocation(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             return GoogleMap(
//               mapType: MapType.normal,
//               onMapCreated: _onMapCreated,
//               myLocationEnabled: true,
//               initialCameraPosition: CameraPosition(
//                   target: LatLng(userLocation.latitude, userLocation.longitude),
//                   zoom: 15),
//             );
//           } else {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   CircularProgressIndicator(),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           mapController.animateCamera(CameraUpdate.newLatLngZoom(
//               LatLng(userLocation.latitude, userLocation.longitude), 18));
//           showDialog(
//             context: context,
//             builder: (context) {
//               return Column(
//                 children: [
//                   AlertDialog(
//                       content: Column(
//                     children: [
//                       TextFormField(
//                         cursorColor: Theme.of(context).cursorColor,
//                         initialValue: '${userLocation.latitude}', // ค่าเริ่มต้น
//                         // จำกัดความยาวตัวอักษร
//                         decoration: InputDecoration(
//                           // icon: Icon(Icons.favorite),
//                           labelText: 'latitude',
//                           labelStyle: TextStyle(
//                             color: Color(0xFF6200EE),
//                           ),

//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xFF6200EE)),
//                           ),
//                         ),
//                       ),
//                       TextFormField(
//                         cursorColor: Theme.of(context).cursorColor,
//                         initialValue:
//                             '${userLocation.longitude}', // ค่าเริ่มต้น
//                         // จำกัดความยาวตัวอักษร
//                         decoration: InputDecoration(
//                           // icon: Icon(Icons.favorite),
//                           labelText: 'longitude',
//                           labelStyle: TextStyle(
//                             color: Color(0xFF6200EE),
//                           ),

//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xFF6200EE)),
//                           ),
//                         ),
//                       ),
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Hospitals(
//                                         title: 'ค้นหาโรงพยาบาล',
//                                       )));
//                         },
//                         icon: Icon(Icons.search, size: 18),
//                         label: Text('ค้นหาโรงบาลใกล้คุณ'),
//                       )
//                     ],
//                   )),
//                 ],
//               );
//               // content: Text(
//               //     'ตำแหน่งปัจจุบันของคุณ !\nlat: ${userLocation.latitude} long: ${userLocation.longitude} '),
//               // );
//             },
//           );
//         },
//         label: Text("ตำแหน่งปัจจุบัน"),
//         icon: Icon(Icons.add),
//         backgroundColor: Colors.purple,
//       ),
//     );
//   }
// }
