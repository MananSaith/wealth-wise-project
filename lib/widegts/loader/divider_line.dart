

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/padding/app_paddings.dart';
import '../app_text/app_text.dart';

dividerLine() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: Get.width * 0.3,
        child: const Divider(
          height: 5,
        ),
      ),
      Padding(
        padding: AppPaddings.horizontal10,
        child: AppText(
          text: "or".tr,
        ),
      ),
      SizedBox(
        width: Get.width * 0.3,
        child: const Divider(
          height: 5,
        ),
      ),
    ],
  );
}
