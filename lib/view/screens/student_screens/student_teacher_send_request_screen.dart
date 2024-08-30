import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/student_screens/home_screen.dart';
import 'package:iquran/view/screens/student_screens/student_dashboard.dart';
import 'package:iquran/view/widgets/button_widget.dart';
import 'package:iquran/view/widgets/text_form_field_widget.dart';

class StudentTeacherSendRequestScreen extends StatefulWidget {
   StudentTeacherSendRequestScreen({super.key, required this.image, required this.name, required this.email, required this.about, required this.experience, required this.specialization, required this.teacherId, required this.classId, required this.className,
   });
   String image, name, email, about, experience, specialization,classId, className;
   String teacherId;

  @override
  State<StudentTeacherSendRequestScreen> createState() => _StudentTeacherSendRequestScreenState();
}

class _StudentTeacherSendRequestScreenState extends State<StudentTeacherSendRequestScreen> {
  final authController = Get.put(AuthController());
  final query = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
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
                      ],
                    ),
                  ),
                  Positioned(
                      top: 30.h,
                      bottom: -110.h,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.image),
                        backgroundColor: Colors.black,
                        radius: 50.r,
                      )),
                ]),
            SizedBox(
              height: 50.h,
            ),
            Center(
                child: Text(
                  widget.name,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.spMax,
                      color: AppColor.kbtnColor),
                )),
            Center(
                child: Text(
                  widget.email.toString(),
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.spMax,
                      color: Colors.grey),
                )),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'About',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.spMax,
                    color: AppColor.kbtnColor),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Text( widget.about,style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.spMax,
                  color: AppColor.kSecondary),),
            ),
            const Divider(),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Specialization',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.spMax,
                    color: AppColor.kbtnColor),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(widget.specialization,style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.spMax,
                  color: AppColor.kSecondary),),
            ),
            Divider(),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Experience',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.spMax,
                    color: AppColor.kbtnColor),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(widget.experience,style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.spMax,
                  color: AppColor.kSecondary),),
            ),
            Divider(),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: PrimaryTextFormField(
                  myController: query,
                  hintText: 'Any Query (Optional)', keyboardType: TextInputType.text, maxLines: 2, onChanged: (value){}),
            ),
            SizedBox(height: 20,),
            Center(child: PrimaryButton(text: 'Send Request', onPress: (){
              print('Teacher Id: ${widget.teacherId}');
              print('Class Id: ${widget.classId}');
              print('Class Name: ${widget.className}');
                authController.sendRequest(widget.teacherId, widget.className, widget.classId, query: query.text);
                Get.to(()=>StudentDashboard());
            })),
          ],
        ),
      ),
    );
  }
}
