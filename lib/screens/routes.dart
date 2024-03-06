import 'package:flutter/material.dart';
import 'package:todo_app/screens/login/login_screen.dart';
import 'package:todo_app/screens/on_boarding/on_boarding_screen.dart';
import 'package:todo_app/screens/register/register_screen.dart';
import 'package:todo_app/screens/splash/splash_screen.dart';
import 'package:todo_app/screens/tab/home/add_category.dart';
import 'package:todo_app/screens/tab/home/edit_task.dart';
import 'package:todo_app/screens/tab/home/home_screen.dart';
import 'package:todo_app/screens/tab/tab_box.dart';
import 'package:todo_app/screens/welcome/welcome_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(const SplaashScreen());

      case RouteNames.onBoardingScreen:
        return navigate(const OnBoardingScreen());

      case RouteNames.welcomeScreen:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());

      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case RouteNames.registerScreen:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());

      case RouteNames.tabBox:
        return MaterialPageRoute(builder: (context) => const TabBox());

      case RouteNames.addCategory:
        return MaterialPageRoute(builder: (context) => const AddCategoryScreen());


      default:
        return navigate(const WelcomeScreen());
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splashScreen = "/splash_route";
  static const String addCategory = "/add_route";
  static const String onBoardingScreen = "/onBoarding_route";
  static const String welcomeScreen = "/welcome_route";
  static const String loginScreen = "/login_route";
  static const String homeScreen = "/home_route";
  static const String registerScreen = "/register_route";
  static const String tabBox = "/tab_box_route";
}
