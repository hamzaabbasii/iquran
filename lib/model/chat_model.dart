import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  // final String id; // Unique message ID
  final String senderId; // ID of the sender (teacher or student)
  final String receiverId; // ID of the receiver (teacher or student)
  final String message; // Content of the message
  final Timestamp timestamp; // Timestamp of the message

  ChatModel({
    // required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  // Convert Firestore snapshot to ChatModel
  factory ChatModel.fromSnap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      // id: doc.id,
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      message: data['message'] ?? '',
      timestamp: data['timestamp']
    );
  }

  // Convert ChatModel data to a map for Firestore
  Map<String, dynamic> toJson() {
    return {
      // 'id':id,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
