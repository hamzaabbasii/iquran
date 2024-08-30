import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/controller/class_controller.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_dashboard.dart';
import 'package:iquran/view/widgets/button_widget.dart';
import 'package:iquran/view/widgets/text_form_field_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SetTeacherProfileScreen extends StatefulWidget {
  String role, phone;
  SetTeacherProfileScreen({super.key, required this.role, required this.phone});

  @override
  State<SetTeacherProfileScreen> createState() =>
      _SetTeacherProfileScreenState();
}

class _SetTeacherProfileScreenState extends State<SetTeacherProfileScreen> {
  final controller = AuthController.instance;
  bool isVisible = true;
  File? _image;
  File? cnic;
  File? pickPdf;

  final classController = Get.put(ClassController());

  Future<void> _getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
  Future<void> _getCnic(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        cnic = File(image.path);
      });
    }
  }
 // FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  String? _audioPath;

  @override
  void initState() {
    super.initState();
   // _audioRecorder = FlutterSoundRecorder();
  }

  @override
  void dispose() {
   // _audioRecorder?.closeRecorder();
    super.dispose();
  }


  Future<void> _requestMicrophonePermission() async {
    var status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      // Permission denied - show a message or open app settings
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone Permission Required'))
      ); // Or redirect to app settings to enable permission
    }
  }

  // Future<void> _openAudioRecorder() async {
  //   await _requestMicrophonePermission();
  //   // Get a temporary directory
  //   final tempDir = await getTemporaryDirectory();
  //   final path = '${tempDir.path}/audio_recording.aac';
  //
  //   // If recorder is already open, we can't start recording again
  //   if (!_audioRecorder!.isRecording) {
  //     await _audioRecorder!.openRecorder();
  //     await _audioRecorder!.startRecorder(toFile: path);
  //     setState(() {
  //       _isRecording = true;
  //       _audioPath = path;
  //     });
  //   }
  // }

  // Future<void> _stopAudioRecorder() async {
  //   await _audioRecorder!.stopRecorder();
  //   setState(() {
  //     _isRecording = false;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Form(
            key: controller.setProfileFormKey,
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
                      width: 50.w,
                    ),
                    Text(
                      'Set Teacher Profile',
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
                  height: 110.h,
                  width: 110.w,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : null,
                      ),
                      Positioned(
                        right: 2.h,
                        bottom: 11.h,
                        child: GestureDetector(
                          onTap: () {
                            _showMyDialog(context);
                          },
                          child: Container(
                            height: 25.h,
                            width: 25.h,
                            decoration: BoxDecoration(
                                color: AppColor.kbtnColor,
                                borderRadius: BorderRadius.circular(5.r)),
                            child: const Icon(
                              Icons.edit_sharp,
                              color: AppColor.kwhite,
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
                SizedBox(
                  height: 20.h,
                ),
                Row( // Audio recorder controls
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IconButton(
                    //   iconSize: 40,
                    //   icon: Icon( _isRecording ? Icons.stop : Icons.mic),
                    //   onPressed: _isRecording ? _stopAudioRecorder : _openAudioRecorder,
                    // ),
                    // SizedBox(width: 20),
                    // Visibility(
                    //   visible: _audioPath != null,
                    //   child: IconButton(
                    //     iconSize: 40,
                    //     icon: Icon(Icons.play_arrow),
                    //     onPressed: () async {
                    //       await FlutterSoundPlayer().startPlayer(
                    //         fromURI: _audioPath,
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryTextFormField(
                  myController: controller.teacherRoleController,
                  hintText: 'Role',
                  //initialValue: widget.role,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    widget.role = value!;
                  },
                  onSave: (value) {
                    widget.role = value!;
                  },
                  onValid: (value) {
                    if (value == null || value.isEmpty) {
                      return "Role field cannot be empty";
                    }
                    return null;
                  },
                  maxLines: 1,
                ),
                SizedBox(
                  height: 20.h,
                ),
                DropdownButtonFormField(
                  items: controller.gender.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) => controller.changeGender(value!),
                  decoration: InputDecoration(
                    hintText: 'Select Gender',
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
                ),
                SizedBox(
                  height: 20.h,
                ),
                DropdownButtonFormField(
                  items: controller.specialization.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) => controller.selectSpecialization(value!),
                  decoration: InputDecoration(
                    hintText: 'Specialization',
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
                ),
                SizedBox(
                  height: 20.h,
                ),
                DropdownButtonFormField(
                  items: controller.experience.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) => controller.selectExperience(value!),
                  decoration: InputDecoration(
                    hintText: 'Experience in Years',
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
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  height: 150.h,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.grey, width: 1.sp),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => {
                        // Show options for image source - camera or gallery
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text('Camera'),
                                onTap: () => _getCnic(ImageSource.camera),
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo),
                                title: const Text('Gallery'),
                                onTap: () => _getCnic(ImageSource.gallery),
                              ),
                            ],
                          ),
                        ),
                      },
                      child: cnic != null ? Image.file(cnic!, fit: BoxFit.cover,):Text('Front Side of CNIC', style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.spMax,
                        color: Colors.black),
                      ),
                    ),
                  )
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryTextFormField(
                  myController: controller.aboutController,
                  hintText: 'About',
                  keyboardType: TextInputType.text,
                  onChanged: (va) {},
                  onValid: (value) {
                    if (value == null || value.isEmpty) {
                      return "About section cannot be empty";
                    } else if (value.length <= 30) {
                      return "Minimum thirty characters required";
                    }
                    return null;
                  },
                  maxLines: 3,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          final pickedFile = FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );
                          if(pickedFile != null)
                            {
                              pickPdf = File((await pickedFile)!.files.single.path!);
                              setState(() {
                                print('picked file: $pickPdf');
                              });
                            }
                        },
                        child: Text('Upload Document')),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text('This is the document File'),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryButton(
                    text: 'Submit',
                    onPress: () async {
                      if (controller.setProfileFormKey.currentState!
                          .validate()) {
                        controller.createUserWithEmailAndPassword(
                          controller.emailController.text,
                          controller.passwordController.text,
                          controller.nameController.text,
                          classController.classNameController.text,
                          widget.phone,
                          _image!,
                          widget.role,
                          controller.selectExperience.value,
                          controller.aboutController.text,
                          controller.selectedSpecialization.value,
                          controller.selectGender.value,
                          cnic,
                          pickPdf,
                        );
                      }
                    }),
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

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            dialogContainer(context, 'Take Photo', ()=>_getImage(ImageSource.camera), Icons.flip_camera_ios),
            SizedBox(
              height: 20.h,
            ),
            dialogContainer(context, 'Choose Photo', ()=>_getImage(ImageSource.gallery), Icons.photo_album_outlined),
            SizedBox(
              height: 20.h,
            ),
            PrimaryButton(
                text: 'Ok',
                onPress: () {
                  Navigator.pop(context);
                }),
            SizedBox(
              height: 20.h,
            ),
          ],
        );
      },
    );
  }

  Widget dialogContainer(
      BuildContext context, String text, VoidCallback onTap, IconData icon) {
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
              Text(
                text,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.spMax,
                    color: AppColor.kwhite),
              ),
              Icon(
                icon,
                color: AppColor.kwhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
