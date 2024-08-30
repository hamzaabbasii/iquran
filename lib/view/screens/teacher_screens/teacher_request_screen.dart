import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/res/constants.dart';
class TeacherAcceptRequestReScreen extends StatelessWidget {
  const TeacherAcceptRequestReScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35.h,),
            Row(children: [
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
            ],),
            SizedBox(height: 35.h,),
            Text('Requests', style: GoogleFonts.roboto(fontSize: 18.spMax, fontWeight: FontWeight.w500, color: AppColor.kSecondary),),
            SizedBox(height: 10.h,),
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
                        CircleAvatar(radius: 26.h,),
                      ],),
                    SizedBox(width: 10.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Ali', style: GoogleFonts.roboto(fontSize: 16.spMax, fontWeight: FontWeight.w500, color: AppColor.kSecondary),),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Container(
                              width: 70.h,
                              height: 32.h,
                              decoration: BoxDecoration(
                                color: AppColor.kbtnColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text('Accept', style: GoogleFonts.roboto(color: AppColor.kwhite, fontSize: 15.spMax),),
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
                                child: Text('Decline', style: GoogleFonts.roboto(color: AppColor.kSecondary, fontSize: 15.spMax),),
                              ),
                            ),
                          ],
                        ),
                      ],),
                  ],
                ),
              ),),
            SizedBox(height: 20.h,),
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
                        CircleAvatar(radius: 26.h,),
                      ],),
                    SizedBox(width: 10.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Abdul Rehman', style: GoogleFonts.roboto(fontSize: 16.spMax, fontWeight: FontWeight.w500, color: AppColor.kSecondary),),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Container(
                              width: 70.h,
                              height: 32.h,
                              decoration: BoxDecoration(
                                color: AppColor.kbtnColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text('Accept', style: GoogleFonts.roboto(color: AppColor.kwhite, fontSize: 15.spMax),),
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
                                child: Text('Decline', style: GoogleFonts.roboto(color: AppColor.kSecondary, fontSize: 15.spMax),),
                              ),
                            ),
                          ],
                        ),
                      ],),
                  ],
                ),
              ),),
            SizedBox(height: 20.h,),
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
                        CircleAvatar(radius: 26.h,),
                      ],),
                    SizedBox(width: 10.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Ahmed', style: GoogleFonts.roboto(fontSize: 16.spMax, fontWeight: FontWeight.w500, color: AppColor.kSecondary),),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Container(
                              width: 70.h,
                              height: 32.h,
                              decoration: BoxDecoration(
                                color: AppColor.kbtnColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text('Accept', style: GoogleFonts.roboto(color: AppColor.kwhite, fontSize: 15.spMax),),
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
                                child: Text('Decline', style: GoogleFonts.roboto(color: AppColor.kSecondary, fontSize: 15.spMax),),
                              ),
                            ),
                          ],
                        ),
                      ],),
                  ],
                ),
              ),),

          ],
        ),
      ),
    );
  }
}
