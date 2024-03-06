import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/routes.dart';
import 'package:todo_app/screens/welcome/widget/global_button.dart';
import 'package:todo_app/screens/welcome/widget/global_page_button.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';
import '../../utils/size/app_size.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String save = "save";

  SharedPreferences? _pref;

  Future<void> _getSharedInstance() async {
    _pref = await SharedPreferences.getInstance();
    if (_pref != null) {
      save = (_pref!.getString(save.toString()) ?? "");
      _pref!.setString("save", "save");
    }
  }

  @override
  void initState() {
    _getSharedInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.c121212,
      ),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.getW()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 57.getH()),
              const GlobalPageButton(),
              SizedBox(height: 57.getH()),
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to UpTodo",
                      style: TextStyle(
                        fontSize: 32.getW(),
                        color: Colors.white.withOpacity(.87),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 26.getH()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.getW()),
                      child: SizedBox(
                        height: 50.getH(),
                        child: Text(
                          "Please login to your account or create new account to continue",
                          style: TextStyle(
                            fontSize: 16.getW(),
                            color: Colors.white.withOpacity(.67),
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GlobalButton(
                text: "Login",
                color: AppColors.c8875FF,
                voidCallback: () {
                  Navigator.pushNamed(context, RouteNames.loginScreen);
                },
              ),
              SizedBox(height: 28.getH()),
              GlobalButton(
                text: "Create account",
                color: AppColors.transparent,
                voidCallback: () {
                  Navigator.pushNamed(context, RouteNames.registerScreen);
                },
              ),
              SizedBox(height: 15.getH()),
            ],
          ),
        ),
      ),
    );
  }
}
