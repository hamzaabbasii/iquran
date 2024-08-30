import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/controller/class_controller.dart';
import 'package:iquran/model/class_model.dart';
import 'package:iquran/model/user_model.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/student_screens/chat_list_screen.dart';
import 'package:iquran/view/screens/student_screens/student_notification_screen.dart';
import 'package:iquran/view/screens/student_screens/student_teacher_send_request_screen.dart';

class StudentClassDetailsScreen extends StatefulWidget {
  StudentClassDetailsScreen({super.key, required this.seletedClass, required this.image, required this.email, required this.name, required this.about, required this.experience, required this.specialization, required this.teacherId});
  final String image, email, name, about, experience, specialization, teacherId;
  final String seletedClass;

  @override
  State<StudentClassDetailsScreen> createState() => _StudentClassDetailsScreenState();
}

class _StudentClassDetailsScreenState extends State<StudentClassDetailsScreen> {
  final authController = Get.put(AuthController());
  final classController = Get.put(ClassController());
  List<UserModel> userInfo = [];
  List<Map<String, dynamic>> classesByName = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Thi is class Name:" + widget.seletedClass);
    // fetchUser();
  }
  Future<void> fetchClasses() async {
    List<Map<String, dynamic>> result = await ClassController().fetchClassesWithSameName('Tajweed');
    setState(() {
      classesByName = result;
      print("This is class Details:${classesByName.length}");
    });
  }
  // fetchUser() async {
  //   List<UserModel> user = await classController.fetchTeachersForClassName(widget.seletedClass);
  //   setState(() {
  //     userInfo = user;
  //     print('This is User:' + userInfo.toString());
  //   });
  // }
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
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // IconButton(
                    //     onPressed: () {
                    //       _showMyDialog(context);
                    //     },
                    //     icon: Icon(
                    //       Icons.list_alt,
                    //       color: AppColor.kwhite,
                    //       size: 23.spMax,
                    //     )),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, user',
                          style: GoogleFonts.roboto(
                              fontSize: 16.spMax,
                              color: AppColor.kwhite,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Welcome',
                          style: GoogleFonts.roboto(
                              fontSize: 14.spMax,
                              color: AppColor.kwhite,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     IconButton(
                //         onPressed: () {
                //           Get.to(StudentNotificationScreen());
                //         },
                //         icon: Icon(
                //           Icons.notifications_active,
                //           color: AppColor.kwhite,
                //           size: 23.spMax,
                //         )),
                //     IconButton(
                //         onPressed: () {
                //           Get.to(StudentChatListScreen());
                //         },
                //         icon: Icon(
                //           Icons.message_sharp,
                //           color: AppColor.kwhite,
                //           size: 23.spMax,
                //         )),
                //   ],
                // )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 30.w,
            height: 55.h,
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.r)),
                  filled: true,
                  fillColor: AppColor.kbtnColor.withOpacity(0.2),
                  prefix: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search_sharp,
                      size: 28.spMax,
                      color: Colors.black,
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Text(
                  'Class Details',
                  style: GoogleFonts.roboto(
                      fontSize: 20.spMax,
                      color: AppColor.kbtnColor,
                      fontWeight: FontWeight.w500),
                ),
              )),
          FutureBuilder<List<Map<String,dynamic>>>(
              future: classController.fetchClassesWithSameName(widget.seletedClass),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(snapshot.hasError)
                {
                  return const Center(
                    child: Text('Error'),
                  );
                }
                else if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          List<Map<String, dynamic>> classes = snapshot.data!;
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: 10.h, left: 20.w, right: 20.w),
                            child: GestureDetector(
                              onTap: () {
                                //print("this is class id: ${classInfo.id[index]}");
                                // if (teacher.imageName != null &&
                                //     teacher.name != null &&
                                //     teacher.specialization != null &&
                                //     teacher.experience != null &&
                                //     teacher.about != null &&
                                //     teacher.email != null) {
                                  //print("Teacher Id: ${userInfo.teacherIds!}");
                                  Get.to(() => StudentTeacherSendRequestScreen(
                                    image: widget.image,
                                    email: widget.email,
                                    name: widget.name,
                                    about: widget.about,
                                    experience: widget.experience,
                                    specialization:
                                    widget.specialization, teacherId: widget.teacherId, classId: classes[index]['id'], className: classes[index]['name'],
                                  ));
                               // }
                              },
                              child: Container(
                                height: 150.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                      width: 1.w, color: Colors.grey.shade400),
                                ),
                                padding:
                                EdgeInsets.only(left: 20.w, right: 20.w),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height:20.h,),
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Class Name: ',style: GoogleFonts.roboto(
                                            fontSize: 20.spMax,
                                            color: AppColor.kSecondary,
                                            fontWeight: FontWeight.w500),),
                                        Text(classes[index]['name'],style: GoogleFonts.roboto(
                                            fontSize: 20.spMax,
                                            color: AppColor.kPrimary,
                                            fontWeight: FontWeight.w500),),
                                      ],
                                    ),
                                    SizedBox(height:2.h,),
                                    Row(
                                      children: [
                                        Text('Created By:',style: GoogleFonts.roboto(
                                            fontSize: 16.spMax,
                                            color: AppColor.kSecondary,
                                            fontWeight: FontWeight.w500),),
                                        SizedBox(width: 20.w,),

                                        Text(widget.name,style: GoogleFonts.roboto(
                                            fontSize: 16.spMax,
                                            color: AppColor.kSecondary,
                                            fontWeight: FontWeight.w500),),
                                      ],
                                    ),
                                    SizedBox(height:2.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Start Time:  ',style: GoogleFonts.roboto(
                                              fontSize: 14.spMax,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),),
                                          Text(classes[index]['startTime'],style: GoogleFonts.roboto(
                                              fontSize: 14.spMax,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('End Time:  ',style: GoogleFonts.roboto(
                                              fontSize: 14.spMax,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),),
                                          Text(classes[index]['endTime'],style: GoogleFonts.roboto(
                                              fontSize: 14.spMax,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),),
                                        ],
                                      ),
                                    ],
                                  ),
                                    SizedBox(height:2.h,),
                                    Row(
                                      children: [
                                        // Text('Start Date:  ',style: GoogleFonts.roboto(
                                        //     fontSize: 14.spMax,
                                        //     color: Colors.black,
                                        //     fontWeight: FontWeight.w400),),
                                        // Text(classes[index]['classDate'],style: GoogleFonts.roboto(
                                        //     fontSize: 14.spMax,
                                        //     color: Colors.black,
                                        //     fontWeight: FontWeight.w400),),

                                      ],
                                    ),Row(
                                      children: [
                                        Text('Description:  ',style: GoogleFonts.roboto(
                                            fontSize: 14.spMax,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),),
                                        Text(classes[index]['description'],style: GoogleFonts.roboto(
                                            fontSize: 14.spMax,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
                return const Center(
                  child: Text('No Data Found'),
                );
              }),
        ],
      ),
    );
  }

  Widget selectClass(
      BuildContext context, VoidCallback onPressed, String text) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width - 70.w,
        height: 55.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.r),
          border: Border.all(
            color: AppColor.kbtnColor,
            width: 2.w,
          ),
        ),
        child: Center(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                  fontSize: 18.spMax,
                  fontWeight: FontWeight.w500,
                  color: AppColor.kbtnColor),
            )),
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
            dialogButton(context, 'In Progress Classes', () {}),
            SizedBox(
              height: 20.h,
            ),
            dialogButton(context, 'Requested Classes', () {}),
            SizedBox(
              height: 20.h,
            ),
            dialogButton(context, 'Attempted Classes', () {}),
          ],
        );
      },
    );
  }

  Widget dialogButton(BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 20.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColor.kPrimary,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 16.spMax,
                color: AppColor.kwhite),
          ),
        ),
      ),
    );
  }
}
