import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/widgets/button_widget.dart';
import 'package:iquran/view/widgets/text_form_field_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {

  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
                  'Forgot Password',
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
                  'Please enter your email below',
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
                  key: _formKey,
                  child: Column(
                    children: [
                      PrimaryTextFormField(

                        hintText: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        onChanged: (value) {},
                        onValid: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email field cannot be empty";
                          } else if (!RegExp(
                              r"^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9]+$")
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryButton(
                  text: 'Forgot Password',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {

                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
