
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/controller/class_controller.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/student_screens/student_dashboard.dart';
import 'package:iquran/view/widgets/button_widget.dart';
import 'package:iquran/view/widgets/text_form_field_widget.dart';

class SetStudentProfileScreen extends StatefulWidget {
  String role, phone;
  SetStudentProfileScreen({required this.role, required this.phone});

  @override
  State<SetStudentProfileScreen> createState() =>
      _SetStudentProfileScreenState();
}

class _SetStudentProfileScreenState extends State<SetStudentProfileScreen> {
  final controller = AuthController.instance;
  final classController = Get.put(ClassController());
  var value = "-1";
  String? gender;
  bool isVisible = true;
  File? _image;
  Future<void> _getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
  //File? imagePath;
  //String? imageName;
  //String? imageBytes;

  List<String> genderList = [
    "Male",
    'Female',
  ];
  String _selectedValue = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
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
                    'Set Student Profile',
                    style: GoogleFonts.roboto(
                        fontSize: 22.spMax,
                        color: AppColor.kbtnColor,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 110.h,
                width: 110.w,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : null,
                    ),
                    Positioned(
                      right: 2.h,
                      bottom: 11.h,
                      child: GestureDetector(
                        onTap: () {
                          _showMyDialog(context);
                        },
                        child: Container(
                          height: 25.h,
                          width: 25.h,
                          decoration: BoxDecoration(
                              color: AppColor.kbtnColor,
                              borderRadius: BorderRadius.circular(5.r)),
                          child: const Icon(
                            Icons.edit_sharp,
                            color: AppColor.kwhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.spMax,
                    color: AppColor.kbtnColor),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.spMax,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              PrimaryTextFormField(
                myController: controller.studentRoleController,
                hintText: 'Student',
                keyboardType: TextInputType.text,
                onChanged: (va) {},
                maxLines: 1,
              ),
              SizedBox(
                height: 20.h,
              ),
              // PrimaryTextFormField(myController:emailController,hintText: 'Email', keyboardType: TextInputType.text, onChanged: (va){}, maxLines: 1,),
              DropdownButtonFormField(
                items: controller.gender.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) => controller.changeGender(value!),
                decoration: InputDecoration(
                  hintText: 'Select Gender',
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
                height: 10.h,
              ),
              Center(
                  child: isVisible == false
                      ? CircularProgressIndicator()
                      : Container()),

              SizedBox(
                height: 20.h,
              ),
              PrimaryButton(
                  text: 'Submit',
                  onPress: () {
                    print('Phone Number: ${widget.phone}');
                    //  if(controller.setProfileFormKey.currentState!.validate())
                    //    {
                    File? pdf;
                    File? cnic;
                    controller.createUserWithEmailAndPassword(
                      controller.emailController.text,
                      controller.passwordController.text,
                      controller.nameController.text,
                      classController.classNameController.text,
                      widget.phone,
                      _image!,
                      controller.studentRoleController.text,
                      controller.experienceController.text,
                      controller.aboutController.text,
                      controller.selectedSpecialization.value,
                      controller.selectGender.value,
                      pdf,
                      cnic,

                   );
                   //Get.to(()=>StudentDashboard());
                    //    }
                  }),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
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
            SizedBox(
              height: 20.h,
            ),
            dialogContainer(context, 'Take Photo', () {
              _getImage(ImageSource.camera);
            }, Icons.flip_camera_ios),
            SizedBox(
              height: 20.h,
            ),
            dialogContainer(context, 'Choose Photo', () {
              _getImage(ImageSource.gallery);
            }, Icons.photo_album_outlined),
            SizedBox(
              height: 20.h,
            ),
            PrimaryButton(
                text: 'Ok',
                onPress: () {
                  Navigator.pop(context);
                }),
            SizedBox(
              height: 20.h,
            ),
          ],
        );
      },
    );
  }

  Widget dialogContainer(
      BuildContext context, String text, VoidCallback onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 10.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColor.kbtnColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.spMax,
                    color: AppColor.kwhite),
              ),
              Icon(
                icon,
                color: AppColor.kwhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
