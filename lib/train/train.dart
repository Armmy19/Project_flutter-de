import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test/train/list_train.dart';
import 'package:test/train/training_audiobook.dart';
import 'package:test/train/training_book.dart';
import 'package:test/train/training_video.dart';

class Train extends StatefulWidget {
  const Train({Key? key}) : super(key: key);

  @override
  State<Train> createState() => _TrainState();
}

class _TrainState extends State<Train> {
  final TextEditingController controller = TextEditingController(
      text:
          'แนะนำการฝึกอบรม  มี ทั้งหมด สี่ คอร์สเรียน คอร์สที่หนึ่งฝึกอบรม คอร์สที่สองหนังสือออนไล คอร์สที่สามหนังสือเสียง คอร์สที่สี่วิดิโอฝึกสอนอาชีพ');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เเนะนำรายการฝึกอบรม'),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.keyboard_voice),
          //   tooltip: 'Show Snackbar',
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('อธิบายด้วยเสียง')));
          //   },
          // ),
          // IconButton(
          //   icon: const Icon(Icons.navigate_next),
          //   tooltip: 'Go to the next page',
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute<void>(
          //       builder: (BuildContext context) {
          //         return Scaffold(
          //           appBar: AppBar(
          //             title: const Text('Next page'),
          //           ),
          //           body: const Center(
          //             child: Text(
          //               'อธิบายด้วยเสียง',
          //               style: TextStyle(fontSize: 24),
          //             ),
          //           ),
          //         );
          //       },
          //     ));
          //   },
          // ),
        ],
      ),
      body: ListView(
        children: [
          Card(
            elevation: 5,
            shadowColor: Color.fromARGB(255, 194, 56, 6),
            // color: Color.fromARGB(255, 136, 186, 244),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // if you need this
              side: BorderSide(
                color: Color.fromARGB(255, 230, 202, 202).withOpacity(0.2),
                width: 5,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: const Text('คอร์สฝึกอบรม',
                      style: TextStyle(fontSize: 20)),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.class_sharp),
                      label: Text(
                        'คอร์สฝึกอบรม',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Listtrain();
                        }));
                      },
                    ),
                  ],
                ),
                Image.network('https://d4all-onde.com/images/course.png'),
              ],
            ),
          ),
          Card(
            elevation: 5,
            shadowColor: Color.fromARGB(255, 194, 56, 6),
            // color: Color.fromARGB(255, 136, 186, 244),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // if you need this
              side: BorderSide(
                color: Color.fromARGB(255, 230, 202, 202).withOpacity(0.2),
                width: 5,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: const Text('หนังสือออนไลน์',
                      style: TextStyle(fontSize: 20)),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.book),
                      label: Text(
                        'หนังสือออนไลน์',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Listbook();
                        }));
                      },
                    ),
                  ],
                ),
                Image.network('https://d4all-onde.com/images/book.png'),
              ],
            ),
          ),
          Card(
            elevation: 5,
            shadowColor: Color.fromARGB(255, 194, 56, 6),
            // color: Color.fromARGB(255, 136, 186, 244),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // if you need this
              side: BorderSide(
                color: Color.fromARGB(255, 230, 202, 202).withOpacity(0.2),
                width: 5,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: const Text('หนังสือเสียงออนไลน์',
                      style: TextStyle(fontSize: 20)),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.audio_file),
                      label: Text(
                        'หนังสือเสียง',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Training_audiobook();
                        }));
                      },
                    ),
                  ],
                ),
                Image.network('https://d4all-onde.com/images/audio_book.png'),
              ],
            ),
          ),
          Card(
            elevation: 5,
            shadowColor: Color.fromARGB(255, 194, 56, 6),
            // color: Color.fromARGB(255, 136, 186, 244),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // if you need this
              side: BorderSide(
                color: Color.fromARGB(255, 230, 202, 202).withOpacity(0.2),
                width: 5,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: const Text('วิดีโอฝึกสอนอาชีพ',
                      style: TextStyle(fontSize: 20)),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.videogame_asset),
                      label: Text(
                        'วิดีโอฝึกสอนอาชีพ',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Training_video();
                        }));
                      },
                    ),
                  ],
                ),
                Image.network('https://d4all-onde.com/images/video.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}






//  Card(
//                 elevation: 5,
//                 shadowColor: Color.fromARGB(255, 194, 56, 6),
//                 // color: Color.fromARGB(255, 136, 186, 244),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20), // if you need this
//                   side: BorderSide(
//                     color: Color.fromARGB(255, 230, 202, 202).withOpacity(0.2),
//                     width: 5,
//                   ),
//                 ),
//                 clipBehavior: Clip.antiAlias,
//                 child: Column(
//                   children: [
//                     ListTile(
//                       leading: Icon(Icons.arrow_drop_down_circle),
//                       title: const Text('โปรแกรมที่ 2 Chatbot พูดคุย',
//                           style: TextStyle(fontSize: 20)),
//                       subtitle: Text(
//                         'Secondary Text',
//                         style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                       ),
//                     ),
//                     ButtonBar(
//                       alignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton.icon(
//                           icon: Icon(Icons.add),
//                           label: Text(
//                             'โปรแกรม',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           onPressed: () {
//                             // Navigator.push(context,
//                             //     MaterialPageRoute(
//                             //         builder: (context) {
//                             //   return Progarm2();
//                             // }));
//                           },
//                         ),
//                       ],
//                     ),
//                     Image.asset('image_app/logo/2.png'),
//                   ],
//                 ),
//               ),