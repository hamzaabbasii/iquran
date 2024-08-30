import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/model/user_model.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/student_screens/student_dashboard.dart';
import 'package:iquran/view/widgets/button_widget.dart';
import 'package:iquran/view/widgets/text_form_field_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
class  EditStudentProfileScreen extends StatefulWidget {
  String  docId, name,email,phoneNumber,gender,imageName;
  EditStudentProfileScreen({required this.docId,required this.name,required this.email,required this.phoneNumber,required this.gender,required this.imageName});

  @override
  State< EditStudentProfileScreen> createState() => _SetStudentProfileScreenState();
}

class _SetStudentProfileScreenState extends State<EditStudentProfileScreen> {
  var value = "-1";
  File ? _isSelected;
  Rx<File> imagePath=File('').obs;

  String ? gender;

  List<String> genderList = [
    "Male",
    'Female',
  ];
  String _selectedValue = "Male";


  @override
  Widget build(BuildContext context) {
    TextEditingController nameController=TextEditingController(text:widget.name.toString());
    TextEditingController emailController=TextEditingController(text:widget.email.toString());
    TextEditingController phoneNumberController=TextEditingController(text:widget.phoneNumber.toString());
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
              SizedBox(height: 50.h,),
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
              SizedBox(height: 20.h,),
              // SizedBox(
              //   height: 110.h,
              //   width: 110.w,
              //   child: Stack(
              //     fit: StackFit.expand,
              //     clipBehavior: Clip.none,
              //     children: [
              //       CircleAvatar(
              //         backgroundImage: _isSelected != null ? FileImage(_isSelected!):null,
              //       ),
              //
              //       Positioned(
              //         right: 2.h,
              //         bottom: 11.h,
              //         child: GestureDetector(
              //           onTap: (){
              //             _showMyDialog(context);
              //           },
              //           child: Container(
              //             height: 25.h,
              //             width: 25.h,
              //             decoration: BoxDecoration(
              //                 color: AppColor.kbtnColor,
              //                 borderRadius: BorderRadius.circular(5.r)
              //
              //             ),
              //             child: Icon(Icons.edit_sharp, color: AppColor.kwhite,),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              SizedBox(height: 20.h,),
              PrimaryTextFormField(myController:nameController,hintText: 'Name', keyboardType: TextInputType.text, onChanged: (va){}, maxLines: 1,),
              SizedBox(height: 20.h,),
              PrimaryTextFormField(myController:emailController,hintText: 'Email', keyboardType: TextInputType.text, onChanged: (va){}, maxLines: 1,),
              SizedBox(height: 20.h,),
              PrimaryTextFormField(myController:phoneNumberController,hintText: 'Phone Number', keyboardType: TextInputType.text, onChanged: (va){}, maxLines: 1,),
              SizedBox(height: 20.h,),

              SizedBox(height: 20.h,),
              PrimaryButton(text: 'Submit', onPress: ()async{
                 UserModel user=UserModel(

                   name: nameController.text,
                   email: emailController.text,
                  phoneNumber: phoneNumberController.text,

                 );
                await AuthController().updateStudentData(user, widget.docId);
              }),
              SizedBox(height: 20.h,),
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
            SizedBox(height: 20.h,),
            SizedBox(height: 20.h,),
            dialogContainer(context, 'Take Photo', () {
              _pickImageFromCamera();
            }, Icons.flip_camera_ios),
            SizedBox(height: 20.h,),
            dialogContainer(context, 'Choose Photo', () {
              _pickImageFromGallery();
            }, Icons.photo_album_outlined),
            SizedBox(height: 20.h,),
            dialogContainer(context, 'Ok', () {
              Navigator.pop(context);
            }, Icons.delete_outline_outlined),
            SizedBox(height: 20.h,),
          ],
        );
      },
    );
  }
  Widget dialogContainer(BuildContext context, String text, VoidCallback onTap, IconData icon)
  {
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
              Text(text, style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16.spMax, color: AppColor.kwhite),),
              Icon(icon, color: AppColor.kwhite,),
            ],
          ),
        ),
      ),
    );
  }
  Future _pickImageFromCamera()
  async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _isSelected = File(returnedImage!.path);
      final imageTemp=File(returnedImage!.path);
      imagePath.value=imageTemp;
      print(imageTemp.path.toString());
    });
  }




  Future  _pickImageFromGallery()async{

    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _isSelected = File(returnedImage!.path);
      final imageTemp=File(returnedImage!.path);
      imagePath.value=imageTemp;
      print(imageTemp.path.toString());
    });
  }

}
