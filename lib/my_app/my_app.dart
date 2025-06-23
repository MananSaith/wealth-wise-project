import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../app_module/bottom_navigation/navigation_screen.dart';
import '../app_module/splash/splash_screen.dart';
import '../utils/app_color/app_color.dart';
import '../utils/constant/string_constant.dart';
import 'package:flutter/material.dart';
import '../config/binding_routing/app_bindings.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: MyText.appName,
          theme: ThemeData(
            primaryColor: AppColors.primaryAppBar,
            scaffoldBackgroundColor: AppColors.white,
            useMaterial3: true,
          ),
          initialBinding: AuthBinding(),
          home: SplashScreen(),
        //  home: NavigationScreen(),
        );
      },
    );
  }
}
