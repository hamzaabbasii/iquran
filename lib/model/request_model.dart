import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  final String id;
  final String teacherId;
  final String studentId;
  final String classId;
  final String className;
  final String query;
  final String status;
  bool isApproved;

  RequestModel({
    required this.id,
    required this.teacherId,
    required this.studentId,required this.classId,
    required this.className,
    required this.query,
    required this.status,
    this.isApproved = false,
  });

  // Method to convert a Firestore document to a RequestModel
  static RequestModel fromSnap(DocumentSnapshot snap) {
    return RequestModel(
      id: snap.id,
      teacherId: snap['teacherId'],
      studentId: snap['studentId'],
      classId: snap['classId'],
      className: snap['className'],
      query: snap['query'],
      status: snap['status'],
    );
  }

  // Method to convert a RequestModel to a Firestore document
  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'teacherId': teacherId,
      'studentId': studentId,
      'classId': classId,
      'className': className,
      'query': query,
      'status': status,
    };
  }
}