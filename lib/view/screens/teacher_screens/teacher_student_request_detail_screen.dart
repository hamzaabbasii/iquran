import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/student_screens/chat_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_notification_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_request_screen.dart';
import 'package:iquran/view/widgets/button_widget.dart';

class TeacherStudentRequestDetailsScreen extends StatefulWidget {
  TeacherStudentRequestDetailsScreen({super.key, required this.name, required this.email, required this.image, required this.requestId, required this.className, required this.studentId , required this.teacherId, required this.classId, required this.uid, required this.query});
  final String name, email, image, requestId, className, studentId, teacherId, classId,uid, query;

  @override
  State<TeacherStudentRequestDetailsScreen> createState() => _TeacherStudentRequestDetailsScreenState();
}

class _TeacherStudentRequestDetailsScreenState extends State<TeacherStudentRequestDetailsScreen> {
  @override
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
                  'Student Request',
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
            Container(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 26.h,
                          backgroundImage: NetworkImage(
                            widget.image
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          widget.name,
                          style: GoogleFonts.roboto(
                              fontSize: 16.spMax,
                              fontWeight: FontWeight.w500,
                              color: AppColor.kSecondary),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          widget.email,
                          style: GoogleFonts.roboto(
                              fontSize: 13.spMax,
                              fontWeight: FontWeight.w400,
                              color: AppColor.kSecondary),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap:()
                                {
                                  Get.to(ChatScreen(studentId: widget.studentId, uid: widget.uid));
                                },
                                child: Icon(Icons.message_sharp, color: AppColor.kbtnColor,))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: double.infinity,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                  width: 1.5.w,
                  color: AppColor.kSecondary.withOpacity(0.5),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Class Name',
                      style: GoogleFonts.roboto(
                          fontSize: 16.spMax,
                          fontWeight: FontWeight.w500,
                          color: AppColor.kbtnColor),
                    ),
                    SizedBox(height: 2.h,),
                    Text(
                      widget.className,
                      style: GoogleFonts.roboto(
                          fontSize: 14.spMax,
                          fontWeight: FontWeight.w500,
                          color: AppColor.kSecondary),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Container(
              height: 250.h,
              padding: EdgeInsets.all(10.h),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.kSecondary,
                  width: 1.sp,
                ),
                borderRadius: BorderRadius.circular(15.r),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Student Query',
                    style: GoogleFonts.roboto(
                        fontSize: 16.spMax,
                        color: AppColor.kbtnColor,
                        fontWeight: FontWeight.w500),),
                  SizedBox(height: 10.h,),
                  Text(widget.query,
                    style: GoogleFonts.roboto(
                        fontSize: 14.spMax,
                        fontWeight: FontWeight.w400),),
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Row(
              children: [
                SizedBox(
                    width: 150.w,
                    child: PrimaryButton(text: 'Accept', onPress: (){
                      AuthController().acceptRequest(widget.requestId, widget.studentId, widget.classId);
                      Fluttertoast.showToast(msg: 'Request Accepted Successfully');
                      Navigator.pop(context);
                      setState(() {
                      });
                    })),
                SizedBox(width: 20.w,),
                SizedBox(
                    width: 150.w,
                    child: PrimaryButton(text: 'Delete', onPress: (){
                      AuthController().deleteRequestForClass(widget.requestId);
                      Get.off(()=>TeacherNotificationScreen(teacherId: '', uid: '',));
                    })),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
