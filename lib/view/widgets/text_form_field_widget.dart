import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/primary_field_controller.dart';
import 'package:iquran/res/constants.dart';

class PrimaryTextFormField extends StatefulWidget {
  const PrimaryTextFormField({
    Key? key,
    this.myController,
    required this.hintText,
    required this.keyboardType,
    required this.maxLines,
    required this.onChanged,
    this.onValid,
    this.observe = false,
    this.onSave,
    this.initialValue,
    this.inputFormatters,
  }) : super(key: key);

  final String hintText;
  final TextInputType keyboardType;
  final bool observe;
  final TextEditingController? myController;
  final int maxLines;
  final void Function(String?) onChanged;
  final void Function(String?)? onSave;
  final String? Function(String?)? onValid;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters; // Added inputFormatters property

  @override
  _PrimaryTextFormFieldState createState() => _PrimaryTextFormFieldState();
}

class _PrimaryTextFormFieldState extends State<PrimaryTextFormField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        controller: widget.myController,
        initialValue: widget.initialValue,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        obscureText: widget.observe && !isPasswordVisible,
        decoration: InputDecoration(
          suffixIcon: widget.observe
              ? IconButton(
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            icon: Icon(
              isPasswordVisible
                  ? Icons.visibility_sharp
                  : Icons.visibility_off_sharp,
              color: AppColor.kSecondary,
            ),
          )
              : null,
          hintText: widget.hintText,
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
        onChanged: (value) {
          widget.onChanged(value);
        },
        validator: widget.onValid,
      ),
    );
  }
}
