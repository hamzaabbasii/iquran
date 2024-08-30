import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iquran/controller/chat_controller.dart';
import 'package:iquran/model/chat_model.dart';
import 'package:iquran/res/constants.dart';

class ChatScreen extends StatefulWidget {
  final String studentId,
      uid; // The user ID of the teacher or student using the chat screen

  ChatScreen({required this.studentId, required this.uid});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Student ID: ${widget.studentId}');
    print('Teacher ID: ${widget.uid}');
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
      body: ChatMessages(uid: widget.uid, studentId: widget.studentId),
      bottomNavigationBar:
          ChatInput(uid: widget.uid, studentId: widget.studentId),
    );
  }
}

class ChatMessages extends StatefulWidget {
  final String uid, studentId;

  ChatMessages({required this.uid, required this.studentId});

  static User? user = FirebaseAuth.instance.currentUser;

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ChatController().getMessage(widget.uid, widget.studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          });

          return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.data!.docs.length,
            padding: const EdgeInsets.only(bottom: 10),
            itemBuilder: (context, index) {
              return _buildMessage(snapshot.data!.docs[index]);
            },
          );
        }
        else {
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

    return Padding(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Align(
        alignment: data['senderId'] == currentUserId
            ? Alignment.topRight
            : Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: data['senderId'] == currentUserId
                ? AppColor.kPrimary.withOpacity(0.3)
                : Colors.grey.shade300,
            borderRadius: data['senderId'] == currentUserId
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
  final String uid, studentId;

  ChatInput({required this.uid, required this.studentId});

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    String message = _messageController.text;
    if (message.isNotEmpty) {
      ChatController().sendMessage(
        FirebaseAuth.instance.currentUser!
            .uid, // Use the current user's ID as the senderId
        widget.studentId,
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
