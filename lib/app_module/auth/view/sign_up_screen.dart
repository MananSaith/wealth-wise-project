import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wealth_wise/widegts/custom_size_box_widget/custom_sized_box.dart';
import '../../../utils/app_color/app_color.dart';
import '../../../utils/constant/app_image_constant.dart';
import '../../../utils/constant/string_constant.dart';
import '../../../utils/fonts/app_fonts.dart';
import '../../../widegts/animation/animation.dart';
import '../../../widegts/app_button/custum_button.dart';
import '../../../widegts/app_text/rich_text_widget.dart';
import '../../../widegts/app_text/textwidget.dart';
import '../../../widegts/app_text_field/app_text_Field.dart';
import '../controller/auth_controller.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: controller.signKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.sbh,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){Get.back();}, icon: Icon(CupertinoIcons.back)
                      ),
                      CustomElevatedButton(
                        text: MyText.login,
                        backgroundColor: AppColors.primaryAppBar,
                        width: Get.width * 0.3,
                        height: Get.height * 0.06,
                        fontSize: 15.sp,
                        borderRadius: 50,
                        fontWeight: FontWeights.semiBold,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),

                  Center(
                    child: Image.asset(
                      AppImages.logo,
                      height: Get.height * 0.2,
                      width: Get.width * 0.38,

                    ),
                  ),
                  10.sbh,
                  Center(
                    child: TextWidget(
                      text: MyText.appName,
                      fSize: 35,
                      align: TextAlign.center,
                      fWeight: FontWeights.bold,
                    ),
                  ),
                  30.sbh,
                  TextWidget(
                    text: "Name",
                    fSize: 17,
                    align: TextAlign.center,
                    fWeight: FontWeights.semiBold,
                    textColor: AppColors.gray400,
                  ),
                  5.sbh,
                  CustomTextField(
                    controller: controller.name,
                    hintText: 'Name',
                    hintColor: AppColors.gray200,
                    borderColor: AppColors.gray200,

                    bgColor: Colors.transparent,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  10.sbh,
                  TextWidget(
                    text: "Email Address",
                    fSize: 17,
                    align: TextAlign.center,
                    fWeight: FontWeights.semiBold,
                    textColor: AppColors.gray400,
                  ),
                  5.sbh,
                  CustomTextField(
                    controller: controller.email,
                    hintText: 'example@gmail.com',
                    hintColor: AppColors.gray200,
                    borderColor: AppColors.gray200,

                    bgColor: Colors.transparent,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!GetUtils.isEmail(value.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  10.sbh,
                  TextWidget(
                    text: "Password",
                    fSize: 17,
                    align: TextAlign.center,
                    fWeight: FontWeights.semiBold,
                    textColor: AppColors.gray400,
                  ),
                  5.sbh,
                Obx(()=>  CustomTextField(
                  controller: controller.password,
                  hintText: 'Enter your password',
                  hintColor: AppColors.gray300,
                  borderColor: AppColors.gray200,
                  obscureText: controller.isVisible.value,
                  bgColor: Colors.transparent,
                  suffixIcon: GestureDetector(
                    onTap: (){
                      controller.isVisible.value = !controller.isVisible.value;
                    },
                    child: Icon(
                      controller.isVisible.value
                          ? CupertinoIcons.eye_slash // Hide icon when visible
                          : CupertinoIcons.eye,      // Show icon when hidden
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),),

                  10.sbh,
                  TextWidget(
                    text: "Phone Number",
                    fSize: 17,
                    align: TextAlign.center,
                    fWeight: FontWeights.semiBold,
                    textColor: AppColors.gray400,
                  ),
                  5.sbh,
                  CustomTextField(
                    controller: controller.phone,
                    hintText: '03XX-XXXXXXX',
                    hintColor: AppColors.gray300,
                    borderColor: AppColors.gray200,
                    bgColor: Colors.transparent,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'phone is required';
                      } else if (value.length != 11 ) {
                        return 'Password must be at 11 digit';
                      }
                      return null;
                    },
                  ),
                  10.sbh,
                  TextWidget(
                    text: "Referral Code (optional)",
                    fSize: 17,
                    align: TextAlign.center,
                    fWeight: FontWeights.semiBold,
                    textColor: AppColors.gray400,
                  ),
                  5.sbh,
                  CustomTextField(
                    controller: controller.refCode,
                    hintText: '54000',
                    hintColor: AppColors.gray300,
                    borderColor: AppColors.gray200,
                    bgColor: Colors.transparent,
                    keyboardType: TextInputType.number,
                  ),


                  20.sbh,
                  CustomElevatedButton(
                    text: MyText.createAccount,
                    backgroundColor: AppColors.primaryAppBar,

                    height: Get.height * 0.06,
                    fontSize: 17.sp,
                    borderRadius: 50,
                    fontWeight: FontWeights.semiBold,
                    onPressed: () {
                      if (controller.signKey.currentState!.validate()) {
                        controller.signUp();
                      }
                    },
                  ),
                  15.sbh,

                ],
              ),
            ),
          )
        ),
      ),
      bottomNavigationBar:Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 10.0,left: 10,right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: AppColors.gray200,
            ),
            TextWidget(
              text: MyText.text2,
              fSize: 15,
              align: TextAlign.center,
              fWeight: FontWeights.bold,
            ),
          ],
        ),
      ),
    );
  }
}
