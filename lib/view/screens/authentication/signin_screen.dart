
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/authentication/signup_screen.dart';
import 'package:iquran/view/screens/forgot_password_screen.dart';
import 'package:iquran/view/screens/set_profile_screen.dart';
import 'package:iquran/view/widgets/button_widget.dart';
import 'package:iquran/view/widgets/text_form_field_widget.dart';
class SigninScreen extends StatefulWidget {
  final String role;
  SigninScreen({Key? key, required this.role}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  //List<UserModel> data=[];
  bool isLoading = false;
  bool isVisible = true;
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Sign In',
                  style: GoogleFonts.roboto(
                    fontSize: 22.spMax,
                    color: AppColor.kPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Welcome to Online Quran Teaching',
                  style: GoogleFonts.roboto(
                    fontSize: 14.spMax,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Form(
                  key: controller.signInFormKey,
                  child: Column(
                    children: [
                      PrimaryTextFormField(
                       myController: controller.signInEmailController,
                        hintText: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        onChanged: (value) {},
                        onValid: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9]+$")
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextFormField(
                        myController: controller.signInPasswordController,
                        hintText: "Password",
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        observe: true,
                        onChanged: (value) {},
                        onValid: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: ()
                  {
                    Get.to(ForgotPasswordScreen());
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text('Forgot Password', style: GoogleFonts.poppins(color: AppColor.kPrimary, fontSize: 14.spMax, fontWeight: FontWeight.w500,),),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(child: isVisible == false ?  CircularProgressIndicator(backgroundColor: AppColor.kbtnColor,) : Container()),
                SizedBox(height: 10.h,),
                isLoading
                    ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColor.kPrimary))
                    :PrimaryButton(
                  text: 'Sign In',
                  onPress: () {
                    setState(() {
                      isLoading = false;
                    });
                     if (controller.signInFormKey.currentState!.validate()) {
                       controller.loginWithEmailAndPassword(controller.signInEmailController.text, controller.signInPasswordController.text);
                     };
                    setState(() {
                      isLoading = true;
                      Timer(const Duration(seconds: 5), () {
                          isLoading = false;
                      });
                    });
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 3.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(()=>SetProfileScreen());
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.roboto(
                          fontSize: 15.spMax,
                          color: AppColor.kPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
