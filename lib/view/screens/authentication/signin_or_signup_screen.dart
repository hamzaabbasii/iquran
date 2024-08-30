

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/set_profile_screen.dart';
import 'package:iquran/view/screens/authentication/signin_screen.dart';
import 'package:iquran/view/screens/authentication/signup_screen.dart';
import 'package:iquran/view/widgets/button_widget.dart';

import '../select_role_screen.dart';

class SigninOrSignupScreen extends StatelessWidget {
  const SigninOrSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/logo-one.png'),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'iQuran Connect',
                style: GoogleFonts.lora(
                    fontSize: 22.spMax,
                    color: AppColor.kPrimary,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 80.h,),
              PrimaryButton(text: 'Sign In', onPress: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>RoleScreen()));}),
              SizedBox(height: 20.h,),
              PrimaryButton(text: 'Create New Account', onPress: ()
              {Navigator.push(context, MaterialPageRoute(builder: (context)=> SetProfileScreen()));})
            ],
          ),
        ),
      ),
    );
  }
}
