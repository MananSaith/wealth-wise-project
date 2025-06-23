import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wealth_wise/app_module/auth/view/login_screen.dart';
import 'package:wealth_wise/app_module/profile/profile_controller.dart';
import 'package:wealth_wise/app_module/profile/term_condition.dart';
import 'package:wealth_wise/utils/app_color/app_color.dart';
import 'package:wealth_wise/utils/fonts/app_fonts.dart';
import 'dart:io' show Platform;
import '../../widegts/app_text/textwidget.dart';
import '../bottom_navigation/navigation_screen.dart';
import '../portfolio/view/withdraw_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    controller.fetchUserProfile();

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(

                    width: Get.width,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAppBar,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Obx(() {
                            final img = controller.profileImage.value;
                            return CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: img.isNotEmpty
                                  ? MemoryImage(base64Decode(img))
                                  : null,
                              child: img.isEmpty
                                  ? const Icon(Icons.person, size: 40)
                                  : null,
                            );
                          }),
                          Positioned(
                            child: GestureDetector(
                              onTap: () => _showImagePickerBottomSheet(context, controller),
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 12,
                                child: const Icon(Icons.edit, color: Colors.white, size: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Obx(()=>TextWidget(
                        text:
                       controller.name.value,
                        fSize: 20,
                        fWeight: FontWeights.bold,
                        textColor: AppColors.white,
                      ),),
                      const SizedBox(height: 5),
                      Obx(()=>TextWidget(
                        text:
                        controller.email.value,
                        fSize: 13,
                        fWeight: FontWeights.semiBold,
                        textColor: AppColors.white,
                      ),),
                      const SizedBox(height: 5),
                      Obx(()=>TextWidget(
                        text:
                        controller.phone.value,
                        fSize: 13,
                        fWeight: FontWeights.medium,
                        textColor: AppColors.white,
                      ),),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

// Menu options list
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: menuItems.length,
                  separatorBuilder: (_, __) => Divider(color: Colors.grey[300]),
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return ListTile(
                      leading: Icon(item.icon, color: Colors.blue),
                      title: Text(item.title, style: TextStyle(fontWeight: FontWeights.medium, fontSize: 16)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => item.onTap(context),

                    );
                  },
                ),



                // Add balance + TopUp Button (your original code)
              ],
            ),
          ),
        );
      }),
    );
  }

  void _showImagePickerBottomSheet(BuildContext context, ProfileController controller) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }
}

final List<_MenuItem> menuItems = [
  _MenuItem(
    title: 'History',
    icon: Icons.history,
    onTap: (BuildContext context) {
      Get.to(()=> WithdrawScreen(uid: FirebaseAuth.instance.currentUser!.uid,));
    },
  ),
  _MenuItem(
    title: 'Account Balance',
    icon: Icons.account_balance_wallet,
    onTap: (BuildContext context) {
      print("33333333333333333333333333333");
      Get.find<NavigationController>().changeTab(0);


    },
  ),
  _MenuItem(
    title: 'Help and Support',
    icon: Icons.help_outline,
    onTap: (BuildContext context) {
      String phoneNumber = "923174689617"; // Replace with your number
      String message = Uri.encodeComponent("wealth Wise! How i can help you");
      _launchUrl("https://wa.me/$phoneNumber?text=$message");
    },
  ),
  _MenuItem(
    title: 'Terms & Conditions',
    icon: Icons.description,
    onTap: (BuildContext context) {
      print("1111111111111111111111111111");
      Get.to(()=> TermsAndConditionsScreen());
      // Add terms screen navigation here
    },
  ),
  _MenuItem(
    title: 'Logout',
    icon: Icons.logout,
    onTap: (BuildContext context) {

      // Schedule showing dialog after the frame ends:
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showLogoutDialog(context);
      });
    },


  ),
];


class _MenuItem {
  final String title;
  final IconData icon;
  final Function(BuildContext context) onTap;  // <-- callback function for tap

  _MenuItem({required this.title, required this.icon, required this.onTap});
}

void _launchUrl(String mail) async {
  if (!await launchUrl(Uri.parse(mail))) throw 'Could not launch $mail';
}




void showLogoutDialog(BuildContext context) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: Text('Yes'),
            isDestructiveAction: true,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
              // Navigate to login screen after logout
              Get.offAll(() => LogInScreen());
            },
          ),
        ],
      ),
    );
  } else {
    // For Android and others
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
              // Navigate to login screen after logout
              Get.offAll(() => LogInScreen());
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}



