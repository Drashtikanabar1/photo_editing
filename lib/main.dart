import 'package:camera_functions/image_screen/image_view/image_view.dart';

import 'package:camera_functions/signUp/view/sing_up_screen.dart';
import 'package:camera_functions/login_screen/view/login_screen.dart';
import 'package:camera_functions/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AIzaSyA-dGjurm99tlpJkd0hsQv4GWT3_Bq44Nw", // paste your api key here
      appId:
          "1:897340758316:android:9a61d1441a42f90f677489", //paste your app id here
      messagingSenderId: "897340758316", //paste your messagingSenderId here
      projectId: "camerafunction-ab6b5", //paste your project id here
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      minTextAdapt: false,
      splitScreenMode: false,
      designSize: const Size(360, 780),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/splash',
        getPages: [
          GetPage(name: '/splash', page: () => SplashScreen()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/signup', page: () => SignupPage()),
          GetPage(name: '/home', page: () => ImageView()),
        ],
      ),
    );
  }
}
