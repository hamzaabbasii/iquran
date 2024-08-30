import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/controller/class_controller.dart';
import 'package:iquran/model/class_model.dart';
import 'package:iquran/model/user_model.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/student_screens/chat_list_screen.dart';
import 'package:iquran/view/screens/teacher_screens/checkScreen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_class_list_screens.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_classes_list_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_create_class_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_join_class_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_notification_screen.dart';

class TeacherHomeScreen extends StatefulWidget {
  TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  final controller = Get.put(ClassController());
  Future<List<Map<String, dynamic>>>? _data;
  fetchData() async {
    Future<List<Map<String, dynamic>>>? data;
    data = ClassController().fetchApprovedRequests(
        "a2cbe99963e5c127a694a4de72cc4cb21bdcb7526cfaa4be987d14a97f012b26");
    print("Data: $_data");
    print('Data: ${_data.toString()}');
    setState(() {
      _data = data;
      print("Data:++++++++++++++++++++ $_data");
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void showClassDialog(BuildContext context, String classId, String username) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Class Options'),
          content: Text('Choose an option for the class'),
          actions: <Widget>[
            TextButton(
              child: const Text('Start Class'),
              onPressed: () {
                Get.to(() => checkScreen(
                            room: classId,
                            username: username,
                          ));
              },
            ),
            TextButton(
              child: const Text('Delete Class'),
              onPressed: () async {
                print('classId: $classId');
                await controller.deleteClass(classId);
                Navigator.of(context).pop();
                setState(() {
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserModel>(
          future: AuthController().fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              UserModel user = snapshot.data!;
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: AppColor.kbtnColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.r),
                          bottomRight: Radius.circular(15.r)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi, ${user.name}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16.spMax,
                                      color: AppColor.kwhite,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Welcome to your dashboard',
                                  style: GoogleFonts.roboto(
                                      fontSize: 14.spMax,
                                      color: AppColor.kwhite,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (user.teacherIds != null &&
                                      user.teacherIds!.isNotEmpty &&
                                      user.userId != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TeacherNotificationScreen(
                                                  teacherId:
                                                      user.teacherIds!.first,
                                                  uid: user.userId!,
                                                )));
                                  }
                                },
                                icon: Icon(
                                  Icons.notifications_active,
                                  color: AppColor.kwhite,
                                  size: 23.spMax,
                                )),
                            IconButton(
                                onPressed: () {
                                  print('user.teacherIds: ${user.teacherIds}');
                                  if (user.userId != null &&
                                      user.teacherIds != null &&
                                      user.teacherIds!.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TeacherStudentChatListScreen(
                                                  teacherId:
                                                      user.teacherIds!.first,
                                                  uid: user.userId!,
                                                )));
                                  }
                                },
                                icon: Icon(
                                  Icons.message_sharp,
                                  color: AppColor.kwhite,
                                  size: 23.spMax,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w, top: 10.h),
                    child: GestureDetector(
                      onTap: ()
                        {
                          Get.to(()=>TeacherClassesListScreens());
                        },
                      child: Text('Participants', style: TextStyle(color: AppColor.kPrimary, fontSize: 18.spMax),)
                    ),
                  ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Classes',
                    style: GoogleFonts.roboto(
                        fontSize: 18.spMax,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]),
                  ),
                  FutureBuilder<List<ClassModel>>(
                      future: controller.fetchClassInfo(),
                      builder: (builder, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  ClassModel classInfo = snapshot.data![index];
                                  return GestureDetector(

                                    onTap: () async {
                                    print('classInfo.id: ${classInfo.id}');
                                    print('user.name: ${user.name}');
                                      if (classInfo.id != null) {
                                        showClassDialog(context, classInfo.id!,user.name!);
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          20.w, 0.h, 20.w, 20.h),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 70.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35.r),
                                          border: Border.all(
                                            color: AppColor.kbtnColor,
                                            width: 2.w,
                                          ),
                                        ),
                                        child: Center(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${classInfo.name}',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18.spMax,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.kbtnColor),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Start Date: ',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14.spMax,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  '${classInfo.classDate}',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14.spMax,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColor.kbtnColor),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Start Time: ',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 12.spMax,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  '${classInfo.startTime} - ',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 12.spMax,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColor.kbtnColor),
                                                ),
                                                Text(
                                                  'End Time: ',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 12.spMax,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  '${classInfo.endTime}',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 12.spMax,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColor.kbtnColor),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        }
                        return const Center(
                          child: Text('No Data'),
                        );
                      }),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // selectClass(context, () {
                  //   Get.to(TeacherClassesListScreen());
                  // }, 'Tafsir Quran'),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // selectClass(context, () {
                  //   Get.to(TeacherClassesListScreen());
                  // }, 'Hifzul Quran'),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // selectClass(context, () {}, 'Tajweed Quran'),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // selectClass(context, () {}, 'Learn Quran'),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // selectClass(context, () {}, 'Learn Qaida'),
                ],
              );
            }
            return const Center(
              child: Text('No Data Found'),
            );
          }),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColor.kbtnColor,
        onPressed: () {
          Get.to(() => const CreateClassScreen());
        },
        child: const Icon(
          Icons.add,
          color: AppColor.kwhite,
        ),
      ),
    );
  }

  Widget selectClass(
      BuildContext context, VoidCallback onPressed, String text) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width - 70.w,
        height: 55.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.r),
          border: Border.all(
            color: AppColor.kbtnColor,
            width: 2.w,
          ),
        ),
        child: Center(
            child: Text(
          text,
          style: GoogleFonts.roboto(
              fontSize: 18.spMax,
              fontWeight: FontWeight.w500,
              color: AppColor.kbtnColor),
        )),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            SizedBox(
              height: 20.h,
            ),
            dialogButton(context, 'In Progress Classes', () {}),
            SizedBox(
              height: 20.h,
            ),
            dialogButton(context, 'Requested Classes', () {}),
            SizedBox(
              height: 20.h,
            ),
            dialogButton(context, 'Attempted Classes', () {}),
          ],
        );
      },
    );
  }

  Widget dialogButton(BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 20.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColor.kPrimary,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 16.spMax,
                color: AppColor.kwhite),
          ),
        ),
      ),
    );
  }
}
