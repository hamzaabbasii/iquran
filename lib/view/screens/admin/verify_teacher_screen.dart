import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/model/class_model.dart';
import 'package:iquran/view/screens/admin/home_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_home_screen.dart';
import 'package:iquran/view/widgets/button_widget.dart';

import '../../../res/constants.dart';
class VerifyTeacherScreen extends StatefulWidget {
  VerifyTeacherScreen({super.key, required this.pdfUrl, required this.userId});
  String pdfUrl, userId;

  @override
  State<VerifyTeacherScreen> createState() => _VerifyTeacherScreenState();
}

class _VerifyTeacherScreenState extends State<VerifyTeacherScreen> {
  final AuthController controller = Get.find();
 PDFDocument? document;
 void initializePdf()
  async
  {
    document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    initializePdf();
  }
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
                  bottomLeft: Radius.circular(15.r),bottomRight: Radius.circular(15.r)
              ),
            ),
            child: Row(
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
                        color: Colors.white,
                        size: 18.sp,
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
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Text('Teacher', style: GoogleFonts.roboto(fontSize: 20.spMax, color: AppColor.kbtnColor, fontWeight: FontWeight.w500),),
              )),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width:double.infinity,
            height: 420.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            color: AppColor.kPrimary,
            child: document != null? PDFViewer(document: document!):const Center(child: CircularProgressIndicator(),),

          ),
          SizedBox(height: 20.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 140.w,
                  child: PrimaryButton(text: 'Accept', onPress: () {
                    controller.approveTeacher(widget.userId);
                    Fluttertoast.showToast(msg: 'Approved', backgroundColor: AppColor.kbtnColor);
                  },),
                ),
                SizedBox(
                  width: 140.w,
                  child: PrimaryButton(text: 'Decline', onPress: () {
                    controller.removeTeacher(widget.userId);
                    Get.to(()=>AdminHomeScreen());
                    Fluttertoast.showToast(msg: 'Successfully removed', backgroundColor: AppColor.kbtnColor);
                  },),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
