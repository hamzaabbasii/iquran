import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/view/screens/teacher_screens/participants_screen.dart';

import '../../../controller/class_controller.dart';
import '../../../model/class_model.dart';
import '../../../res/constants.dart';

class TeacherClassesListScreens extends StatefulWidget {
  const TeacherClassesListScreens({super.key});

  @override
  State<TeacherClassesListScreens> createState() =>
      _TeacherClassesListScreensState();
}

class _TeacherClassesListScreensState extends State<TeacherClassesListScreens> {
  final controller = Get.put(ClassController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Classes',
              style: GoogleFonts.roboto(
                  fontSize: 18.spMax,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<ClassModel>>(
                future: controller.fetchClassInfo(),
                builder: (builder, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              ClassModel classInfo = snapshot.data![index];
                              return GestureDetector(
                                onTap: () async {

                                  if(classInfo.id != null) {
                                    Get.to(()=>Participants(
                                    classId: classInfo.id!, studentIds: classInfo.studentIds!,
                                  ));
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      20.w, 0.h, 20.w, 20.h),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(35.r),
                                      border: Border.all(
                                        color: AppColor.kbtnColor,
                                        width: 2.w,
                                      ),
                                    ),
                                    child: Center(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${classInfo.name}',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18.spMax,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.kbtnColor),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Start Date: ',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14.spMax,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              '${classInfo.classDate}',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14.spMax,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.kbtnColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Start Time: ',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12.spMax,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              '${classInfo.startTime} - ',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12.spMax,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.kbtnColor),
                                            ),
                                            Text(
                                              'End Time: ',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12.spMax,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              '${classInfo.endTime}',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12.spMax,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.kbtnColor),
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
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
