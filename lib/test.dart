// import 'package:dialog_flowtter/dialog_flowtter.dart';
// import 'package:flutter/material.dart';
// import 'package:test/app_body.dart';

// // import 'app_body.dart';



// class ttt extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dialog Flowtter Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Dialog Flowtter'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);

//   final String? title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late DialogFlowtter dialogFlowtter;
//   final TextEditingController _controller = TextEditingController();

//   List<Map<String, dynamic>> messages = [];

//   @override
//   void initState() {
//     super.initState();
//     DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title ?? 'DialogFlowtter app'),
//       ),
//       body: Column(
//         children: [
//           Expanded(child: AppBody(messages: messages)),
//           Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 10,
//               vertical: 5,
//             ),
//             color: Colors.blue,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 IconButton(
//                   color: Colors.white,
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     sendMessage(_controller.text);
//                     _controller.clear();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void sendMessage(String text) async {
//     if (text.isEmpty) return;
//     setState(() {
//       addMessage(
//         Message(text: DialogText(text: [text])),
//         true,
//       );
//     });

//     // dialogFlowtter.projectId = "deimos-apps-0905";

//     DetectIntentResponse response = await dialogFlowtter.detectIntent(
//       queryInput: QueryInput(text: TextInput(text: text)),
//     );

//     if (response.message == null) return;
//     setState(() {
//       addMessage(response.message!);
//     });
//   }

//   void addMessage(Message message, [bool isUserMessage = false]) {
//     messages.add({
//       'message': message,
//       'isUserMessage': isUserMessage,
//     });
//   }

//   @override
//   void dispose() {
//     dialogFlowtter.dispose();
//     super.dispose();
//   }
// }



import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:test/app_body.dart';



class ttt extends StatelessWidget {
  const ttt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'เทศแชท',
      theme: ThemeData(brightness: Brightness.dark),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เทส'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Colors.deepPurple,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                  )),
                  IconButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}




 
// class Tip5 extends StatefulWidget {
//   Tip5() : super();
 
//   final String title = "Back Button Demo";
 
//   @override
//   Tip5State createState() => Tip5State();
// }
 
// class Tip5State extends State<Tip5> {
//   //
 
//   Future _onBackPressed() {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Are you sure?'),
//             content: Text('You are going to exit the application!!'),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('NO'),
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 },
//               ),
//               TextButton(
//                 child: Text('YES'),
//                 onPressed: () {
//                   Navigator.of(context).pop(true);
//                 },
//               ),
//             ],
//           );
//         });
//   }
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: WillPopScope(
//         onWillPop: _onBackPressed,
//         child: Container(),
//       ),
//     );
//   }
// }