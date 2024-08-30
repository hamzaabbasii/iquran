import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iquran/model/user_model.dart' as userModel;
import 'package:iquran/model/class_model.dart' as classModel;
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/admin/home_screen.dart';
import 'package:iquran/view/screens/select_role_screen.dart';
import 'package:iquran/view/screens/student_screens/student_dashboard.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_dashboard.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_waiting_screen.dart';

import '../model/request_model.dart';

class AuthController extends GetxController {
  //Firebase Commons
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;

  //Auth Controller Instance
  static AuthController instance = Get.find();

  //Text Login and Signup Text Editing Controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController teacherPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController teacherRoleController = TextEditingController();
  final TextEditingController studentRoleController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController signInPasswordController =
      TextEditingController();

  //Global Keys
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> setProfileFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  //Dropdown Gender Fields Controller
  final gender = ['Male', 'Female'].obs;
  var selectGender = RxString('Male');
  void changeGender(String value) {
    selectGender.value = value;
  }

  //Dropdown Class Fields Controller
  final specialization = ['Hifz', 'Tajweed', 'Tarjuma', 'Tafsir', 'Qirat'].obs;
  var selectedSpecialization = RxString('Hifz');
  void selectSpecialization(String value) {
    selectedSpecialization.value = value;
  }

  //Class Names

  //Dropdown Gender Fields Controller
  final experience = ['Fresh', '01', '02', '03', '04', '05 or More'].obs;
  var selectExperience = RxString('Fresh');
  void changeExperience(String value) {
    selectExperience.value = value;
  }

