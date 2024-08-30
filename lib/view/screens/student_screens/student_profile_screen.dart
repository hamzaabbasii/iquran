import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/student_screens/edit_student_profile_screen.dart';
import 'package:http/http.dart' as http;

import '../../../model/umodel.dart';
import '../../../model/user_model.dart';

class StudentProfileScreen extends StatefulWidget {

  StudentProfileScreen({super.key, });

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {

  late Future<UserModel> futureUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureUser = fetchUser();
  }
  Future<UserModel> fetchUser()
  async{
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    return UserModel.fromSnap(snapshot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<UserModel>(future: futureUser,builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting)
          {
            return const Center(child: CircularProgressIndicator(),);
          }
        else if(snapshot.hasData)
          {
            UserModel user = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150.h,
                        decoration: BoxDecoration(
                          color: AppColor.kbtnColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15.r),
                              bottomLeft: Radius.circular(15.r)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 35.h,
                            ),
                            Padding(
                                padding:
                                EdgeInsets.only(left: 20.w, right: 20.w),
                                child: Text(
                                  'Profile',
                                  style: GoogleFonts.roboto(
                                      fontSize: 22.spMax,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.kwhite),
                                )),
                            Padding(
                                padding:
                                EdgeInsets.only(left: 20.w, right: 20.w),
                                child: Text(
                                  'Your Information',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16.spMax,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.kwhite),
                                )),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 90.h,
                        child: Container(
                          width: 110.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: NetworkImage('${user.imageName}'),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low),
                          ),
                        ),
                      ),
                    ]),
                SizedBox(
                  height: 50.h,
                ),
                Center(
                    child: Text(
                      '${user.name}',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.spMax,
                          color: AppColor.kbtnColor),
                    )),
                Center(
                    child: Text(
                      '${user.email}',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.spMax,
                          color: Colors.grey),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: GestureDetector(
                            onTap: () {
                               Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditStudentProfileScreen(
                                      docId: user.userId.toString(),
                                      name: user.name.toString(),
                                      email:user.email.toString(),
                                      phoneNumber:user.phoneNumber.toString(),
                                      gender:user.gender.toString(),
                                      imageName:user.imageName.toString(),

                                    )));
                            },
                            child: Text(
                              'Edit',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.spMax,
                                  color: AppColor.kbtnColor),
                            )))),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                  '${user.role }',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.spMax,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                const Divider(),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    '${user.phoneNumber ?? ""} ',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.spMax,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Divider(),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    '${user.gender}',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.spMax,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Divider(),
              ],
            );
          }
        return Center(child: Text('No data found'),);
      }),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
