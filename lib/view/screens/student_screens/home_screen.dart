import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/model/class_model.dart';
import 'package:iquran/model/user_model.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/student_screens/chat_list_screen.dart';
import 'package:iquran/view/screens/student_screens/student_classes_list_screen.dart';
import 'package:iquran/view/screens/student_screens/student_notification_screen.dart';
import 'package:iquran/view/screens/student_screens/student_teacher_chatlist_screen.dart';
import 'package:iquran/view/screens/student_screens/student_teacher_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/class_controller.dart';

//app bar---------
class StudentHomeScreen extends StatefulWidget {
  String userName;
  StudentHomeScreen({required this.userName});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  final controller = Get.put(ClassController());
  List<Map<String, dynamic>> classesForApprovedRequests = [];
  void fetchClasses() async {
    String studentId = 'fWN5LmSCAba3RHjMnmNOx2SXJZP2'; // Replace with your student id
    classesForApprovedRequests = await ClassController.instance.fetchClassesForApprovedRequests(studentId);
    setState(() {
      print('Classes for approved requests:::::::: $classesForApprovedRequests');
    }); // Call setState to trigger a rebuild of the widget with the fetched data
  }
  @override
  void initState() {
    super.initState();
    fetchClasses();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<UserModel>(
            future: AuthController().fetchUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                UserModel user = snapshot.data!;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
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
                          IconButton(
                              onPressed: () {
                                print('user id: ${user.userId}');
                                _showMyDialog(context, user.userId!);
                              },
                              icon: Icon(
                                Icons.list_alt,
                                color: AppColor.kwhite,
                                size: 23.spMax,
                              )),
                          SizedBox(
                            width: 5.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi' + "," + "${user.name}",
                                style: GoogleFonts.roboto(
                                    fontSize: 16.spMax,
                                    color: AppColor.kwhite,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Welcome to home screen',
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
                                print('Hello');
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             StudentNotificationScreen()));
                              },
                              icon: Icon(
                                Icons.notifications_active,
                                color: AppColor.kwhite,
                                size: 23.spMax,
                              )),
                          IconButton(
                              onPressed: () {
                                if (user.userId != null) {
                                print('User Id: ${user.userId}');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StudentTeacherChatListScreen(
                                              studentId: user.userId!,
                                            )));
                                };
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
                );
              }
              return Text('');
            }),
        SizedBox(
          height: 40.h,
        ),
        Text(
          'Select What you want to learn',
          style: GoogleFonts.roboto(
              fontSize: 18.spMax,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        SizedBox(
          height: 20.h,
        ),
        FutureBuilder<List<ClassModel>>(
            future: controller.fetchUniqueClasses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        ClassModel className = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            print("This is class Id: ${className.id}");
                            if (className.name != null) {
                              Get.to(() => StudentTeacherListScreen(
                                    seletedClass: className.name!,
                                  ));
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
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
                                '${className.name}',
                                style: GoogleFonts.roboto(
                                    fontSize: 18.spMax,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.kbtnColor),
                              )),
                            ),
                          ),
                        );
                      }),
                );
              }
              return const Center(child: Text('No Data Found'));
            })
      ],
    );
  }

  Future<void> _showMyDialog(BuildContext context, String id) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            SizedBox(
              height: 20.h,
            ),
            dialogButton(context, 'Approved Classes', () {
              print('User Id: $id');
              Get.to(ApprovedClassesList(id: id,));
            }),
            SizedBox(
              height: 20.h,
            ),
            dialogButton(context, 'Requested Classes', () {
              // Get.to(ApprovedClassesList());
            }),
            SizedBox(
              height: 20.h,
            ),
            dialogButton(context, 'Attempted Classes', () {
              // Get.to(ApprovedClassesList());
            }),
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
