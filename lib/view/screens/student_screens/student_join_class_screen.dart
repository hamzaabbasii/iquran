import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/view/screens/student_screens/student_classes_screen.dart';
import 'package:iquran/view/widgets/button_widget.dart';

import '../../../res/constants.dart';

class StudentJoinClassScreen extends StatefulWidget {
  const StudentJoinClassScreen({super.key});

  @override
  State<StudentJoinClassScreen> createState() => _StudentJoinClassScreenState();
}

class _StudentJoinClassScreenState extends State<StudentJoinClassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
              children:[
                SizedBox(height: 50.h,),
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
                      'Class Details',
                      style: GoogleFonts.roboto(
                          fontSize: 22.spMax,
                          color: AppColor.kbtnColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 50.h,),
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
                      Text('Class Name',
                        style: GoogleFonts.roboto(
                            fontSize: 20.spMax,
                            color: AppColor.kbtnColor,
                            fontWeight: FontWeight.w500),),
                      SizedBox(height: 10.h,),
                      Text('Filler text is text that shares some characteristics of a real written text, but is random or otherwise generated. It may be used to display a sample of fonts, generate text for testing, or to spoof an e-mail spam filter.',
                        style: GoogleFonts.roboto(
                            fontSize: 14.spMax,
                            fontWeight: FontWeight.w400),),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                PrimaryButton(text: 'Join Class', onPress: (){
                  Get.to(StudentClassesScreen());
                }),
              ]
          ),
        ),
      ),
    );
  }
}
