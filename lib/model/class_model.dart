import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iquran/model/user_model.dart' as userModel;

class ClassModel {
  final String? id;
  final String? createrId;
  final String? name;
  final String? classDate;
  final String? startTime;
  final String? endTime;
  final String? description;
  final Timestamp? createdAt;

  final List<String>? teacherIds;
  final List<String>? studentIds;
  ClassModel(
      {this.id,
      this.createrId,
      this.name,
        this.classDate,
      this.startTime,
      this.endTime,
      this.description,
      this.teacherIds,
        this.studentIds,
      this.createdAt
      });

  Map<String, dynamic> toJson()
  {
    return{
      'id': id,
      'createrId':createrId,
      'name': name,
      'classDate': classDate,
      'startTime': startTime,
      'endTime': endTime,
      'description':description,
      'teacherIds':teacherIds,
      'studentIds':studentIds,
      'createdAt': createdAt,
    };
  }

  static ClassModel fromSnap(DocumentSnapshot snapshot)
  {
    var snapshotData = snapshot.data() as Map<String, dynamic>;
    List<String> teacherIds = [];
    if (snapshotData.containsKey('teacherIds')) {
      teacherIds = (snapshotData['teacherIds'] as List?)?.cast<String>() ?? [];
    }
    List<String> studentIds = [];
    if(snapshotData.containsKey('studentIds'))
    {
      studentIds = (snapshotData['studentIds'] as List?)?.cast<String>() ?? [];
    }
    return ClassModel(
      id : snapshotData['id'],
      createrId: snapshotData['createrId'],
      name : snapshotData['name'],
      classDate : snapshotData['classDate'],
      startTime : snapshotData['startTime'],
      endTime : snapshotData['endTime'],
      description : snapshotData['description'],
      teacherIds: teacherIds,
      studentIds: studentIds,
      createdAt : snapshotData['createdAt'],
    );
  }
}
