import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/student_screens/chat_list_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_chat_page.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_class_details_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_notification_screen.dart';
class TeacherClassesListScreen extends StatelessWidget {
  const TeacherClassesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            height: 100.h,
            decoration: BoxDecoration(
              color: AppColor.kbtnColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),bottomRight: Radius.circular(15.r)
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      _showMyDialog(context);
                    }, icon: Icon(Icons.list_alt, color: AppColor.kwhite, size: 23.spMax,)),
                    SizedBox(width: 5.w,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hi, user', style: GoogleFonts.roboto(fontSize: 16.spMax, color: AppColor.kwhite, fontWeight: FontWeight.w500),),
                        Text('Student Bio',style: GoogleFonts.roboto(fontSize: 14.spMax, color: AppColor.kwhite, fontWeight: FontWeight.normal),),
                      ],
                    ),
                  ],
                ),
                Row(

                  children: [
                    IconButton(onPressed: (){
                      Get.to(TeacherNotificationScreen(teacherId: '', uid: '',));
                    }, icon: Icon(Icons.notifications_active, color: AppColor.kwhite,size: 23.spMax,)),
                    IconButton(onPressed: (){
                      Get.to(TeacherStudentChatListScreen(teacherId: '',uid: '',));
                    }, icon: Icon(Icons.message_sharp,color: AppColor.kwhite,size: 23.spMax,)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width-30.w,
            height: 55.h,
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.r)
                  ),
                  filled: true,
                  fillColor: AppColor.kbtnColor.withOpacity(0.2),
                  prefix: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search_sharp,
                      size: 28.spMax,
                      color: Colors.black,
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Text('Classes', style: GoogleFonts.roboto(fontSize: 20.spMax, color: AppColor.kbtnColor, fontWeight: FontWeight.w500),),
              )),
          Expanded(
            child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, builder) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
                    child: GestureDetector(
                      onTap: ()
                      {
                        Get.to(ClassDetailsScreen());
                      },
                      child: Container(
                        height: 80.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                              width: 1.w,
                              color: Colors.grey.shade400
                          ),
                        ),
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(radius: 35.r,),
                                    SizedBox(width: 10.w,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Class Name', style: GoogleFonts.roboto(color: AppColor.kbtnColor, fontSize: 20.spMax, ),),
                                        Text('Teacher', style: GoogleFonts.roboto( fontSize: 14.spMax, ),),
                                      ],
                                    ),
                                  ],),
                                Row(children: [
                                  Align(
                                      alignment:Alignment.topRight,
                                      child: Text('In Progress', style: GoogleFonts.roboto(fontSize: 13.spMax, ),)),
                                ],),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),),
        ],
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