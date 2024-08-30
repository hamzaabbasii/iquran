import 'package:flutter/material.dart';
import 'package:iquran/res/constants.dart';
class TeacherWaitingScreen extends StatelessWidget {
  const TeacherWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(backgroundColor: AppColor.kbtnColor,),
            const SizedBox(height: 10,),
            const Text('Wait until the admin approve your request', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}