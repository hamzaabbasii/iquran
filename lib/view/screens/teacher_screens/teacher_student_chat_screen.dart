// import 'package:custom_clippers/custom_clippers.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:iquran/controller/chat_controller.dart';
// import 'package:iquran/model/chat_model.dart';
// import 'package:iquran/res/constants.dart';
//
// class TeacherStudentChatScreen extends StatelessWidget {
//   final String studentId, teacherId; // The user ID of the teacher or student using the chat screen
//
//   TeacherStudentChatScreen({  required this.studentId, required this.teacherId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat Screen'),
//       ),
//       body: ChatMessages(studentId: studentId, teacherId: teacherId),
//       bottomNavigationBar: ChatInput(studentId: studentId, teacherId: teacherId),
//     );
//   }
// }
//
// class ChatMessages extends StatelessWidget {
//   final String studentId,teacherId;
//
//   ChatMessages({required this.studentId, required this.teacherId});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<ChatModel>>(
//       stream: ChatController().getChatStream(teacherId, studentId),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<ChatModel> messages = snapshot.data!;
//
//           return ListView.builder(
//             itemBuilder: (context, index) {
//               ChatModel message = messages[index];
//               return Padding(
//                 padding: EdgeInsets.only(left: 170, top: 20, right: 20),
//                 child: ClipPath(
//                   clipper: LowerNipMessageClipper(MessageType.send),
//                   child: Container(
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: AppColor.kSecondary.withOpacity(0.1),
//                       ),
//                       child: Text(message.message)),
//                 ),
//               );
//             },
//             itemCount: messages.length,
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
// }
//
// class ChatInput extends StatefulWidget {
//   final String studentId,teacherId;
//
//   ChatInput({required this.studentId, required this.teacherId});
//
//   @override
//   _ChatInputState createState() => _ChatInputState();
// }
//
// class _ChatInputState extends State<ChatInput> {
//   final TextEditingController _messageController = TextEditingController();
//
//   void _sendMessage() {
//     String message = _messageController.text;
//     if (message.isNotEmpty) {
//       ChatController().sendMessageFromTeacherToStudent(widget.teacherId, widget.studentId, message);
//       _messageController.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               decoration: InputDecoration(
//                 hintText: 'Type a message...',
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: _sendMessage,
//           ),
//         ],
//       ),
//     );
//   }
// }