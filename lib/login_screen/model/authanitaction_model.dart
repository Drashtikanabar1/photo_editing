import 'package:camera_functions/utils/enums/enum.dart';
import 'package:camera_functions/utils/enums/viewStatus.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  ViewStatus loginViewStatus = ViewStatus(state: ViewState.READY, error: "");
  // Login with email and password
  Future<void> login(String email, String password) async {
    loginViewStatus.state = ViewState.LOADING;
    update();
    try {
      UserCredential? userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Navigate to h
      User? user = userCredential.user;
      if (user != null) {
        loginViewStatus.state = ViewState.READY;
        Get.offAllNamed('/home');
        update();
      }
    } catch (e) {
      loginViewStatus.state = ViewState.ERROR;
      Get.snackbar('Login Failed', e.toString());
    }
  }

  // Signup with email and password
  Future<void> signup(String email, String password, String username) async {
    loginViewStatus.state = ViewState.LOADING;
    try {
      UserCredential? userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // Navigate to home screen after successful signup
      User? user = userCredential.user;
      if (user != null) {
        loginViewStatus.state = ViewState.READY;
        Get.offAllNamed('/home');
      }
    } catch (e) {
      loginViewStatus.state = ViewState.ERROR;
      Get.snackbar('Signup Failed', e.toString());
    }
  }

  // Signout
  Future<void> signOut() async {
    await _auth.signOut();
    // Navigate to login screen after signout
    Get.offAllNamed('/login');
  }
}
