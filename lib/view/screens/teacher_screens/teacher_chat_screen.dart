import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iquran/controller/chat_controller.dart';
import 'package:iquran/model/chat_model.dart';
import 'package:iquran/res/constants.dart';

class TeachereChatScreen extends StatefulWidget {
  final String studentId, teacherId; // The user ID of the teacher or student using the chat screen

  TeachereChatScreen({  required this.studentId, required this.teacherId});

  @override
  State<TeachereChatScreen> createState() => _TeachereChatScreenState();
}

class _TeachereChatScreenState extends State<TeachereChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: ChatMessages(studentId: widget.studentId, teacherId: widget.teacherId),
      bottomNavigationBar: ChatInput(studentId: widget.studentId, teacherId: widget.teacherId),
    );
  }
}

class ChatMessages extends StatefulWidget {
  final String studentId,teacherId;

  ChatMessages({required this.studentId, required this.teacherId});

  static User? user = FirebaseAuth.instance.currentUser;

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ChatController().getMessage(widget.teacherId, widget.studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!;

          return ListView(
            children: snapshot.data!.docs.map<Widget>((doc)=>_buildMessage(doc)).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _buildMessage(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
    final isMe = data['senderId']!= data['recieverId'];

    print('Data Sender ID: ${data['senderId']}');
    print('Data Sender ID===>>>: ${widget.teacherId}');
    return Padding(
      padding: EdgeInsets.only(left : 20, top: 20, right:  20),
      child: Align(
        alignment: isMe ? Alignment.topRight: Alignment.topLeft,
        child: ClipPath(
          clipper: isMe? LowerNipMessageClipper(MessageType.send): LowerNipMessageClipper(MessageType.receive),
          child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.kSecondary.withOpacity(0.1),
              ),
              child: Text(data['message'])),
        ),
      ),
    );
  }
}

class ChatInput extends StatefulWidget {
  final String studentId,teacherId;

  ChatInput({required this.studentId, required this.teacherId});

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    String message = _messageController.text;
    if (message.isNotEmpty) {
      ChatController().sendMessage(widget.teacherId, widget.studentId, message);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}