import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? studentId;
  final String? userId;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final String? className;
  final String? role;
  final String? imageName;
  final String? about;
  final String? experience;
  final String? specialization;
  final String? password;
  final String? docFile;
  final String? cnic;
  final bool? isApproved;
  final List<String>? teacherIds;

    UserModel({
    this.password,
    this.studentId,
    this.userId,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.className,
    this.role,
    this.imageName,
    this.about,
    this.experience,
    this.specialization,
    this.docFile,
    this.cnic,
    this.isApproved,
    this.teacherIds,

  });


  Map<String, dynamic> toJson()
  {
    return{
      'userId': userId,
      'name': name,
      'email': email,
      'gender': gender,
      'className':className,
      'phoneNumber': phoneNumber,
      'role': role,
      'imageName': imageName,
      'about': about,
      'experience': experience,
      'password': password,
      'specialization': specialization,
      'docFile': docFile,
       'cnic': cnic,
      'isApproved': isApproved,
      'teacherIds':teacherIds

    };
  }

  static UserModel fromSnap(DocumentSnapshot snapshot)
  {
    var snapshotData = snapshot.data() as Map<String, dynamic>;
    List<String> teacherIds = [];
    if (snapshotData.containsKey('teacherIds')) {
      teacherIds = (snapshotData['teacherIds'] as List?)?.cast<String>() ?? [];
    }
    return UserModel(
      userId : snapshotData['userId'],
      name : snapshotData['name'],
      email : snapshotData['email'],
      gender : snapshotData['gender'],
      phoneNumber : snapshotData['phoneNumber'],
      role : snapshotData['role'],
      imageName: snapshotData['imageName'],
      about: snapshotData['about'],
      experience: snapshotData['experience'],
      password: snapshotData['password'],
      specialization: snapshotData['specialization'],
      docFile: snapshotData['docFile'],
      cnic: snapshotData['cnic'],
      isApproved: snapshotData['isApproved'],
      teacherIds: teacherIds,
    );
  }
}
