import 'package:camera_functions/login_screen/model/authanitaction_model.dart';
import 'package:camera_functions/signUp/view/signin.dart';
import 'package:camera_functions/styles/app_colors.dart';
import 'package:camera_functions/utils/enums/enum.dart';
import 'package:camera_functions/utils/enums/viewStatus.dart';
import 'package:camera_functions/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ViewState viewState = authController.loginViewStatus.state;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _header(context),
            const SizedBox(
              height: 20,
            ),
            _inputField(context, viewState),
            const SizedBox(
              height: 20,
            ),
            _signup(context),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Login",
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: AppColors.loginMessage,
              fontFamily: "Popins"),
        ),
        Text(
          "Sign in to Continue",
          style: TextStyle(fontSize: 20, color: AppColors.loginMessage),
        ),
      ],
    );
  }

  _inputField(context, ViewState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SizedBox(
          height: 55,
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    )),
                prefixIcon: const Icon(Icons.email)),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 55,
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  )),
              prefixIcon: const Icon(Icons.password),
            ),
            obscureText: true,
          ),
        ),
        SizedBox(height: 50.h),
        Center(
          child: state == ViewState.LOADING
              ? CircularProgressIndicator()
              : CustomButton(
                  width: 150.w,
                  onTap: () {
                    authController.login(
                        emailController.text, passwordController.text);
                  },
                  borderRadius: 20,
                  bgColor: AppColors.loginMessage,
                  borderColor: AppColors.loginMessage,
                  buttonText: "LOGIN",
                  textColor: Colors.white,
                ),
        )
      ],
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignupPage()));
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: AppColors.loginMessage),
            ))
      ],
    );
  }
}