  //Image Picker Code
  Rx<File?> pickedFile = Rx<File?>(null);
  File? get profileImage => pickedFile.value;
  void chooseImageFromGallery() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      pickedFile.value = File(pickedImageFile.path);
      Fluttertoast.showToast(msg: 'Profile image successfully selected');
    }
  }

  void captureImageFromCamera() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImageFile != null) {
      pickedFile.value = File(pickedImageFile.path);
      Fluttertoast.showToast(msg: 'Profile image successfully captured');
    }
  }

  //Pdf pick code
  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return File(result.files.first.path!);
    } else {
      // User canceled the picker
    }
  }

  //Firebase Backend Code
  void createUserWithEmailAndPassword(
      String email,
      String password,
      String name,
      String className,
      String phone,
      File imageFile,
      String role,
      String? experience,
      String? about,
      String? specialization,
      String gender,
      File? cnicFile,
      File? pdfFile) async {
    List<String> allowedRoles = ['Teacher', 'Student'];
    String teacherIds = sha256.convert(utf8.encode(email)).toString();
    if (!allowedRoles.contains(role)) {
      Fluttertoast.showToast(
          msg: 'Invalid role. Please choose Teacher or Student');
      return;
    }
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String imageUrl = await uploadImageToStorage(imageFile);

      String cnic = ''; // Initialize with an empty string
      if (cnicFile != null) {
        cnic = await uploadCnicToStorage(cnicFile);
      }

      String pdf = ''; // Initialize with an empty string
      if (pdfFile != null) {
        pdf = await uploadPdfToStorage(pdfFile);
      }
      userModel.UserModel user = userModel.UserModel(
        userId: userCredential.user!.uid,
        name: name,
        email: email,
        phoneNumber: phone,
        password: password,
        imageName: imageUrl,
        role: role,
        experience: experience,
        about: about,
        specialization: specialization,
        gender: gender,
        docFile: pdf,
        cnic: cnic,
        isApproved: role == 'Teacher' ? false : true,
        teacherIds: role == 'Teacher' ? [teacherIds] : null,
      );
      await db
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toJson());
      if (role == 'Student') {
        Get.offAll(() => StudentDashboard());
        Fluttertoast.showToast(
            msg: 'Signed up successfully', backgroundColor: AppColor.kbtnColor);
      } else if (role == 'Teacher') {
        await updateClassWithTeacherId(className, userCredential.user!.uid);
        Get.offAll(() => TeacherWaitingScreen());
      } else {
        Fluttertoast.showToast(msg: 'This role does not exits');
      }
    } catch (ex) {
      Fluttertoast.showToast(msg: 'Unsuccessful, $ex Error');
    }
  }

  Future<void> updateUserData(userModel.UserModel user) async {
    try {
      await db.collection('users').doc(user.userId).update(user.toJson());
      Fluttertoast.showToast(msg: 'User data updated successfully');
    } catch (e) {
      print('Error updating user data: $e');
      Fluttertoast.showToast(msg: 'An error occurred while updating user data');
    }
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    Reference ref =
        storage.ref().child('Profile Pictures').child(auth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    final imageDownloadUrl = await snapshot.ref.getDownloadURL();
    return imageDownloadUrl;
  }

  Future<String> uploadCnicToStorage(File imageFile) async {
    Reference ref = storage.ref().child('CNIC').child(auth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    final imageDownloadUrl = await snapshot.ref.getDownloadURL();
    return imageDownloadUrl;
  }

  Future<String> uploadPdfToStorage(File pdfFile) async {
    final path = 'Files/${pdfFile}';
    final ref = storage.ref().child(path);
    UploadTask uploadTask = ref.putFile(pdfFile);
    final snapshot = await uploadTask.whenComplete(() => {});
    final pdfDownloadUrl = await snapshot.ref.getDownloadURL();
    return pdfDownloadUrl;
  }

  Future<void> updateClassWithTeacherId(
      String className, String teacherId) async {
    try {
      var classes = await db
          .collection('classes')
          .where('name', isEqualTo: className)
          .get();
      for (var classDoc in classes.docs) {
        classModel.ClassModel classInfo =
            classModel.ClassModel.fromSnap(classDoc);
        List<String> teacherIds = classInfo.teacherIds ?? [];
        teacherIds.add(teacherId);
        await db
            .collection('classes')
            .doc(classInfo.id)
            .update({'teacherIds': teacherIds});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      DocumentSnapshot docSnap =
          await db.collection('users').doc(userCredential.user!.uid).get();
      if (docSnap.exists) {
        String userRole = docSnap['role'];
        if (userRole == 'Teacher') {
          if (docSnap['isApproved'] ?? false) {
            // Check for approval field (optional)

            Get.to(() => TeacherDashboard());
            Fluttertoast.showToast(
                msg: 'Sign in Successfully',
                backgroundColor: AppColor.kbtnColor);
          }
          else {
            // Show a message or redirect to a waiting screen for teachers
            Get.offAll(() => TeacherWaitingScreen());
            Fluttertoast.showToast(
                msg: 'Wait until admin accept your request',
                backgroundColor: AppColor.kbtnColor);
          }
        } else if (userRole == 'Student') {
          Get.offAll(() => StudentDashboard());
          Fluttertoast.showToast(
              msg: 'Sign in Successfully', backgroundColor: AppColor.kbtnColor);
        } else if (userRole == 'Admin') {
          Get.offAll(() => AdminHomeScreen());
          Fluttertoast.showToast(
              msg: 'Sign in Successfully', backgroundColor: AppColor.kbtnColor);
        } else {}
      }
    } on FirebaseAuthException catch (ex) {
      Fluttertoast.showToast(
          msg: 'Error $ex', backgroundColor: AppColor.kbtnColor);
    } catch (ex) {
      // Handle exception
      Fluttertoast.showToast(msg: ex.toString());
    }
  }

  void logoutUser() async {
    try {
      await auth.signOut();
      Get.offAll(() => RoleScreen());
    } catch (ex) {}
  }

  Future<userModel.UserModel> fetchUser() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return userModel.UserModel.fromSnap(snapshot);
  }

  void removeTeacher(String uid) async {
    await db.collection('users').doc(uid).delete();
  }

  void approveTeacher(String uid) async {
    await db.collection('users').doc(uid).update({'isApproved': true});
  }

  Future<List<userModel.UserModel>> getTeachers() async {
    final users =
        await db.collection('users').where('role', isEqualTo: 'Teacher').get();
    final teacherList =
        users.docs.map((doc) => userModel.UserModel.fromSnap(doc)).toList();
    return teacherList;
  }

  Future<List<Map<String, dynamic>>> fetchClassesWithUserDataForStudent(
      String studentId) async {
    final CollectionReference classesCollection =
        FirebaseFirestore.instance.collection('classes');
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    final CollectionReference requestsCollection =
        FirebaseFirestore.instance.collection('requests');
    print('Object');
    try {
      // Fetch the requests for the student
      final QuerySnapshot requestQuerySnapshot = await requestsCollection
          .where('studentId', isEqualTo: studentId)
          .where('status', isEqualTo: 'accepted')
          .get();
      print('Query SnapShot: $requestQuerySnapshot');
      List<Map<String, dynamic>> classesWithUserData = [];

      for (var doc in requestQuerySnapshot.docs) {
        RequestModel request = RequestModel.fromSnap(doc);

        // Fetch the class data
        DocumentSnapshot classDocSnapshot =
            await classesCollection.doc(request.classId).get();
        classModel.ClassModel classInfo =
            classModel.ClassModel.fromSnap(classDocSnapshot);

        // Fetch the teacher data for the class
        DocumentSnapshot teacherDocSnapshot =
            await usersCollection.doc(classInfo.teacherIds?.first).get();
        userModel.UserModel teacher =
            userModel.UserModel.fromSnap(teacherDocSnapshot);

        // Add the class and teacher data to the list
        classesWithUserData.add({
          'class': classInfo,
          'teacher': teacher,
        });
      }

      return classesWithUserData;
    } catch (e) {
      print('Error fetching classes with user data for student: $e');
      return []; // Return an empty list in case of error
    }
  }

  // Future<List<Map<String, dynamic>>> fetchClassesWithUserDataForTeacher(String teacherId) async {
  //   final CollectionReference classesCollection = FirebaseFirestore.instance.collection('classes');
  //   final CollectionReference requestsCollection = FirebaseFirestore.instance.collection('requests');
  //   final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  //
  //   try {
  //     // Fetch the requests for the teacher
  //     final QuerySnapshot requestQuerySnapshot = await requestsCollection
  //         .where('teacherId', isEqualTo: teacherId)
  //         .where('status', isEqualTo: 'accepted')
  //         .get();
  //
  //     List<Map<String, dynamic>> classesWithUserData = [];
  //
  //     for (var doc in requestQuerySnapshot.docs) {
  //       RequestModel request = RequestModel.fromSnap(doc);
  //
  //       // Fetch the class data
  //       DocumentSnapshot classDocSnapshot = await classesCollection.doc(request.classId).get();
  //       classModel.ClassModel classInfo = classModel.ClassModel.fromSnap(classDocSnapshot);
  //
  //       // Fetch the user data for the student who made the request
  //       DocumentSnapshot userDocSnapshot = await usersCollection.doc(request.studentId).get();
  //       userModel.UserModel user = userModel.UserModel.fromSnap(userDocSnapshot);
  //
  //       // Add the class and user data to the list
  //       classesWithUserData.add({
  //         'class': classInfo,
  //         'user': user,
  //       });
  //     }
  //
  //     return classesWithUserData;
  //   } catch (e) {
  //     print('Error fetching classes with user data: $e');
  //     return []; // Return an empty list in case of error
  //   }
  // }

  // Future<void> sendRequest(String teacherId) async {
  //   // Check if the current user is a student
  //   DocumentSnapshot userDoc = await db.collection('users').doc(auth.currentUser!.uid).get();
  //   if (userDoc.exists && userDoc['role'] == 'Student') {
  //     await db.collection('requests').add({
  //       'studentId': auth.currentUser!.uid,
  //       'teacherId': teacherId,
  //       'status': 'pending',
  //     });
  //   } else {
  //     Fluttertoast.showToast(msg: 'Only students can send requests');
  //   }
  // }
  Future<List<Map<String, dynamic>>> fetchPendingRequests() async {
    final teacherId = auth.currentUser!.uid;
    final querySnapshot = await db
        .collection('requests')
        .where('teacherId', isEqualTo: teacherId)
        .where('status', isEqualTo: 'pending')
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List<RequestModel>> fetchRequestsForTeacher(String teacherId) async {
    final CollectionReference requestsCollection =
        FirebaseFirestore.instance.collection('requests');

    // Build the query
    final QuerySnapshot querySnapshot =
        await requestsCollection.where('teacherId', isEqualTo: teacherId).get();
    final List<RequestModel> requests = querySnapshot.docs.map((doc) {
      return RequestModel.fromSnap(doc);
    }).toList();

    return requests;
  }

  Future<void> sendRequest(String teacherId, String className, String classId,
      {query}) async {
    try {
      // Verify if the current user is a student
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (userDoc.exists && userDoc['role'] == 'Student') {
        // Check for any existing pending request for the same student and class
        QuerySnapshot existingRequestQuery = await FirebaseFirestore.instance
            .collection('requests')
            .where('studentId',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('teacherId', isEqualTo: teacherId)
            .where('classId', isEqualTo: classId)
            .where('status', isEqualTo: 'pending')
            .get();

        if (existingRequestQuery.docs.isEmpty) {
          // No existing pending request found, proceed to send a new one
          await FirebaseFirestore.instance.collection('requests').add({
            'studentId': FirebaseAuth.instance.currentUser!.uid,
            'teacherId': teacherId,
            'classId': classId,
            'className': className,
            'query': query,
            'status': 'pending',
          });
          Fluttertoast.showToast(msg: 'Request sent successfully');
        } else {
          Fluttertoast.showToast(
              msg:
                  'You already have a pending request to this teacher for this class');
        }
      } else {
        Fluttertoast.showToast(msg: 'Only students can send requests');
      }
    } catch (e) {
      print('Error sending request: $e');
      Fluttertoast.showToast(
          msg: 'An error occurred while sending the request');
      // Handle the error further as needed
    }
  }

  Future<List<Map<String, dynamic>>> fetchRequestsAndUserDataForTeacher(
      String teacherId) async {
    final CollectionReference requestsCollection =
        FirebaseFirestore.instance.collection('requests');
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Fetch the requests for the teacher
    final QuerySnapshot requestQuerySnapshot =
        await requestsCollection.where('teacherId', isEqualTo: teacherId).get();
    List<Map<String, dynamic>> requestsAndUserData = [];

    for (var doc in requestQuerySnapshot.docs) {
      RequestModel request = RequestModel.fromSnap(doc);

      // Fetch the user data for the student who made the request
      DocumentSnapshot userDocSnapshot =
          await usersCollection.doc(request.studentId).get();
      userModel.UserModel user = userModel.UserModel.fromSnap(userDocSnapshot);
      // Add the request and user data to the list
      requestsAndUserData.add({
        'request': request,
        'user': user,
      });
    }
    return requestsAndUserData;
  }

  Future<List<String>> fetchTeacherIds() async {
    List<String> teacherIds = [];
    try {
      User currentUser = FirebaseAuth.instance.currentUser!;
      var userDoc = await db.collection('users').doc(currentUser.uid).get();
      userModel.UserModel userInfo = userModel.UserModel.fromSnap(userDoc);
      teacherIds = userInfo.teacherIds ?? [];
    } catch (e) {
      print(e.toString());
    }
    return teacherIds;
  }

  Future<void> acceptRequest(
      String requestId, String userId, String classId) async {
    try {
      // Add the userId to the 'classes' collection for the specified class
      CollectionReference classesCollection =
          FirebaseFirestore.instance.collection('classes');
      DocumentReference classDocRef = classesCollection.doc(classId);

      // Use the update method to add the userId to the list of studentIds
      await classDocRef.update({
        'studentIds': FieldValue.arrayUnion([userId])
      });

      // Update the request status to 'accepted' in the 'requests' collection
      CollectionReference requestsCollection =
          FirebaseFirestore.instance.collection('requests');
      DocumentReference requestDocRef = requestsCollection.doc(requestId);
      await requestDocRef.update({'status': 'accepted'});
      // Add any additional logic or UI updates as needed
    } catch (e) {
      print('Error accepting request: $e');
      // Handle the error further as needed
    }
  }

  Future<void> acceptRequestForClass(
      RequestModel request, String classId) async {
    final CollectionReference classesCollection =
        FirebaseFirestore.instance.collection('classes');

    await classesCollection.doc(classId).update({
      'studentIds': FieldValue.arrayUnion([request.studentId])
    });
  }

  Future<void> deleteRequestForClass(String requestID) async {
    final CollectionReference requestsCollection =
        FirebaseFirestore.instance.collection('requests');

    // Delete the request document
    await requestsCollection.doc(requestID).delete();
  }

  Future<List<userModel.UserModel>> getApprovedTeachers() async {
    final users = await db
        .collection('users')
        .where('role', isEqualTo: 'Teacher')
        .where('isApproved', isEqualTo: true)
        .get();
    final teacherList =
        users.docs.map((doc) => userModel.UserModel.fromSnap(doc)).toList();
    return teacherList;
  }

  Future<void> updateStudentData(userModel.UserModel userModel, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users').doc(docId)
          .update({
        'name': userModel.name,
        'email': userModel.email,
        'phoneNumber': userModel.phoneNumber,
      });
      print('Student data updated successfully');

    } catch (error) {
      print('Error updating teacher data: $error');
    }
  }
  Future<void> updateTeacherData(userModel.UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.userId)
          .update({
        'name': userModel.name,
        'email': userModel.email,
        'phoneNumber': userModel.phoneNumber,
        'about': userModel.about,
      });
      print('Teacher data updated successfully');
    } catch (error) {
      print('Error updating teacher data: $error');
    }
  }
  Future<List<userModel.UserModel>> fetchStudentsOfClass(String classId) async {
    try {
      // Get the class document from Firestore
      DocumentSnapshot classDoc = await FirebaseFirestore.instance.collection('classes').doc(classId).get();

      // Get the list of student IDs
      List<String> studentIds = List<String>.from(classDoc['studentIds'] ?? []);

      // Fetch the user data for each student ID
      List<userModel.UserModel> students = [];
      for (String id in studentIds) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(id).get();
        students.add(userModel.UserModel.fromSnap(userDoc));
      }

      return students;
    } catch (e) {
      print('Error fetching students of class: $e');
      return []; // Return an empty list in case of error
    }
  }
  Future<void> removeStudentFromClass(String classId, String studentId) async {
    try {
      // Get the reference to the class document
      DocumentReference classDocRef = FirebaseFirestore.instance.collection('classes').doc(classId);

      // Remove the studentId from the 'studentIds' array
      await classDocRef.update({
        'studentIds': FieldValue.arrayRemove([studentId])
      });

      print('Student removed from class successfully');
    } catch (e) {
      print('Error removing student from class: $e');
    }
  }
}
