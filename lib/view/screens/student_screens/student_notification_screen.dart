import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/student_screens/student_join_class_screen.dart';
class StudentNotificationScreen extends StatelessWidget {
  const StudentNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  'Notifications',
                  style: GoogleFonts.roboto(
                      fontSize: 22.spMax,
                      color: AppColor.kbtnColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 30.h,),
            Text('Recent', style: GoogleFonts.roboto(fontSize: 18.spMax, fontWeight: FontWeight.w500, color: AppColor.kSecondary),),
            SizedBox(height: 5.h,),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('The new class has been created', style: GoogleFonts.roboto(fontSize: 16.spMax, fontWeight: FontWeight.w500, color: AppColor.kSecondary),),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            GestureDetector(
                              onTap:(){
                               Get.to(StudentJoinClassScreen());
                            },
                              child: Container(
                                width: 70.h,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: AppColor.kbtnColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: Text('Join', style: GoogleFonts.roboto(color: AppColor.kwhite, fontSize: 15.spMax),),
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Container(
                              width: 70.h,
                              height: 32.h,
                              decoration: BoxDecoration(
                                color: AppColor.kwhite,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  width: 1.5.w,
                                  color: AppColor.kbtnColor,
                                ),
                              ),
                              child: Center(
                                child: Text('Not Now', style: GoogleFonts.roboto(color: AppColor.kSecondary, fontSize: 15.spMax),),
                              ),
                            ),
                          ],
                        ),
                      ],),
                  ],
                ),
              ),),
            SizedBox(height: 20.h,),
            Expanded(

              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (builder,context)
              {
                return Container(
                  width: double.infinity,
                  height: 85.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),

                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(radius: 26.h,),
                              ],),
                            SizedBox(width: 10.w,),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Username enrolled in the class\n accpted', style: GoogleFonts.roboto(fontSize: 14.spMax, color: AppColor.kSecondary),),
                                    Text('2 days ago', style: GoogleFonts.roboto(color: AppColor.kbtnColor, fontWeight: FontWeight.w500, fontSize: 12.spMax),),
                                  ],),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Divider(),
                      ],
                    ),
                  ),);
              }),
            )
          ],
        ),
      ),
    );
  }
}
