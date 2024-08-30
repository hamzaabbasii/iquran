import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/widgets/button_widget.dart';

class StudentClassesScreen extends StatelessWidget {
  const StudentClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            height: 120.h,
            decoration: BoxDecoration(
              color: AppColor.kbtnColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Class Name',
                      style: GoogleFonts.roboto(
                          fontSize: 20.spMax,
                          color: AppColor.kwhite,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 2.h,),
                    Text(
                      'Teacher Name',
                      style: GoogleFonts.roboto(
                          fontSize: 16.spMax,
                          color: AppColor.kwhite,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
            
            ),
                itemCount: 50,
                itemBuilder: (context, index)
            {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 63.h,
                      width: 67.h,
                      decoration: BoxDecoration(
                        color: AppColor.kbtnColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    Expanded(
                      child: Text('Student',  style: GoogleFonts.roboto(
                          fontSize: 14.spMax,
                          fontWeight: FontWeight.normal),),
                    ),
                  ],
                ),
              );
            }),
          ),
          Container(
            height: 80.h,
            width: double.infinity,
            color: AppColor.kbtnColor.withOpacity(0.2),
            child: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.mic),
                      Text('Mute',  style: GoogleFonts.roboto(
                        fontSize: 14.spMax,
                          fontWeight: FontWeight.w500),),
                  ],),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.videocam_off),
                      Text('Stop Video',  style: GoogleFonts.roboto(
                          fontSize: 14.spMax,
                          fontWeight: FontWeight.w500),),
                    ],),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.spatial_audio_off_outlined),
                      Text('Speaker',  style: GoogleFonts.roboto(
                          fontSize: 14.spMax,
                          fontWeight: FontWeight.w500),),
                    ],),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.ios_share_sharp),
                      Text('Leave Class',  style: GoogleFonts.roboto(
                          fontSize: 16.spMax,
                          fontWeight: FontWeight.w500),),
                    ],),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
