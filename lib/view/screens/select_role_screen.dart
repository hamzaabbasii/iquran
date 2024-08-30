
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/authentication/signin_screen.dart';
import 'package:iquran/view/screens/student_screens/set_student_profile_screen.dart';
import 'package:iquran/view/screens/teacher_screens/set_teacher_profile_screen.dart';
import 'package:iquran/view/screens/authentication/signup_screen.dart';
import 'package:iquran/view/widgets/button_widget.dart';

import '../../model/umodel.dart';
import 'admin/home_screen.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({Key? key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  String selectedRole = '';
  //final UserController userController= UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  'Chose the Role',
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
              height: 20.h,
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            for (String role in ['Admin', 'Teacher', 'Student'])
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRole = role;
                  });
                },
                child: Container(
                  height: 50.h,
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: selectedRole == role
                        ? AppColor.kPrimary
                        : AppColor.kwhite,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      role,
                      style: TextStyle(
                        color: selectedRole == role
                            ? AppColor.kwhite
                            : AppColor.kbtnColor,
                        fontSize: 18.spMax,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 270.h,
            ),
            PrimaryButton(
              text: 'Submit',
              onPress: () {
                if(selectedRole == 'Admin' || selectedRole == 'Teacher' || selectedRole == 'Student')
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninScreen(role: selectedRole,)));
                  }
                else
                  {
                    null;
                  }
              },
            ),
          ],
        ),
      ),
    );
  }
}
