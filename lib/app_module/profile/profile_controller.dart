import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profileImage = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var name = ''.obs;

  final uid = FirebaseAuth.instance.currentUser?.uid;

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data();
        profileImage.value = data?['profilePhoto'] ?? '';
        email.value = data?['email'] ?? '';
        phone.value = data?['phone'] ?? '';
        name.value = data?['name'] ?? '';
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load profile");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 70);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      await updateUserProfile(base64Image);
      profileImage.value = base64Image;
    }
  }

  Future<void> updateUserProfile(String base64Image) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profilePhoto': base64Image,
      });
      Get.snackbar("Success", "Profile updated");
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile");
    }
  }
}
