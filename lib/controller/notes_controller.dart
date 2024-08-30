import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/notes_model.dart' as notesModel;

class NotesController extends GetxController{
  final TextEditingController notesHeadingController = TextEditingController();
  final TextEditingController notesDescriptionController = TextEditingController();

  //Firebase
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<void> createNotes(String heading, String description)
  async{
    try{
      User user = auth.currentUser!;
      notesModel.NotesModel newNote = notesModel.NotesModel(
        createrId: user.uid,
        heading: heading,
        description: description,
      );
      await db.collection('notes').add(newNote.toJson());
    }
    catch(ex)
    {

    }
  }


  Future<List<notesModel.NotesModel>> fetchNotesInfo() async {
    List<notesModel.NotesModel> notesList = [];
    try {
      User currentUser = auth.currentUser!;
      var notes = await db.collection('notes').where('createrId', isEqualTo: currentUser.uid).get();
      notes.docs.forEach((notesDoc) {
        notesModel.NotesModel notesInfo = notesModel.NotesModel.fromSnap(notesDoc);
        notesList.add(notesInfo);
        update();
      });
      print('Note Lists ${notesList}');
    } catch (e) {
      print('No Data Found In List');
    }
    return notesList;
  }

}