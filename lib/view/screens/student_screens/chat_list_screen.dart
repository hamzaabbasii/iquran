import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iquran/controller/class_controller.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/student_screens/chat_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_chat_page.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_chat_screen.dart';

class TeacherStudentChatListScreen extends StatefulWidget {
  const TeacherStudentChatListScreen({super.key, required this.teacherId, required this.uid});
  final String teacherId, uid;

  @override
  State<TeacherStudentChatListScreen> createState() => _TeacherStudentChatListScreenState();
}

class _TeacherStudentChatListScreenState extends State<TeacherStudentChatListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  fetchData();
    print('Teacher ID: ${widget.teacherId}');
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
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r)),
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
                      color: AppColor.kwhite,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 70.w,
                ),
                Text(
                  'Chat List',
                  style: GoogleFonts.roboto(
                      fontSize: 16.spMax,
                      color: AppColor.kwhite,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width - 30.w,
          //   height: 55.h,
          //   child: TextFormField(
          //     decoration: InputDecoration(
          //         border: OutlineInputBorder(
          //             borderSide: BorderSide.none,
          //             borderRadius: BorderRadius.circular(10.r)),
          //         filled: true,
          //         fillColor: AppColor.kbtnColor.withOpacity(0.2),
          //         prefix: IconButton(
          //           onPressed: () {},
          //           icon: Icon(
          //             Icons.search_sharp,
          //             size: 28.spMax,
          //             color: Colors.black,
          //           ),
          //         )),
          //   ),
          // ),
          // SizedBox(
          //   height: 20.h,
          // ),
          FutureBuilder<List<Map<String, dynamic>>>(
              future: ClassController().fetchApprovedRequests(widget.teacherId),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(snapshot.hasData)
                  {
                    final approvedRequests = snapshot.data!;
                    print('approvedRequests: $approvedRequests');
                    print('approvedRequests Length: ${approvedRequests.length}');
                    return Expanded(
                      child: ListView.builder(
                          itemCount: approvedRequests.length,
                          itemBuilder: (context, index) {
                            print('approvedRequests: ${approvedRequests.length}');
                            var request = approvedRequests[index]['request'];
                            print('request: ${request['studentId']}');
                            var student = approvedRequests[index]['student'].docs[0].data();
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: GestureDetector(
                                onTap: ()
                                {
                                  print('teacher"""""": ${widget.teacherId}');
                                  print('request"""""""....: ${request['studentId']}');
                                  Get.to(ChatScreen(uid: widget.uid, studentId: request['studentId'],));
                                },
                                child: Container(
                                  height: 90.h,
                                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(radius: 35.r,
                                              backgroundImage: NetworkImage("${student['imageName']}"),),
                                              SizedBox(width: 10.w,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('${student['name']}', style: GoogleFonts.roboto(color: AppColor.kbtnColor, fontSize: 20.spMax, ),),
                                                  Text('${student['role']}', style: GoogleFonts.roboto(color: AppColor.kbtnColor, fontSize: 12.spMax, ),),
                                                ],
                                              ),
                                            ],),
                                          Row(children: [
                                            //Text('10:30 am', style: GoogleFonts.roboto(fontSize: 13.spMax, ),),
                                          ],),
                                        ],
                                      ),
                                      SizedBox(height: 6.h,),
                                      Divider(thickness: 2.w,),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),);
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
