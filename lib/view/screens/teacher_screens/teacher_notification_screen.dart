import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/model/request_model.dart';
import 'package:iquran/model/user_model.dart' as userModel;
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_request_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_student_request_detail_screen.dart';

class TeacherNotificationScreen extends StatefulWidget {
  TeacherNotificationScreen({super.key, required this.teacherId, required this.uid});
  String teacherId, uid;

  @override
  State<TeacherNotificationScreen> createState() =>
      _TeacherNotificationScreenState();
}

class _TeacherNotificationScreenState extends State<TeacherNotificationScreen> {
  Future<List<Map<String, dynamic>>>? requestsAndUserData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    requestsAndUserData =
        AuthController().fetchRequestsAndUserDataForTeacher(widget.teacherId);

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35.h,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 25.h,
                    height: 25.h,
                    decoration: BoxDecoration(
                      color: AppColor.kPrimary,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColor.kwhite,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 70.w,
                ),
                Text(
                  'Notifications',
                  style: GoogleFonts.roboto(
                      fontSize: 22.spMax,
                      fontWeight: FontWeight.w500,
                      color: AppColor.kbtnColor),
                ),
              ],
            ),
            SizedBox(
              height: 35.h,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.to(const TeacherAcceptRequestReScreen());
                      },
                      child: Text(
                        'Requests',
                        style: GoogleFonts.roboto(
                            fontSize: 18.spMax,
                            fontWeight: FontWeight.w500,
                            color: AppColor.kSecondary),
                      )),
                  SizedBox(
                    width: 3.w,
                  ),
                  Container(
                    width: 10.h,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: AppColor.kbtnColor,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
                future: requestsAndUserData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }  else if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            RequestModel request =
                                snapshot.data![index]['request'];
                            userModel.UserModel user =
                                snapshot.data![index]['user'];
                            print('Length: ${snapshot.data!.length}');
                            if(request.status != 'accepted') {

                              return Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: Container(
                                width: double.infinity,
                                height: 85.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(
                                    width: 1.5.w,
                                    color: AppColor.kSecondary.withOpacity(0.5),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 26.h,
                                            backgroundImage:
                                                NetworkImage('${user.imageName}'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${user.name}',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16.spMax,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.kSecondary),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () async{
                                                 await AuthController().acceptRequest(request.id, request.studentId, request.classId);
                                                 Fluttertoast.showToast(msg: 'Request Accepted Successfully');
                                                 setState(() {

                                                 });
                                                },
                                                child: Container(
                                                  width: 64.h,
                                                  height: 32.h,
                                                  decoration: BoxDecoration(
                                                    color: AppColor.kbtnColor,
                                                    borderRadius:
                                                        BorderRadius.circular(10.r),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Accept',
                                                      style: GoogleFonts.roboto(
                                                          color: AppColor.kwhite,
                                                          fontSize: 14.spMax),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              GestureDetector(
                                                onTap: () {
                                                  AuthController()
                                                      .deleteRequestForClass(
                                                          request.id);
                                                },
                                                child: Container(
                                                  width: 64.h,
                                                  height: 32.h,
                                                  decoration: BoxDecoration(
                                                    color: AppColor.kwhite,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    border: Border.all(
                                                      width: 1.5.w,
                                                      color: AppColor.kbtnColor,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Decline',
                                                      style: GoogleFonts.roboto(
                                                          color:
                                                              AppColor.kSecondary,
                                                          fontSize: 14.spMax),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ), // Push the existing content to the left
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            if (user.name != null &&
                                                user.email != null &&
                                                user.imageName != null && user.userId != null
                                            && user.userId != null && request.query != null
                                            ) {
                                              print('studentId: ${request.studentId} and teacherId: ${request.teacherId}');
                                              Get.to(

                                                  ()=> TeacherStudentRequestDetailsScreen(
                                                name: user.name!,
                                                email: user.email!,
                                                image: user.imageName!,
                                                    requestId: request.id,
                                                    className: request.className,
                                                    studentId: request.studentId,
                                                    classId: request.classId,
                                                      teacherId: request.teacherId,
                                                    uid: widget.uid,
                                                    query: request.query,
                                              ));
                                            }
                                          },
                                          child: Text(
                                            'View Details',
                                            style: GoogleFonts.roboto(
                                              fontSize: 15.spMax,
                                              color: AppColor
                                                  .kbtnColor, // Example color
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                            }
                          }),
                    );
                  }
                  return const Center(
                    child: Text('No Requests Found'),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
