import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/complaint/com_list_voice.dart';

var themeNotifier = ValueNotifier<ThemeVariation>(
  const ThemeVariation(Colors.blue, Brightness.light),
);

class ThemeVariation {
  const ThemeVariation(this.color, this.brightness);
  final MaterialColor color;
  final Brightness brightness;
}

class com_detail_voice extends StatefulWidget {
  final Showlistvoice idvoice;
  const com_detail_voice({Key? key, required this.idvoice}) : super(key: key);

  @override
  _com_detail_voiceState createState() => _com_detail_voiceState();
}

class _com_detail_voiceState extends State<com_detail_voice> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Showlistvoice Voiceid;
  late Detailvoice datavoice;
  late AudioPlayer _player;

  late Stream<DurationState> _durationState;
  var _isShowingWidgetOutline = false;
  var _labelLocation = TimeLabelLocation.below;
  var _labelType = TimeLabelType.totalTime;
  TextStyle? _labelStyle;
  var _thumbRadius = 10.0;
  var _labelPadding = 0.0;
  var _barHeight = 5.0;
  var _barCapShape = BarCapShape.round;
  Color? _baseBarColor;
  Color? _progressBarColor;
  Color? _bufferedBarColor;
  Color? _thumbColor;
  Color? _thumbGlowColor;
  var _thumbCanPaintOutsideBar = true;

  @override
  void initState() {
      Voiceid = widget.idvoice;
      print(Voiceid.id);
    super.initState();
    // Comdetailvoice();
    _player = AudioPlayer();
    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _player.positionStream,
        _player.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
    // _init();
  }

  // Future<void> _init() async {
  //   Voiceid = widget.idvoice;
  //   final url = '${datavoice.message.file}';
  //   try {
  //     await _player.setUrl(url);
  //   } catch (e) {
  //     debugPrint('An error occured $e');
  //   }
  // }

  Future<void> Comdetailvoice() async {
    Voiceid = widget.idvoice;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');

    Uri url = Uri.parse(
        'https://d4all-onde.com/api/webservice.php?service=complaint_sound_data');
    var response = await http.post(url, body: {
      "id": Voiceid.id,
    });
    var data = json.decode(response.body);
    datavoice = detailvoiceFromJson(response.body);
    print('show===${Voiceid.id}');
 final uri = '${datavoice.message.file}';
    try {
      await _player.setUrl(uri);
    } catch (e) {
      debugPrint('An error occured $e');
    }
    if (data['status'] == 'success') {
      print(data);
    } else {
      print('object');
    }
  }


  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

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
          _datavoice(),
          SizedBox(height: 20,),
          _datafile()
        ],
      )
     
    );
  }

  Widget _datavoice() {
    return FutureBuilder(
      future: Comdetailvoice(),
     builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return  SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
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
                                '${datavoice.message.title}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xCC62297B),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 10, 20, 10),
                       
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
                                      'สถานะข้อมูล : ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${datavoice.message.status}',
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

  Widget _datafile() {
    return FutureBuilder(
      future: Comdetailvoice(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: _widgetBorder(),
                  child: _progressBar(),
                ),
                const SizedBox(height: 20),
                _playButton(),
              ],
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

  Wrap _themeButtons() {
    return Wrap(children: [
      OutlinedButton(
        child: const Text('light'),
        onPressed: () {
          themeNotifier.value =
              const ThemeVariation(Colors.blue, Brightness.light);
        },
      ),
      OutlinedButton(
        child: const Text('dark'),
        onPressed: () {
          themeNotifier.value =
              const ThemeVariation(Colors.blue, Brightness.dark);
        },
      ),
    ]);
  }

  Wrap _widgetSizeButtons() {
    return Wrap(children: [
      OutlinedButton(
        child: const Text('hide widget size'),
        onPressed: () {
          setState(() => _isShowingWidgetOutline = false);
        },
      ),
      OutlinedButton(
        child: const Text('show'),
        onPressed: () {
          setState(() => _isShowingWidgetOutline = true);
        },
      ),
    ]);
  }

  BoxDecoration _widgetBorder() {
    return BoxDecoration(
      border: _isShowingWidgetOutline
          ? Border.all(color: Colors.red)
          : Border.all(color: Colors.transparent),
    );
  }

  Wrap _labelLocationButtons() {
    return Wrap(children: [
      OutlinedButton(
        child: const Text('below'),
        onPressed: () {
          setState(() => _labelLocation = TimeLabelLocation.below);
        },
      ),
      OutlinedButton(
        child: const Text('above'),
        onPressed: () {
          setState(() => _labelLocation = TimeLabelLocation.above);
        },
      ),
      OutlinedButton(
        child: const Text('sides'),
        onPressed: () {
          setState(() => _labelLocation = TimeLabelLocation.sides);
        },
      ),
      OutlinedButton(
        child: const Text('none'),
        onPressed: () {
          setState(() => _labelLocation = TimeLabelLocation.none);
        },
      ),
    ]);
  }

  Wrap _labelTypeButtons() {
    return Wrap(children: [
      OutlinedButton(
        child: const Text('total time'),
        onPressed: () {
          setState(() => _labelType = TimeLabelType.totalTime);
        },
      ),
      OutlinedButton(
        child: const Text('remaining time'),
        onPressed: () {
          setState(() => _labelType = TimeLabelType.remainingTime);
        },
      ),
    ]);
  }

  Wrap _labelSizeButtons() {
    final fontColor = Theme.of(context).textTheme.bodyText1?.color;
    return Wrap(children: [
      OutlinedButton(
        child: const Text('standard font size'),
        onPressed: () {
          setState(() => _labelStyle = null);
        },
      ),
      OutlinedButton(
        child: const Text('large'),
        onPressed: () {
          setState(
              () => _labelStyle = TextStyle(fontSize: 40, color: fontColor));
        },
      ),
      OutlinedButton(
        child: const Text('small'),
        onPressed: () {
          setState(
              () => _labelStyle = TextStyle(fontSize: 8, color: fontColor));
        },
      ),
    ]);
  }

  Wrap _thumbSizeButtons() {
    return Wrap(children: [
      OutlinedButton(
        child: const Text('standard thumb radius'),
        onPressed: () {
          setState(() => _thumbRadius = 10);
        },
      ),
      OutlinedButton(
        child: const Text('large'),
        onPressed: () {
          setState(() => _thumbRadius = 20);
        },
      ),
      OutlinedButton(
        child: const Text('small'),
        onPressed: () {
          setState(() => _thumbRadius = 5);
        },
      ),
    ]);
  }

  Wrap _paddingSizeButtons() {
    return Wrap(children: [
      OutlinedButton(
        child: const Text('standard padding'),
        onPressed: () {
          setState(() => _labelPadding = 0.0);
        },
      ),
      OutlinedButton(
        child: const Text('10 padding'),
        onPressed: () {
          setState(() => _labelPadding = 10);
        },
      ),
      OutlinedButton(
        child: const Text('-5 padding'),
        onPressed: () {
          setState(() => _labelPadding = -5);
        },
      ),
    ]);
  }

  Wrap _barHeightButtons() {
    return Wrap(children: [
      OutlinedButton(
        child: const Text('standard bar height'),
        onPressed: () {
          setState(() => _barHeight = 5.0);
        },
      ),
      OutlinedButton(
        child: const Text('thin'),
        onPressed: () {
          setState(() => _barHeight = 1.0);
        },
      ),
      OutlinedButton(
        child: const Text('thick'),
        onPressed: () {
          setState(() => _barHeight = 20.0);
        },
      ),
    ]);
  }

  Wrap _barCapShapeButtons() {
    return Wrap(children: [
      OutlinedButton(
        child: const Text('round caps'),
        onPressed: () {
          setState(() => _barCapShape = BarCapShape.round);
        },
      ),
      OutlinedButton(
        child: const Text('square'),
        onPressed: () {
          setState(() => _barCapShape = BarCapShape.square);
        },
      ),
    ]);
  }

  Wrap _barColorButtons() {
    return Wrap(children: [
      OutlinedButton(
        child: const Text('theme colors'),
        onPressed: () {
          setState(() {
            _baseBarColor = null;
            _progressBarColor = null;
            _bufferedBarColor = null;
            _thumbColor = null;
            _thumbGlowColor = null;
          });
        },
      ),
      OutlinedButton(
        child: const Text('custom'),
        onPressed: () {
          setState(() {
            _baseBarColor = Colors.grey.withOpacity(0.2);
            _progressBarColor = Colors.green;
            _bufferedBarColor = Colors.grey.withOpacity(0.2);
            _thumbColor = Colors.purple;
            _thumbGlowColor = Colors.green.withOpacity(0.3);
          });
        },
      ),
    ]);
  }

  Wrap _thumbOutsideBarButtons() {
    return Wrap(children: [
      OutlinedButton(
        child: const Text('thumb can paint outside bar'),
        onPressed: () {
          setState(() => _thumbCanPaintOutsideBar = true);
        },
      ),
      OutlinedButton(
        child: const Text('false'),
        onPressed: () {
          setState(() => _thumbCanPaintOutsideBar = false);
        },
      ),
    ]);
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: _durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          onSeek: (duration) {
            _player.seek(duration);
          },
          onDragUpdate: (details) {
            debugPrint('${details.timeStamp}, ${details.localPosition}');
          },
          barHeight: _barHeight,
          baseBarColor: _baseBarColor,
          progressBarColor: _progressBarColor,
          bufferedBarColor: _bufferedBarColor,
          thumbColor: _thumbColor,
          thumbGlowColor: _thumbGlowColor,
          barCapShape: _barCapShape,
          thumbRadius: _thumbRadius,
          thumbCanPaintOutsideBar: _thumbCanPaintOutsideBar,
          timeLabelLocation: _labelLocation,
          timeLabelType: _labelType,
          timeLabelTextStyle: _labelStyle,
          timeLabelPadding: _labelPadding,
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 32.0,
            height: 32.0,
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return IconButton(
            icon: const Icon(Icons.play_arrow),
            iconSize: 32.0,
            onPressed: _player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(Icons.pause),
            iconSize: 32.0,
            onPressed: _player.pause,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.replay),
            iconSize: 32.0,
            onPressed: () => _player.seek(Duration.zero),
          );
        }
      },
    );
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}

// To parse this JSON data, do
//
//     final detailvoice = detailvoiceFromJson(jsonString);


Detailvoice detailvoiceFromJson(String str) => Detailvoice.fromJson(json.decode(str));

String detailvoiceToJson(Detailvoice data) => json.encode(data.toJson());

class Detailvoice {
    Detailvoice({
        required this.status,
        required this.message,
    });

    String status;
    Message message;

    factory Detailvoice.fromJson(Map<String, dynamic> json) => Detailvoice(
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
        required this.file,
        required this.date,
        required this.status,
    });

    String id;
    String title;
    String file;
    DateTime date;
    String status;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        title: json["title"],
        file: json["file"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "file": file,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "status": status,
    };
}
