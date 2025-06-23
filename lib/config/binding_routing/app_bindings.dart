import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wealth_wise/app_module/home/controller/top_up_controller.dart';

import '../../app_module/auth/controller/auth_controller.dart';
import '../../app_module/trade/controller/coin_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    debugPrint('========================= AuthBinding =======================');
    Get.lazyPut<AuthController>(() => AuthController());


  }
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    debugPrint('========================= AppBinding =======================');
    Get.put(CoinController());


  }
}
