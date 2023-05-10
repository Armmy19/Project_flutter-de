import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/complaint/com_list_video.dart';
import 'package:test/complaint/preview_video.dart';
import 'package:video_player/video_player.dart';

class com_detail_video extends StatefulWidget {
  final ComplaintVideo Showvideo;
  const com_detail_video({Key? key, required this.Showvideo}) : super(key: key);

  @override
  _com_detail_videoState createState() => _com_detail_videoState();
}

class _com_detail_videoState extends State<com_detail_video> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ComplaintVideo showidvideo;
  late Showdatavdieo datavdieo;
  // late VideoPlayerController controller;
  //  VideoPlayerController? _controller;

  // late Future<void> _initializeVideoPlayerFuture;
  Future<void> Comdetailvdieo() async {
    showidvideo = widget.Showvideo;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_video_data');
    var response = await http.post(url, body: {
      "id": showidvideo.id,
    });
    var data = json.decode(response.body);
    datavdieo = showdatavdieoFromJson(response.body);
    print('show===${datavdieo.message.id}');

    if (data['status'] == 'success') {
      print(data);
    } else {
      print('object');
    }
  }

  // @override
  // void initState() {
  //   // Comdetailvdieo();
  //   // loadVideoPlayer();
  //   // TODO: implement initState
  //   super.initState();

  //   // showidvideo = widget.Showvideo;
  //   // print(showidvideo.id);
  // }

  // loadVideoPlayer() async {
  //   showidvideo = widget.Showvideo;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userid = prefs.getString('userid');

  //   Uri url = Uri.parse(
  //       'https://d4all-onde.com/api/webservice.php?service=complaint_video_data');
  //   var response = await http.post(url, body: {
  //     "id": showidvideo.id,
  //   });
  //   var data = json.decode(response.body);
  //   datavdieo = showdatavdieoFromJson(response.body);
  //   // controller = VideoPlayerController.network('${datavdieo.message.video}');
  //   controller = VideoPlayerController.network(
  //       'https://addpaycrypto.com/mdes_new/backoffice/management_complaint/video/test_582fe23760f4997d0d84fd5b31fe9e22.mp4');
  //   controller.addListener(() {
  //     // setState(() {});
  //   });
  //   controller.initialize().then((value) {
  //     // setState(() {});
  //   });
  // }

  @override
  void initState() {
    // loadVideoPlayer();
    // TODO: implement initState
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'รายละเอียดข้อมูล',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: ListView(
        children: [
          showdatavdieo(),
          _vdieop(),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _controller!.value.isPlaying
      //           ? _controller!.pause()
      //           : _controller!.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }

  Widget showdatavdieo() {
    return FutureBuilder(
      future: Comdetailvdieo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xFFE0D2E4),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                            child: Text(
                              datavdieo.message.title,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xCC62297B),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                            // child: FlutterFlowVideoPlayer(
                            //   path:
                            //       'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',
                            //   videoType: VideoType.network,
                            //   autoPlay: false,
                            //   looping: false,
                            //   showControls: true,
                            //   allowFullScreen: true,
                            //   allowPlaybackSpeedMenu: false,
                            // ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: Text(
                                    'สถานะข้อมูล :',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  datavdieo.message.status,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF5BAF89),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _vdieop() {
    return FutureBuilder(
      future: Comdetailvdieo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoApp(videoshow: datavdieo,)));
                  },
                  child: Text('รับชมวิดีโอร้องเรียน'),
                )
              ],
            ),
          );

          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Center(
          //       child: Column(children: [
          //     AspectRatio(
          //       aspectRatio: controller.value.aspectRatio,
          //       child: VideoPlayer(controller),
          //     ),
          //     Container(
          //       //duration of video
          //       child: Text(
          //           "Total Duration: " + controller.value.duration.toString()),
          //     ),
          //     Container(
          //         child: VideoProgressIndicator(controller,
          //             allowScrubbing: true,
          //             colors: VideoProgressColors(
          //               backgroundColor: Colors.redAccent,
          //               playedColor: Colors.green,
          //               bufferedColor: Colors.purple,
          //             ))),
          //     Container(
          //       child: Row(
          //         children: [
          //           IconButton(
          //               onPressed: () {
          //                 if (controller.value.isPlaying) {
          //                   controller.pause();
          //                 } else {
          //                   controller.play();
          //                 }

          //                 setState(() {});
          //               },
          //               icon: Icon(controller.value.isPlaying
          //                   ? Icons.pause
          //                   : Icons.play_arrow)),
          //           IconButton(
          //               onPressed: () {
          //                 controller.seekTo(Duration(seconds: 0));

          //                 setState(() {});
          //               },
          //               icon: Icon(Icons.stop))
          //         ],
          //       ),
          //     )
          //   ])),
          // );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// To parse this JSON data, do
//
//     final showdatavdieo = showdatavdieoFromJson(jsonString);

Showdatavdieo showdatavdieoFromJson(String str) =>
    Showdatavdieo.fromJson(json.decode(str));

String showdatavdieoToJson(Showdatavdieo data) => json.encode(data.toJson());

class Showdatavdieo {
  Showdatavdieo({
    required this.status,
    required this.message,
  });

  String status;
  Message message;

  factory Showdatavdieo.fromJson(Map<String, dynamic> json) => Showdatavdieo(
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
    required this.title,
    required this.video,
    required this.date,
    required this.status,
  });

  String id;
  String title;
  String video;
  String date;
  String status;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        title: json["title"],
        video: json["video"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "video": video,
        "date": date,
        "status": status,
      };
}
