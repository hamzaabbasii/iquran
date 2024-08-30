import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  final String? notesId;
  final String? createrId;
  final String? heading;
  final String? description;
  NotesModel(
      {
        this.notesId,
        this.createrId,
        this.heading,
        this.description,

      });

  Map<String, dynamic> toJson()
  {
    return{
      'notesId': notesId,
      'createrId':createrId,
      'heading': heading,
      'description':description,
    };
  }

  static NotesModel fromSnap(DocumentSnapshot snapshot)
  {
    var snapshotData = snapshot.data() as Map<String, dynamic>;
    return NotesModel(
      notesId : snapshotData['notesId'],
      createrId: snapshotData['createrId'],
      heading : snapshotData['heading'],
      description: snapshotData['description'],
    );
  }

}
