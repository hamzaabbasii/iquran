import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/notes_controller.dart';
import 'package:iquran/model/notes_model.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/widgets/button_widget.dart';
import 'package:iquran/view/widgets/text_form_field_widget.dart';

class TeacherNotesScreen extends StatefulWidget {
  TeacherNotesScreen({super.key});

  @override
  State<TeacherNotesScreen> createState() => _TeacherNotesScreenState();
}

class _TeacherNotesScreenState extends State<TeacherNotesScreen> {
  final controller = Get.put(NotesController());

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
                      'Notes',
                      style: GoogleFonts.roboto(
                          fontSize: 20.spMax,
                          color: AppColor.kwhite,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'You can save important notes here',
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: PrimaryTextFormField(
                myController: controller.notesHeadingController,
                hintText: 'Heading',
                keyboardType: TextInputType.text,
                maxLines: 1,
                onChanged: (value) {}),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: PrimaryTextFormField(
                myController: controller.notesDescriptionController,
                hintText: 'Description',
                keyboardType: TextInputType.text,
                maxLines: 3,
                onChanged: (value) {}),
          ),
          SizedBox(
            height: 20.h,
          ),
          PrimaryButton(
              text: 'Save Note',
              onPress: () {
                controller.createNotes(controller.notesHeadingController.text, controller.notesDescriptionController.text).then((_) => {
                  controller.fetchNotesInfo(),
                  setState(() {
                  }),
                });
              }),
          SizedBox(
            height: 5.h,
          ),
          FutureBuilder<List<NotesModel>>(
            future: controller.fetchNotesInfo(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return const Center(child: CircularProgressIndicator(),);
                }
              else if (snapshot.hasData) {
                if(snapshot.data!.isEmpty)
                  {
                    return const Center(child: Text('Empty List'),);
                  }
                else
                  {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            NotesModel notes = snapshot.data![index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Container(
                                width: double.infinity,
                                height: 100.h,
                                padding: EdgeInsets.all(5.h),
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.5.w,
                                      color: AppColor.kSecondary.withOpacity(0.4)),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: ListTile(
                                  title: Text(
                                    '${notes.heading}',
                                    style: GoogleFonts.roboto(
                                        fontSize: 20.spMax,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.kbtnColor),
                                  ),
                                  subtitle: Text(
                                    '${notes.description}',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14.spMax,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );

                  }
              }
              return const Center(
                child: Text('No Data Found'),
              );
            },
          ),
        ],
      ),
    );
  }
}
