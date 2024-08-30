
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/widgets/button_widget.dart';

class TeacherInfo extends StatefulWidget {
   TeacherInfo({super.key, required this.image, required this.name, required this.email, required this.about, required this.specialization, required this.experience, required this.cinc});
  String image, name, email, about, specialization, experience, cinc;

  @override
  State<TeacherInfo> createState() => _TeacherInfoState();
}

class _TeacherInfoState extends State<TeacherInfo> {
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
                          bottomRight: Radius.circular(25.r),
                          bottomLeft: Radius.circular(25.r)),
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
                        backgroundColor: Colors.black,
                        radius: 50.r,
                        backgroundImage: NetworkImage(widget.image),
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
                  widget.email,
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
              child: Text(widget.about,style: GoogleFonts.roboto(
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
            const Divider(),
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
            const Divider(),
            Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey, width: 1.sp),
                ),
                child: Image.network(widget.cinc, fit: BoxFit.cover,),
                ),

            SizedBox(height: 20,),
            Center(child: PrimaryButton(text: 'Back', onPress: (){
              Get.back();
            })),
          ],
        ),
      ),
    );
  }
}
