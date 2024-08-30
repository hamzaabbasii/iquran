import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/model/user_model.dart';

import '../../../controller/class_controller.dart';
import '../../../model/class_model.dart';
import '../../../res/constants.dart';

class Participants extends StatefulWidget {
  const Participants({super.key, required this.classId, required this.studentIds});
  final String classId;
  final List<String> studentIds;
  @override
  State<Participants> createState() =>
      _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  final controller = Get.put(ClassController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Classes',
              style: GoogleFonts.roboto(
                  fontSize: 18.spMax,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<List<UserModel>>(
                future: AuthController().fetchStudentsOfClass(widget.classId),
                builder: (builder, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Expanded(
                        child:  ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              UserModel user = snapshot.data![index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: GestureDetector(
                                  onTap: ()
                                  {
                                  },
                                  child: Container(
                                    height: 90.h,
                                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(radius: 35.r,
                                                  backgroundImage: NetworkImage(user.imageName.toString()),),
                                                SizedBox(width: 10.w,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(user.name!, style: GoogleFonts.roboto(color: AppColor.kbtnColor, fontSize: 20.spMax, ),),
                                                    Text(user.role!, style: GoogleFonts.roboto(color: AppColor.kbtnColor, fontSize: 12.spMax, ),),
                                                  ],
                                                ),
                                              ],),
                                            Row(
                                              children: [
                                                IconButton(onPressed: (){
                                                  AuthController().removeStudentFromClass(widget.classId, widget.studentIds[index]);
                                                  setState(() {

                                                  });
                                                }, icon:  const Icon(Icons.delete, color: AppColor.kPrimary,))
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6.h,),
                                        Divider(thickness: 2.w,),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  }
                  return const Center(
                    child: Text('No Data'),
                  );
                }),
            // SizedBox(
            //   height: 20.h,
            // ),
            // selectClass(context, () {
            //   Get.to(TeacherClassesListScreen());
            // }, 'Tafsir Quran'),
            // SizedBox(
            //   height: 20.h,
            // ),
            // selectClass(context, () {
            //   Get.to(TeacherClassesListScreen());
            // }, 'Hifzul Quran'),
            // SizedBox(
            //   height: 20.h,
            // ),
            // selectClass(context, () {}, 'Tajweed Quran'),
            // SizedBox(
            //   height: 20.h,
            // ),
            // selectClass(context, () {}, 'Learn Quran'),
            // SizedBox(
            //   height: 20.h,
            // ),
            // selectClass(context, () {}, 'Learn Qaida'),
          ],
        ),
      ),
    );
  }
}
