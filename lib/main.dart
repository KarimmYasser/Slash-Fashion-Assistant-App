// import 'package:fashion_assistant/screens/home_screen.dart';
// import 'package:fashion_assistant/screens/total_screen.dart';
import 'screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fashion_assistant/utils/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const FashionAssistant());
}

class FashionAssistant extends StatelessWidget {
  const FashionAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return GetMaterialApp(
            home: const LoginScreen(),
            theme: SAppTheme.lightTheme,
          );
        });
  }
}
