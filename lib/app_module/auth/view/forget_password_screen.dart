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
import '../../../widegts/app_text/textwidget.dart';
import '../../../widegts/app_text_field/app_text_Field.dart';
import '../controller/auth_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return SizedBox(
            height: screenHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: controller.forgetKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    40.sbh,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(onPressed: (){
                        Get.back();
                      }, icon: Icon(Icons.arrow_back_ios)),
                    ),

                    Image.asset(
                      AppImages.logo,
                      height: Get.height * 0.2,
                      width: Get.width * 0.38,

                    ),
                    10.sbh,
                    TextWidget(
                      text: MyText.appName,
                      fSize: 35,
                      align: TextAlign.center,
                      fWeight: FontWeights.bold,
                    ),
                    30.sbh,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextWidget(
                        text: "Email Address",
                        fSize: 17,
                        align: TextAlign.center,
                        fWeight: FontWeights.semiBold,
                        textColor: AppColors.gray400,
                      ),
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
                        } else if (!GetUtils.isEmail(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),

                    20.sbh,
                    CustomElevatedButton(
                      text: "Forget Password",
                      backgroundColor: AppColors.primaryAppBar,

                      height: screenHeight * 0.055,
                      fontSize: 17.sp,
                      borderRadius: 50,
                      fontWeight: FontWeights.semiBold,
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.forgotPassword(); // Call login only if validation passes
                        }
                      },
                    ),


                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
