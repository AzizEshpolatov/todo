import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/screens/login/login_screen.dart';
import 'package:todo_app/screens/routes.dart';
import 'package:todo_app/screens/splash/splash_screen.dart';
import 'package:todo_app/screens/theme/theme.dart';

import 'data_local/storage_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.init();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
      designSize: Size(width, height),
      builder: (context, child) {
        ScreenUtil.init(context);
        return AdaptiveTheme(
          light: AppTheme.lightTheme,
          dark: AppTheme.darkTheme,
          initial: AdaptiveThemeMode.system,
          builder: (theme, darkTheme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              darkTheme: darkTheme,
              home: (StorageRepository.getString(key: "save").isEmpty)
                  ? const SplaashScreen()
                  : const LoginScreen(),
              initialRoute: (StorageRepository.getString(key: "save").isEmpty)
                  ? RouteNames.splashScreen
                  : RouteNames.loginScreen,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          },
        );
      },
    );
  }
}
