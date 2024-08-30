import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iquran/model/class_model.dart' as classModel;
import 'package:iquran/model/user_model.dart' as userModel;
import 'package:iquran/res/constants.dart';

const appId = "bff93a69593149aba242640357711901";
const token =
    "007eJxTYNicsmTGgSq5f7dezl3K6CN16KXBqSvLdkY4fDiye4fPKvFMBYaktDRL40QzS1NLY0MTy8SkRCMTIzMTA2NTc3NDQ0sDwwsmb1MbAhkZHtxbzcjIAIEgPhtDZmFpUWIeAwMAaqQjMg==";
const channel = "iquran";

class ClassController extends GetxController {
  static ClassController get instance => Get.find();
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final GlobalKey<FormState> classKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  final classNames = [
    'Hifz Al Quran',
    'Quran Tajweed',
    'Quran Tarjuma',
    'Quran Tafsir',
    'Quran Qirat'
  ].obs;
  var selectedClass = RxString('Hifz Al Quran');
  void selectClassNames(String value) {
    selectedClass.value = value;
  }

  //Agora Setting
  int? remoteUid;
  bool localUserJoind = false;
  bool isTeacher = false;
  Future<void> fetchUserRole() async {
    final user = auth.currentUser;
    if (user != null) {
      final docSnaps = await db.collection('users').doc(user.uid).get();
      isTeacher = docSnaps['role'] == 'Teacher';
      print('Role is ....++++ ${isTeacher}');
    }
  }

  Future<void> createNewClass(
      String name,
      String classDate,
      String startTime,
      String endTime,
      String description,
      List<String> teacherIds,
      ) async {
    try {
      User newUser = FirebaseAuth.instance.currentUser!;
      String uniqueId = '${DateTime.now().millisecondsSinceEpoch}';

      final existingClassSnapshot = await FirebaseFirestore.instance
          .collection('classes')
          .where('createrId', isEqualTo: newUser.uid)
          .where('startTime', isEqualTo: startTime).
      where('endTime', isEqualTo: endTime)
          .get();

      if (existingClassSnapshot.docs.isNotEmpty) {
        Fluttertoast.showToast(msg: 'Class already exists', backgroundColor: AppColor.kbtnColor);
        print('Class already exists');
        return;
      }

      classModel.ClassModel newClass = classModel.ClassModel(
        createrId: newUser.uid,
        id: uniqueId,
        name: name,
        classDate: classDate,
        startTime: startTime,
        endTime: endTime,
        description: description,
        createdAt: Timestamp.now(),
        teacherIds: teacherIds,
      );

      await FirebaseFirestore.instance
          .collection('classes')
          .doc(uniqueId)
          .set(newClass.toJson());
      Fluttertoast.showToast(msg: 'Class created successfully', backgroundColor: AppColor.kbtnColor);
      print('Class created successfully');
    } catch (ex) {
      print('Error creating class: $ex');
    }
  }

  Future<List<classModel.ClassModel>> fetchClassInfo() async {
    List<classModel.ClassModel> classList = [];
    try {
      User currentUser = FirebaseAuth.instance.currentUser!;
      var classes = await db
          .collection('classes')
          .where('createrId', isEqualTo: currentUser.uid)
       // Add this line
          .get();
      classes.docs.forEach((classDoc) {
        classModel.ClassModel classInfo =
        classModel.ClassModel.fromSnap(classDoc);
        classList.add(classInfo);
      });
    } catch (e) {
      print(e.toString());
    }
    return classList;
  }


