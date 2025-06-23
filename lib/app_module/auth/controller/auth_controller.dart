import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../config/binding_routing/app_bindings.dart';
import '../../../utils/app_color/app_color.dart';
import '../../../widegts/loader/app_loader.dart';
import '../../bottom_navigation/navigation_screen.dart';
import '../../get_start/get_start.dart';
import '../view/login_screen.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController refCode = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  RxBool isVisible=  false.obs;
  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login Function
  Future<void> login() async {
    try {
      if (formKey.currentState!.validate()) {
        // Start a loading indicator or process
        Get.dialog(
          Center(child: customLoader(AppColors.primaryAppBar)),
          barrierDismissible: false,
        );

        // Sign in the user with email and password
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );

        Get.back(); // Close the loading dialog

        // Check if login is successful
        if (userCredential.user != null) {
          Get.snackbar('Success', 'Login successful', snackPosition: SnackPosition.BOTTOM);
          checkLoginStatus();

        }
      }
    } catch (e) {
      Get.back(); // Close the loading dialog
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signUp() async {
    try {
      if (signKey.currentState!.validate()) {
        Get.dialog(
          Center(child: customLoader(AppColors.primaryAppBar)),
          barrierDismissible: false,
        );

        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );

         // Close the loader

        if (userCredential.user != null) {
          await storeUserDataToFirestore(
            uid: userCredential.user!.uid,
            name: name.text.trim(),
            email: email.text.trim(),
            password: password.text.trim(),
            phone: phone.text.trim(),
            referralCode: refCode.text.trim(),
          );
         Get.back();
         email.clear();
         password.clear();
          Get.snackbar('Success', 'Sign-up successful please login', snackPosition: SnackPosition.BOTTOM);
          Get.offAll(LogInScreen());
        }
      }
    } catch (e) {
      Get.back(); // Close the loading dialo
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }





  Future<void> storeUserDataToFirestore({
    required String uid,
    required String name,
    required String email,
    required String password,
    required String phone,
    String? referralCode,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'profile':null,
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'topUpAmount': 0,
        'lastTopUp': null,
        'portfolio': [],
        "withdrawUSDT":[],
        'referralCode': referralCode ?? '',
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to store user data: $e');
    }
  }



  // Forgot Password Function
  Future<void> forgotPassword() async {
    try {
      if (email.text.trim().isEmpty) {
        Get.snackbar('Error', 'Please enter your email', snackPosition: SnackPosition.BOTTOM);
        return;
      }

      Get.dialog(
         Center(child: customLoader(AppColors.primaryAppBar)),
        barrierDismissible: false,
      );

      // Send password reset email
      await _auth.sendPasswordResetEmail(email: email.text.trim());

      Get.back(); // Close the loading dialog
      Get.snackbar('Success', 'Password reset link sent to your email', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.back(); // Close the loading dialog
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void checkLoginStatus() {
    User? user = _auth.currentUser;

    if (user != null) {

      AppBinding().dependencies();
      Get.offAll(() => NavigationScreen());
    } else {

      Get.offAll(GetStart());
    }
  }
}
