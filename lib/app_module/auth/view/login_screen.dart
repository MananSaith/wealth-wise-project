
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wealth_wise/app_module/auth/view/sign_up_screen.dart';
import 'package:wealth_wise/widegts/custom_size_box_widget/custom_sized_box.dart';
import '../../../utils/app_color/app_color.dart';
import '../../../utils/constant/app_image_constant.dart';
import '../../../utils/constant/string_constant.dart';
import '../../../utils/fonts/app_fonts.dart';
import '../../../widegts/app_button/custum_button.dart';
import '../../../widegts/app_text/textwidget.dart';
import '../../../widegts/app_text_field/app_text_Field.dart';
import '../controller/auth_controller.dart';
import 'forget_password_screen.dart';

class LogInScreen extends StatelessWidget {
   LogInScreen({super.key});
final  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;
        
            return SizedBox(
              height: screenHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.sbh,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(CupertinoIcons.back),
                          CustomElevatedButton(
                            text: MyText.signUp,
                            backgroundColor: AppColors.primaryAppBar,
                             width: screenWidth * 0.3,
                            height: screenHeight * 0.06,
                            fontSize: 15.sp,
                            borderRadius: 50,
                            fontWeight: FontWeights.semiBold,
                            onPressed: () {
Get.to(()=>SignUpScreen());
                            },
                          ),
                        ],
                      ),

                      Center(
                        child: Image.asset(
                          AppImages.logo,
                          height: screenHeight * 0.2,
                          width: screenWidth * 0.38,

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
                          } else if (!GetUtils.isEmail(value)) {
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
                     Obx(()=> CustomTextField(
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
                      InkWell(
                        onTap: (){
                          Get.to(ForgetPasswordScreen());
                        },
                        child: TextWidget(
                          text: MyText.forgotPassword,
                          fSize: 13,
                          fWeight: FontWeights.semiBold,
                          textColor: AppColors.gray400,
                        ),
                      ),
        20.sbh,
                      CustomElevatedButton(
                        text: MyText.login,
                        backgroundColor: AppColors.primaryAppBar,

                        height: screenHeight * 0.06,
                        fontSize: 17.sp,
                        borderRadius: 50,
                        fontWeight: FontWeights.semiBold,
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.login();
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
      ),
      bottomNavigationBar:Padding(
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