  Future<List<classModel.ClassModel>> fetchUniqueClasses() async {
    List<classModel.ClassModel> classList = [];
    Set<String> existingClassNames = {}; // Set to store unique class names

    try {
      var classes =
          await FirebaseFirestore.instance.collection('classes').get();
      for (var classDoc in classes.docs) {
        classModel.ClassModel classInfo =
            classModel.ClassModel.fromSnap(classDoc);
        String className = classInfo.name!;

        // Check if class name is unique before adding
        if (!existingClassNames.contains(className)) {
          classList.add(classInfo);
          existingClassNames.add(className);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return classList;
  }

  Future<List<Map<String, dynamic>>> fetchTeachersWithClassIdForClassName(
      String className) async {
    List<Map<String, dynamic>> teachersWithClassId = [];
    try {
      // Fetch classes with the given name
      final classSnapshots = await FirebaseFirestore.instance
          .collection('classes')
          .where('name', isEqualTo: className)
          .get();

      print('Class snapshots: ${classSnapshots.docs}'); // Debugging

      // For each class, fetch the teachers
      for (var classDoc in classSnapshots.docs) {
        final classData = classModel.ClassModel.fromSnap(classDoc);
        print('class DATA: ${classData.name}'); // Debugging
        // Assuming teacherIds is a list of User IDs
        final teacherIds = classData.teacherIds;
        print('Teacher IDs: $teacherIds');
        final teacherSnapshots = await FirebaseFirestore.instance
            .collection('users')
            .where('teacherIds', arrayContainsAny: teacherIds)
            .get();
        print('Teacher snapshots: ${teacherSnapshots.docs}'); // Debugging

        // Add the teachers along with the class ID
        teachersWithClassId.addAll(teacherSnapshots.docs
            .map((doc) => {
                  'teacher': userModel.UserModel.fromSnap(doc),
                  'classId': classDoc.id,
                  'className': className // Include the class name
                })
            .toList());
      }
    } catch (error) {
      print('Error fetching teachers: $error');
    }
    return teachersWithClassId;
  }

  Future<List<Map<String, dynamic>>> fetchClassesWithSameName(
      String className) async {
    List<Map<String, dynamic>> classesWithSameName = [];

    try {
      // Fetch classes with the given name
      final classSnapshots = await FirebaseFirestore.instance
          .collection('classes')
          .where('name', isEqualTo: className)
          .get();

      for (var classDoc in classSnapshots.docs) {
        Map<String, dynamic> classData = classDoc.data();
        classData['id'] = classDoc.id; // Include the class ID
        classesWithSameName.add(classData);
      }
    } catch (error) {
      print('Error fetching classes with the same name: $error');
    }
    return classesWithSameName;
  }

  Future<List<Map<String,dynamic>>> fetchApprovedRequests(String teacherId) async {
    List<Map<String, dynamic>> acceptedRequests = [];
    try {
      // Fetch accepted requests for the specified teacher
      final requestSnapshots = await FirebaseFirestore.instance
          .collection('requests')
          .where('teacherId', isEqualTo: teacherId)
          .where('status', isEqualTo: 'accepted')
          .get();
      //print('Request snapshots: ${requestSnapshots.docs[0].data()}');
      // For each accepted request, fetch the corresponding user details
      for (var requestDoc in requestSnapshots.docs) {
        final requestData = requestDoc.data();
        final studentId = requestData['studentId'];

        // Fetch user details for the student
        final studentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('userId', isEqualTo: studentId)
            .get();
        //print('Student snapshot: ${studentSnapshot.docs[0].data()}');
        // Add the student details along with the request data
        acceptedRequests.add({
          'request': requestData,
          'student': studentSnapshot,
        });
      }
    } catch (error) {
      print('Error fetching accepted requests for teacher: $error');
    }
    //print('Accepted requests: $acceptedRequests');
    return acceptedRequests;
  }
  // Future<List<Map<String, dynamic>>> fetchClassesForStudents(String studentId)
  // {
  //   final List<Map<String, dynamic>> classes = [];
  //   try {
  //     // Fetch classes for the specified student
  //     final classSnapshots = FirebaseFirestore.instance
  //         .collection('classes')
  //         .where('studentIds', arrayContains: studentId)
  //         .get();
  //     print('Class snapshots: ${classSnapshots.docs.data()}');
  //     // For each class, fetch the teacher details
  //   } catch (error) {
  //     print('Error fetching classes for student: $error');
  //   }
  // }
  // Future<List<Map<String, dynamic>>> fetchClassesForApprovedRequests(String studentId) async {
  //   List<Map<String, dynamic>> classesForApprovedRequests = [];
  //
  //   try {
  //     // Fetch accepted requests for the specified student
  //     final requestSnapshots = await FirebaseFirestore.instance
  //         .collection('requests')
  //         .where('studentId', isEqualTo: studentId)
  //         .where('status', isEqualTo: 'accepted')
  //         .get();
  //
  //     // For each accepted request, fetch the corresponding class details
  //     for (var requestDoc in requestSnapshots.docs) {
  //       final requestData = requestDoc.data();
  //       final classId = requestData['classId'];
  //
  //       // Fetch class details for the class
  //       final classSnapshot = await FirebaseFirestore.instance
  //           .collection('classes')
  //           .doc(classId)
  //           .get();
  //
  //       // Add the class details along with the request data
  //       classesForApprovedRequests.add({
  //         'request': requestData,
  //         'class': classSnapshot.data(),
  //       });
  //     }
  //   } catch (error) {
  //     print('Error fetching classes for approved requests: $error');
  //   }
  //
  //   return classesForApprovedRequests;
  // }
  Future<List<Map<String, dynamic>>> fetchClassesForApprovedRequests(String studentId) async {
    List<Map<String, dynamic>> classesForApprovedRequests = [];

    try {
      // Fetch accepted requests for the specified student
      final requestSnapshots = await FirebaseFirestore.instance
          .collection('requests')
          .where('studentId', isEqualTo: studentId)
          .where('status', isEqualTo: 'accepted')
          .get();

      // For each accepted request, fetch the corresponding class details
      for (var requestDoc in requestSnapshots.docs) {
        final requestData = requestDoc.data();
        final classId = requestData['classId'];

        // Fetch class details for the class
        final classSnapshot = await FirebaseFirestore.instance
            .collection('classes')
            .doc(classId)
            .get();

        final classData = classSnapshot.data();
        final teacherIds = classData?['teacherIds'];

        // Fetch teacher details for the class
        final teacherSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('teacherIds', arrayContainsAny: teacherIds)
            .get();

        // Add the class details, request data, and teacher details
        classesForApprovedRequests.add({
          'request': requestData,
          'class': classData,
          'teacher': teacherSnapshot.docs.map((doc) => doc.data()).toList(),
        });
      }
    } catch (error) {
      print('Error fetching classes for approved requests: $error');
    }

    return classesForApprovedRequests;
  }

  Future<List<Map<String, dynamic>>> fetchApprovedTeachers(String studentId) async {
    List<Map<String, dynamic>> approvedRequests = [];
    try {
      // Fetch accepted requests for the specified student
      final requestSnapshots = await FirebaseFirestore.instance
          .collection('requests')
          .where('studentId', isEqualTo: studentId)
          .where('status', isEqualTo: 'accepted')
          .get();

      // For each accepted request, fetch the corresponding teacher details
      for (var requestDoc in requestSnapshots.docs) {
        final requestData = requestDoc.data();
        final teacherId = requestData['teacherId'];
        print('Teacher ID: $teacherId');

        // Fetch user details for the teacher
        final teacherSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('teacherIds', arrayContains: teacherId)
            .get();

        // Add the teacher details along with the request data
        for (var teacherDoc in teacherSnapshot.docs) {
          approvedRequests.add({
            'request': requestData,
            'teacher': teacherDoc.data(),
          });
        }
      }
    } catch (error) {
      print('Error fetching approved requests for student: $error');
    }

    return approvedRequests;
  }

  Future<void> deleteClass(String classId) async {
    try {
      await FirebaseFirestore.instance.collection('classes').doc(classId).delete();
      print('Class deleted successfully');
    } catch (error) {
      print('Error deleting class: $error');
    }
  }
}
