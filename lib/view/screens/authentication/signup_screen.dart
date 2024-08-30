import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/model/user_model.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/select_role_screen.dart';
import 'package:iquran/view/screens/student_screens/set_student_profile_screen.dart';
import 'package:iquran/view/screens/teacher_screens/set_teacher_profile_screen.dart';
import 'package:iquran/view/widgets/button_widget.dart';
import 'package:iquran/view/widgets/text_form_field_widget.dart';
class SignupScreen extends StatefulWidget {
  final String selectedRole;
  const SignupScreen({required this.selectedRole});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final controller = Get.put(AuthController());
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
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
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'assets/logo-one.png',
                  width: 200.w,
                  height: 200.w,
                ),
                Text(
                  'Sign Up',
                  style: GoogleFonts.roboto(
                      fontSize: 22.spMax,
                      color: AppColor.kPrimary,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Create a new account',
                  style: GoogleFonts.roboto(
                      fontSize: 14.spMax,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Form(
                  key: controller.signupFormKey,
                  child: Column(
                    children: [
                      PrimaryTextFormField(
                        myController: controller.nameController,
                        hintText: 'Name',
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                        onValid: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          if(value.length > 20 )
                          {
                            return "Name must be less than 20 characters";
                          }
                          if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
                            return "Special characters are not allowed";
                          }
                          return null;
                        },
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextFormField(
                        myController: controller.emailController,
                        hintText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {},
                        onValid: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          String pattern =
                              r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
                          RegExp regex = RegExp(pattern);

                          if (!regex.hasMatch(value)) {
                            return 'Invalid email format';
                          }
                          return null;
                        },
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextFormField(
                        myController: controller.phoneController,
                        hintText: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {},
                        onValid: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone Number is required";
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return "Invalid Phone Number";
                          }
                          if (value.length < 11) {
                            return "Phone Number must be at least 11 characters";
                          }

                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextFormField(
                        myController: controller.passwordController,
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        maxLines: 1,
                        onChanged: (value) {},
                        observe: true,
                        onValid: (input) {
                          if (input == null || input.isEmpty) {
                            return "Password is required";
                          } else if (input.length <= 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: isVisible ? Container() : const CircularProgressIndicator(), // Control visibility
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryButton(
                        text: 'Sign Up',
                        onPress: () async {
                          if (controller.signupFormKey.currentState!
                              .validate()) {
                            if (widget.selectedRole == 'Student') {
                              print('Phone Number: ${controller.phoneController.text}');
                              Get.to(() => SetStudentProfileScreen(
                                  role: widget.selectedRole, phone: controller.phoneController.text, ));
                            } else {
                              Get.to(() => SetTeacherProfileScreen(
                                  role: widget.selectedRole, phone: controller.phoneController.text,));
                            }
                          }
                          //controller.registerUserWithEmailAndPassword(controller.emailController.text, controller.phoneController.text,);

                          print('Successfull');
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 3.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(()=> RoleScreen());
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.roboto(
                          fontSize: 15.spMax,
                          color: AppColor.kPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
