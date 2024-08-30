import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iquran/controller/class_controller.dart';
import 'package:iquran/model/class_model.dart';
import 'package:iquran/view/screens/student_screens/student_classes_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_dashboard.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_home_screen.dart';
import 'package:iquran/view/widgets/button_widget.dart';
import 'package:iquran/view/widgets/text_form_field_widget.dart';

import '../../../controller/auth_controller.dart';
import '../../../res/constants.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({super.key});

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final controller = Get.put(ClassController());
  final authController = Get.put(AuthController());
  void _validateAndCreateClass() async {
    if (controller.startTimeController.text.isEmpty ||
        controller.endTimeController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please select both start and end time');
      return;
    }

    final startTime = TimeOfDay.fromDateTime(DateFormat.jm().parse(controller.startTimeController.text));
    final endTime = TimeOfDay.fromDateTime(DateFormat.jm().parse(controller.endTimeController.text));


    if (endTime.hour < startTime.hour ||
        (endTime.hour == startTime.hour && endTime.minute <= startTime.minute)) {
      Fluttertoast.showToast(msg: 'End time must be after start time');
    } else {
      // Times are valid, proceed with creating the class
      List<String> teacherIds = await authController.fetchTeacherIds();
      controller.createNewClass(
          controller.selectedClass.value,
          controller.dateController.text,
          controller.startTimeController.text,
          controller.endTimeController.text,
          controller.descriptionController.text,
          teacherIds
      );
      Fluttertoast.showToast(msg: 'Class Successfully Created', backgroundColor: AppColor.kPrimary);
      Get.to(() => TeacherDashboard());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(children: [
            SizedBox(
              height: 50.h,
            ),
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
                  'Create Class',
                  style: GoogleFonts.roboto(
                      fontSize: 22.spMax,
                      color: AppColor.kbtnColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            DropdownButtonFormField(
              items: controller.classNames.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) => controller.selectedClass(value!),
              decoration: InputDecoration(
                hintText: 'Class Name',
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                fillColor: AppColor.ktextField.withOpacity(0.7),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    color: AppColor.kSecondary,
                    width: 1.sp,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    color: AppColor.kSecondary,
                    width: 1.sp,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    color: AppColor.kSecondary,
                    width: 1.sp,
                  ),
                ),
              ),
            ),
            // PrimaryTextFormField(
            //     myController:controller.classNameController,hintText: 'Class Name', keyboardType: TextInputType.text, maxLines: 1, onChanged: (value)
            // {
            //
            // }),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              controller: controller.dateController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Select Date',
                suffixIcon: IconButton(
                  onPressed: () async {
                    final DateTime ?_dateTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2025).add(Duration(days: 365)),
                    );
                    final formattedDate = DateFormat("dd-MM-yyyy").format(_dateTime!);
                    setState(() {
                      controller.dateController.text = formattedDate.toString();
                    });
                    print(_dateTime);
                  },
                  icon: Icon(Icons.calendar_month),
                ),
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                fillColor: AppColor.ktextField.withOpacity(0.7),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    color: AppColor.kSecondary,
                    width: 1.sp,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    color: AppColor.kSecondary,
                    width: 1.sp,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    color: AppColor.kSecondary,
                    width: 1.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              controller: controller.startTimeController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Start Time',
                suffixIcon: IconButton(
                  onPressed: () async {
                    TimeOfDay? _time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {
                      controller.startTimeController.text = _time!.format(context);
                    });
                  },
                  icon: Icon(Icons.access_time),
                ),
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                fillColor: AppColor.ktextField.withOpacity(0.7),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    color: AppColor.kSecondary,
                    width: 1.sp,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    color: AppColor.kSecondary,
                    width: 1.sp,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    color: AppColor.kSecondary,
                    width: 1.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              controller: controller.endTimeController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'End Time',
                suffixIcon: IconButton(
                  onPressed: () async {
                    TimeOfDay? _time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {
                      controller.endTimeController.text = _time!.format(context);
                    });
                  },
                  icon: Icon(Icons.access_time),
                ),
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                fillColor: AppColor.ktextField.withOpacity(0.7),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    color: AppColor.kSecondary,
                    width: 1.sp,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    color: AppColor.kSecondary,
                    width: 1.sp,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    color: AppColor.kSecondary,
                    width: 1.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            PrimaryTextFormField(
                myController: controller.descriptionController,
                hintText: 'Description',
                keyboardType: TextInputType.text,
                maxLines: 4,
                onChanged: (value) {}),
            SizedBox(
              height: 20.h,
            ),

            SizedBox(height: 20.h),
            PrimaryButton(
                text: 'Create Now',
                onPress: () async {
                  List<String> teacherIds =
                      await authController.fetchTeacherIds();
                  controller.createNewClass(
                      controller.selectedClass.value,
                      controller.dateController.text,
                      controller.startTimeController.text,
                      controller.endTimeController.text,
                      controller.descriptionController.text,
                      teacherIds
                  );
                  Get.to(() => TeacherDashboard());
                }),
            SizedBox(height: 20.h),
          ]),
        ),
      ),
    );
  }
}
