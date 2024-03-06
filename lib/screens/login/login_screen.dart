import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/data_local/storage_repository.dart';
import 'package:todo_app/screens/login/widgets/global_button.dart';
import 'package:todo_app/screens/login/widgets/global_textformfield.dart';
import 'package:todo_app/screens/routes.dart';
import 'package:todo_app/utils/app/app.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';
import 'package:todo_app/utils/size/app_size.dart';
import '../welcome/widget/global_page_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerOne = TextEditingController();
  TextEditingController controllerTwo = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.getW()),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 57.getH()),
                const GlobalPageButton(),
                SizedBox(height: 41.getH()),
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 32.getW(),
                    color: Colors.white.withOpacity(.87),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 53.getH()),
                GlobalTextFormField(
                  controller: controllerOne,
                  title: "Username",
                  hintText: "Enter your Username",
                  textInputType: TextInputType.text,
                  obscureText: false,
                ),
                SizedBox(height: 25.getH()),
                GlobalTextFormField(
                  controller: controllerTwo,
                  title: "Password",
                  hintText: ".........",
                  textInputType: TextInputType.text,
                  obscureText: true,
                ),
                SizedBox(height: 70.getH()),
                LoginGlobalButton(
                  text: "Login",
                  color: (controllerOne.text != "" && controllerTwo.text != "")
                      ? AppColors.c8875FF
                      : AppColors.c8875FF.withOpacity(.5),
                  voidCallback: (controllerOne.text != "" &&
                          controllerTwo.text != "" &&
                          StorageRepository.getString(key: "controller1") ==
                              controllerOne.text &&
                          StorageRepository.getString(key: "controller2") ==
                              controllerTwo.text)
                      ? () {
                          Navigator.pushNamed(context, RouteNames.tabBox);
                        }
                      : () {},
                  splashColor:
                      (controllerOne.text != "" && controllerTwo.text != "")
                          ? Colors.white24
                          : AppColors.transparent,
                  textColor:
                      (controllerOne.text != "" && controllerTwo.text != "")
                          ? Colors.white
                          : Colors.white.withOpacity(.5),
                ),
                SizedBox(height: 30.getH()),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 2.getW()),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.c979797,
                            width: 1.r,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "or",
                      style: TextStyle(
                        fontSize: 16.getW(),
                        color: AppColors.c979797,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 2.getW()),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.c979797,
                            width: 1.r,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.getH()),
                LoginGlobalButton(
                  text: "Login with Google",
                  color: AppColors.transparent,
                  voidCallback: () {},
                  splashColor: Colors.white24,
                  textColor: Colors.white,
                  iconLoc: AppNeseserry.google,
                ),
                SizedBox(height: 20.getH()),
                LoginGlobalButton(
                  text: "Login with Appe",
                  color: AppColors.transparent,
                  voidCallback: () {},
                  splashColor: Colors.white24,
                  textColor: Colors.white,
                  iconLoc: AppNeseserry.iphone,
                ),
                SizedBox(height: 46.getH()),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.registerScreen);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don’t have an account? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.getW(),
                          color: AppColors.white.withOpacity(.87),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Register",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.getW(),
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.getH()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
