import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/chat_model.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      String teacherId, String studentId, String message) async {
    // final user = FirebaseAuth.instance.currentUser!.uid;
    // final userEmail = FirebaseAuth.instance.currentUser!.email!;
    ChatModel newChat = ChatModel(
      senderId: teacherId,
      receiverId: studentId,
      message: message,
      timestamp: Timestamp.now(),
    );
    List<String> ids = [teacherId, studentId];
    ids.sort();
    String chatRoomId = ids.join('_');
    await _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .add(newChat.toJson());
  }

  Stream<QuerySnapshot> getMessage(userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

}
