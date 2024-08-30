import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iquran/controller/chat_controller.dart';
import 'package:iquran/model/chat_model.dart';
import 'package:iquran/res/constants.dart';

class StudentChatScreen extends StatefulWidget {
  final String uid,
      teacherId,
      teacherUid; // The user ID of the teacher or student using the chat screen

  StudentChatScreen(
      {required this.uid, required this.teacherId, required this.teacherUid});

  @override
  State<StudentChatScreen> createState() => _StudentChatScreenState();
}

class _StudentChatScreenState extends State<StudentChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Student ID: ${widget.uid}');
    print('Teacher ID: ${widget.teacherId}');
    print('Teacher UID: ${widget.teacherUid}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Chat Screen'),
        backgroundColor: AppColor.kPrimary,
        elevation: 0,
      ),
      body: ChatMessages(uid: widget.uid, teacherId: widget.teacherUid),
      bottomNavigationBar:
          ChatInput(studentId: widget.uid, teacherId: widget.teacherUid),
    );
  }
}

class ChatMessages extends StatefulWidget {
  final String uid, teacherId;

  ChatMessages({required this.uid, required this.teacherId});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ChatController().getMessage(widget.uid, widget.teacherId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          });

          return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.data!.docs.length,
            padding: EdgeInsets.only(bottom: 10),
            itemBuilder: (context, index) {
              return _buildMessage(snapshot.data!.docs[index]);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _buildMessage(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    print('Current User ID: $currentUserId');
    print('Data:${data['receiverId']}');
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Align(
        alignment: data['receiverId'] == currentUserId
            ? Alignment.topLeft
            : Alignment.topRight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: data['receiverId'] == currentUserId
                ? AppColor.kPrimary.withOpacity(0.3)
                : Colors.grey.shade300,
            borderRadius: data['receiverId'] == currentUserId
                ? BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16))
                : BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16)),
          ),
          child: Text(data['message']),
        ),
      ),
    );
  }

}

class ChatInput extends StatefulWidget {
  final String studentId, teacherId;

  ChatInput({required this.studentId, required this.teacherId});

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    String message = _messageController.text;
    if (message.isNotEmpty) {
      ChatController().sendMessage(
        FirebaseAuth.instance.currentUser!.uid, // Use the current user's ID as the senderId
        widget.teacherId,
        message,
      );
      setState(() {});
      _messageController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8, left: 8, right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: AppColor.kPrimary),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
