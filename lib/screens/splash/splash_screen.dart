import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/screens/routes.dart';
import 'package:todo_app/utils/app/app.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';

class SplaashScreen extends StatefulWidget {
  const SplaashScreen({super.key});

  @override
  State<SplaashScreen> createState() => _SplaashScreenState();
}

class _SplaashScreenState extends State<SplaashScreen> {
  void _init() async {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.pushNamed(context, RouteNames.onBoardingScreen);
      },
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.c121212,
      ),
      child: Scaffold(
        body: Center(
          child: Lottie.asset(AppNeseserry.splashLottie),
        ),
      ),
    );
  }
}
