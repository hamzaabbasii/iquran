import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iquran/res/constants.dart';
import 'package:iquran/service/notification_class.dart';
import 'package:iquran/view/screens/authentication/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyBui3l8JVVMqKx-cwtbM94-0mACN07c_64',
        appId: '1:830747460506:android:1c53e29342c4dad013f023',
        messagingSenderId: '830747460506',
        projectId: 'iquran-63033',
        storageBucket: "iquran-63033.appspot.com",
    ),
  ):await Firebase.initializeApp();
  await FirebaseApi().initNotification();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColor.kbtnColor),
              useMaterial3: true,
            ),
            // initialRoute: '/',
            // routes: {
            //   '/': (_) => const SplashScreen(),
            //   'signin-or-signup': (_) => SigninOrSignupScreen(),
            //
            // },
            home:  SplashScreen(),
          );
        });
  }
}
