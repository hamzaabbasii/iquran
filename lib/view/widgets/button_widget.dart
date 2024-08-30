import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/res/constants.dart';
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.text, required this.onPress});
  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: MediaQuery.of(context).size.width - 70.w,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.kbtnColor,
        ),
        child: Text(text, style: GoogleFonts.roboto(fontSize: 16.spMax, color: AppColor.kwhite, fontWeight: FontWeight.w500),),
      ),
    );
  }
}
