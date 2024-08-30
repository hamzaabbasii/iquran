import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iquran/controller/class_controller.dart';

class TeacherJoinClassScreen extends StatelessWidget {
  const TeacherJoinClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassController>(
      init: ClassController(),
      builder: (controller) => Scaffold(
        body: Stack(
          children: [
            // Center(
            //   child: controller.remoteVideo(),
            // ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 100,
                height: 150,
                child: Center(
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
