import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/model/user_model.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/admin/approved_teacher_screen.dart';
import 'package:iquran/view/screens/admin/teacher_details_screen.dart';
import 'package:iquran/view/screens/admin/verify_teacher_screen.dart';

import '../student_screens/student_teacher_send_request_screen.dart';
class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({super.key});
  final AuthController controller = Get.find();
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
                    SizedBox(width: 5.w,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Admin', style: GoogleFonts.roboto(fontSize: 20.spMax, color: AppColor.kwhite, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Text('Teachers List', style: GoogleFonts.roboto(fontSize: 20.spMax, color: AppColor.kbtnColor, fontWeight: FontWeight.w500),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: GestureDetector(
                    onTap: ()
                    {
                      Get.to(()=>ApprovedTeachersScreen());
                    },
                    child: Text('Approved Teachers', style: GoogleFonts.roboto(fontSize: 16.spMax, color: AppColor.kSecondary, fontWeight: FontWeight.w500),)),
              ),

            ],
          ),
          FutureBuilder<List<UserModel>>(future: controller.getTeachers(), builder: (context, snapshot)
          {
            if(snapshot.connectionState == ConnectionState.waiting)
              {
                return const CircularProgressIndicator();
              }
            if(snapshot.hasData)
              { final teachers = snapshot.data!;
                return  Expanded(
                  child: ListView.builder(
                      itemCount: teachers.length,
                      itemBuilder: (context, index) {
                        UserModel teacher = teachers[index];
                      //if(teacher.isApproved != false)
                          return Padding(
                          padding: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
                          child: GestureDetector(
                            onTap: ()
                            {
                              if(teacher.imageName != null && teacher.name != null && teacher.email != null && teacher.about != null && teacher.specialization != null && teacher.experience != null )
                                {
                                  Get.to(()=>TeacherInfo(image: teacher.imageName!, name: teacher.name!, email: teacher.email!, about: teacher.about!, specialization: teacher.specialization!, experience: teacher.experience!,cinc: teacher.cnic!,));

                                }
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
                                          CircleAvatar(radius: 35.r,backgroundImage:teacher.imageName != null ? NetworkImage(teacher.imageName!):null,),
                                          SizedBox(width: 10.w,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(teacher.name ?? "No Data", style: GoogleFonts.roboto(color: AppColor.kbtnColor, fontSize: 16.spMax, ),),
                                              Text(teacher.specialization ?? "No Data", style: GoogleFonts.roboto( fontSize: 12.spMax, ),),
                                            ],
                                          ),

                                        ],),
                                      ElevatedButton(onPressed: (){
                                        print("Path ->->->-> ${teacher.docFile}");
                                         if(teacher.docFile != null)
                                         {
                                           if(teacher.docFile != null)
                                             {
                                               Get.to(()=>VerifyTeacherScreen(pdfUrl: teacher.docFile!,userId: teacher.userId!,));

                                             }
                                           }

                                         

                                        // else
                                        //   {
                                        //     Fluttertoast.showToast(msg: 'No PDF available.');
                                        //   }
                                        }, child: Text('Verify')),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        //}
                      }),);
              }
            return const Center(child: Text('No DataFound'),);
          }),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          backgroundColor: AppColor.kPrimary,
          onPressed: ()
          {
            AuthController().logoutUser();
           // Get.to(()=>StudentTeacherSendRequestScreen());
          },
          child: Icon(Icons.logout, color: Colors.white,),
        ),
      ),
    );
  }

}