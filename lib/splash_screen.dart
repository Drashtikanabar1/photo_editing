import 'dart:async';

import 'package:camera_functions/image_screen/image_view/image_view.dart';

import 'package:camera_functions/login_screen/view/login_screen.dart';
import 'package:camera_functions/utils/enums/enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      //
      FirebaseAuth.instance.authStateChanges().listen((event) {
        if (event != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ImageView(),
              ));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/icons/app_photo_icon.png",
            height: 400.h,
            ),
      ),
    );
  }
}
