// import 'package:dialog_flowtter/dialog_flowtter.dart';
// import 'package:flutter/material.dart';

// class AppBody extends StatelessWidget {
//   final List<Map<String, dynamic>> messages;

//   const AppBody({
//     Key? key,
//     this.messages = const [],
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       itemBuilder: (context, i) {
//         var obj = messages[messages.length - 1 - i];
//         Message message = obj['message'];
//         bool isUserMessage = obj['isUserMessage'] ?? false;
//         return Row(
//           mainAxisAlignment:
//               isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _MessageContainer(
//               message: message,
//               isUserMessage: isUserMessage,
//             ),
//           ],
//         );
//       },
//       separatorBuilder: (_, i) => Container(height: 10),
//       itemCount: messages.length,
//       reverse: true,
//       padding: const EdgeInsets.symmetric(
//         horizontal: 10,
//         vertical: 20,
//       ),
//     );
//   }
// }

// class _MessageContainer extends StatelessWidget {
//   final Message message;
//   final bool isUserMessage;

//   const _MessageContainer({
//     Key? key,
//     required this.message,
//     this.isUserMessage = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(maxWidth: 250),
//       child: LayoutBuilder(
//         builder: (context, constrains) {
//           switch (message.type) {
//             case MessageType.card:
//               return _CardContainer(card: message.card!);
//             case MessageType.text:
//             default:
//               return Container(
//                 decoration: BoxDecoration(
//                   color: isUserMessage ? Colors.blue : Colors.orange,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 padding: const EdgeInsets.all(10),
//                 child: Text(
//                   message.text?.text?[0] ?? '',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               );
//           }
//         },
//       ),
//     );
//   }
// }

// class _CardContainer extends StatelessWidget {
//   final DialogCard card;

//   const _CardContainer({
//     Key? key,
//     required this.card,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Card(
//         color: Colors.orange,
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (card.imageUri != null)
//               Container(
//                 constraints: BoxConstraints.expand(height: 150),
//                 child: Image.network(
//                   card.imageUri!,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     card.title ?? '',
//                     style: TextStyle(
//                       fontSize: 22,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   if (card.subtitle != null)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: Text(
//                         card.subtitle!,
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   if (card.buttons?.isNotEmpty ?? false)
//                     Container(
//                       constraints: BoxConstraints(
//                         maxHeight: 40,
//                       ),
//                       child: ListView.separated(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         // padding: const EdgeInsets.symmetric(vertical: 5),
//                         itemBuilder: (context, i) {
//                           CardButton button = card.buttons![i];
//                           return TextButton(
//                             style: TextButton.styleFrom(
//                               primary: Colors.white,
//                               backgroundColor: Colors.blue,
//                             ),
//                             child: Text(button.text ?? ''),
//                             onPressed: () {
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(SnackBar(
//                                 content: Text(button.postback ?? ''),
//                               ));
//                             },
//                           );
//                         },
//                         separatorBuilder: (_, i) => Container(width: 10),
//                         itemCount: card.buttons!.length,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            20,
                          ),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 0 : 20),
                          topLeft: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 20 : 0),
                        ),
                        color: widget.messages[index]['isUserMessage']
                            ? Colors.grey.shade800
                            : Colors.grey.shade900.withOpacity(0.8)),
                    constraints: BoxConstraints(maxWidth: w * 2 / 3),
                    child:
                        Text(widget.messages[index]['message'].text.text[0])),
              ],
            ),
          );
        },
        separatorBuilder: (_, i) => Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length);
  }
}