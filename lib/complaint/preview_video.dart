import 'package:test/complaint/com_detail_video.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';


class VideoApp extends StatefulWidget {
  final Showdatavdieo videoshow;
   const VideoApp({Key? key, required this.videoshow}) : super(key: key);
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
 late Showdatavdieo showview;
  @override
  void initState() {
    super.initState();
    showview = widget.videoshow;
    print(showview.message.id);
    _controller = VideoPlayerController.network(
        '${showview.message.video}')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text('Video Preview'),),
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
        },
        label:  _controller.value.isPlaying ? Text('หยุดเล่น') : Text('เล่น'),
        icon:  Icon( _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
        backgroundColor: Color(0xCC45156C),
      ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     setState(() {
        //       _controller.value.isPlaying
        //           ? _controller.pause()
        //           : _controller.play();
        //     });
        //   },
        //   child: Icon(
        //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //   ),
        // ),
      );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}