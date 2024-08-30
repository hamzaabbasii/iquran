import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/model/user_model.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/widgets/button_widget.dart';
import 'package:iquran/view/widgets/text_form_field_widget.dart';

class EditTeacherProfileScreen extends StatefulWidget {
  const EditTeacherProfileScreen({super.key});

  @override
  State<EditTeacherProfileScreen> createState() =>
      _EditTeacherProfileScreenState();
}

class _EditTeacherProfileScreenState extends State<EditTeacherProfileScreen> {
  var genderSelection = "-1";
  var specilaization = "-1";
  var selectExperience = "-1";
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final aboutController = TextEditingController();

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
                    'Edit Teacher Profile',
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
              PrimaryTextFormField(
                myController: nameController,
                  hintText: 'Name',
                  keyboardType: TextInputType.text,
                  onChanged: (va) {},  maxLines: 1, onValid: (input ) {  },),
              SizedBox(
                height: 20.h,
              ),
              PrimaryTextFormField(
                myController: emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.text,
                  onChanged: (va) {}, maxLines: 1,),
              SizedBox(
                height: 20.h,
              ),
              PrimaryTextFormField(
                myController: phoneNumberController,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.text,
                  onChanged: (va) {}, maxLines: 1,),
              SizedBox(
                height: 20.h,
              ),
              PrimaryTextFormField(
                hintText: 'About',
                keyboardType: TextInputType.text,
                onChanged: (va) {},
                maxLines: 3,
              ),
              SizedBox(
                height: 20.h,
              ),
              PrimaryButton(text: 'Submit', onPress: () async{
                UserModel userModel = UserModel(
                  name: nameController.text,
                  email: emailController.text,
                  phoneNumber: phoneNumberController.text,
                  about: aboutController.text,
                );
                await AuthController().updateTeacherData(userModel);
                setState(() {

                });
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
}
