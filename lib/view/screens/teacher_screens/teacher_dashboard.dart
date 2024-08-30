import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iquran/controller/auth_controller.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_home_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_notes_screen.dart';
import 'package:iquran/view/screens/teacher_screens/teacher_profile_screen.dart';

class TeacherDashboard extends StatefulWidget {

   const TeacherDashboard({super.key, });

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  int _currentIndex = 0;
  void onTapped(int currentIndex)
  {
    setState(() {
      _currentIndex = currentIndex;
      if(_currentIndex == 3)
        {
          AuthController().logoutUser();
        }
    });
  }


  @override
  Widget build(BuildContext context) {
     List<Widget> listOptions =[
       TeacherHomeScreen(),
       TeacherNotesScreen(),
      TeacherProfileScreen(userId: '',),
      Container(),
    ];
    return Scaffold(
      body: listOptions.elementAt(_currentIndex),
      bottomNavigationBar: Container(
        height: 70.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),topRight: Radius.circular(10.r),),),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: onTapped,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          iconSize: 28.sp,
          backgroundColor: Colors.white,
          fixedColor: AppColor.kPrimary,
          unselectedItemColor: Colors.black,
          selectedFontSize: 15.sp,
          unselectedFontSize: 14.sp,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home_filled, color: Colors.black,),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.note_alt_sharp, color: Colors.black,),label: 'Notes',),
            BottomNavigationBarItem(icon: Icon(Icons.person_2_sharp, color: Colors.black,),label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.logout_rounded, color: Colors.black,),label: 'Logout'),
          ],

        ),
      ),

    );
  }
}
