import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wealth_wise/widegts/custom_size_box_widget/custom_sized_box.dart';
import '../../utils/app_color/app_color.dart';
import '../../utils/constant/app_image_constant.dart';
import '../../utils/constant/string_constant.dart';
import '../../utils/fonts/app_fonts.dart';
import '../../widegts/animation/animation.dart';
import '../../widegts/app_button/custum_button.dart';
import '../../widegts/app_text/rich_text_widget.dart';
import '../../widegts/app_text/textwidget.dart';
import '../auth/view/login_screen.dart';
class GetStart extends StatelessWidget {
  const GetStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return SizedBox(
            height: screenHeight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  70.sbh,
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      AppImages.logo,
                      height: screenHeight * 0.14,
                      width: screenWidth * 0.33,
                    ),
                  ),
                  40.sbh,
                  TextWidget(
                    text: MyText.appName,
                    fSize: 45,
                    align: TextAlign.center,
                    fWeight: FontWeights.bold,
                  ),
                  8.sbh,

                  TextWidget(
                    text: MyText.text1,
                    fSize: 16,
                    align: TextAlign.center,
                    fWeight: FontWeights.semiBold,
                  ),
                  40.sbh,

                  CustomElevatedButton(
                    text: MyText.getStart,
                    backgroundColor: AppColors.primaryAppBar,
                    width: screenWidth ,
                    height: screenHeight * 0.058,
                    fontSize: 15.sp,
                    borderRadius: 50,
                    fontWeight: FontWeights.medium,
                    onPressed: () {
                     Get.offAll(LogInScreen());
                    },
                  ),
                  70.sbh,
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: TextWidget(
          text: MyText.text2,
          fSize: 15,
          align: TextAlign.center,
          fWeight: FontWeights.bold,
        ),
      ),
    );
  }

}
