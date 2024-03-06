import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/register/widgets/global_button.dart';
import 'package:todo_app/screens/register/widgets/global_page_button.dart';
import 'package:todo_app/screens/register/widgets/global_textformfield.dart';
import '../../utils/app/app.dart';
import '../../utils/appcolors/app_colors.dart';
import '../../utils/size/app_size.dart';
import '../routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  SharedPreferences? _pref;

  Future<void> _getSharedInstance() async {
    _pref = await SharedPreferences.getInstance();
    if (_pref != null) {
      controller1.text = _pref!.getString(controller1.text) ?? "";
      controller2.text = _pref!.getString(controller2.text) ?? "";
      controller3.text = _pref!.getString(controller3.text) ?? "";
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.getW()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 57.getH()),
              const RegisterGlobalPageButton(),
              SizedBox(height: 41.getH()),
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 32.getW(),
                  color: Colors.white.withOpacity(.87),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 53.getH()),
              RegisterGlobalTextFormField(
                controller: controller1,
                title: "Username",
                hintText: "Enter your Username",
                textInputType: TextInputType.text,
                obscureText: false,
              ),
              SizedBox(height: 25.getH()),
              RegisterGlobalTextFormField(
                controller: controller2,
                title: "Password",
                hintText: ".........",
                textInputType: TextInputType.text,
                obscureText: true,
              ),
              SizedBox(height: 25.getH()),
              RegisterGlobalTextFormField(
                controller: controller3,
                title: "Confirm Password",
                hintText: ".........",
                textInputType: TextInputType.text,
                obscureText: true,
              ),
              SizedBox(height: 40.getH()),
              RegisterGlobalButton(
                text: "Register",
                color: (controller1.text != "" && controller2.text != "")
                    ? AppColors.c8875FF
                    : AppColors.c8875FF.withOpacity(.5),
                voidCallback: (controller1.text != "" &&
                        controller2.text != "" &&
                        _pref != null)
                    ? () {
                        _pref!.setString("controller1", controller1.text);
                        _pref!.setString("controller2", controller2.text);
                        Navigator.pushReplacementNamed(
                            context, RouteNames.tabBox);
                      }
                    : () {},
                splashColor: (controller1.text != "" && controller2.text != "")
                    ? Colors.white24
                    : AppColors.transparent,
                textColor: (controller1.text != "" && controller2.text != "")
                    ? Colors.white
                    : Colors.white.withOpacity(.5),
              ),
              SizedBox(height: 21.getH()),
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
              SizedBox(height: 21.getH()),
              RegisterGlobalButton(
                text: "Login with Google",
                color: AppColors.transparent,
                voidCallback: () {},
                splashColor: Colors.white24,
                textColor: Colors.white,
                iconLoc: AppNeseserry.google,
              ),
              SizedBox(height: 20.getH()),
              RegisterGlobalButton(
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
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.loginScreen,
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.getW(),
                        color: AppColors.white.withOpacity(.87),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Login",
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
    );
  }
}
