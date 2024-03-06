import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/screens/on_boarding/page/page_screens.dart';
import 'package:todo_app/screens/routes.dart';
import 'package:todo_app/utils/app/app.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';
import 'package:todo_app/utils/size/app_size.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../welcome/welcome_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<PageScreens> pageScreens = [
    const PageScreens(
      imgLoc: AppNeseserry.onBoardingOne,
      textOne: "Manage your tasks",
      texTwo: "You can easily manage all of your daily tasks in DoMe for free",
    ),
    const PageScreens(
      imgLoc: AppNeseserry.onBoardingTwo,
      textOne: "Create daily routine",
      texTwo:
          "In Uptodo  you can create your personalized routine to stay productive",
    ),
    const PageScreens(
      imgLoc: AppNeseserry.onBoardingThree,
      textOne: "Orgonaize your tasks",
      texTwo:
          "You can organize your daily tasks by adding your tasks into separate categories",
    ),
  ];

  int activite = 0;
  PageController controller=PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: pageScreens,
            onPageChanged: (number){
              setState(() {
                activite = number;
              });
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  pageScreens.length,
                  (index) => Container(
                    height: 4.getH(),
                    width: 26.getW(),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(56.r),
                      color: activite == index ? Colors.white.withOpacity(0.88) : Colors.grey,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 4.getW()),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50.getH(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.getW()),
              child: SizedBox(
                width: width - 50.getW(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(activite!=0) {
                          controller.jumpToPage(activite-1);
                        }
                      },
                      child: Text(
                        "BACK",
                        style: TextStyle(
                          fontSize: 16.getW(),
                          color: Colors.white.withOpacity(.44),
                        ),
                      ),
                    ),
                    ZoomTapAnimation(
                      onTap: () {
                        if(activite!=pageScreens.length-1) {
                          controller.jumpToPage(activite+1);
                        } else {
                          Navigator.pushNamed(context, RouteNames.welcomeScreen);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: AppColors.c8875FF,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.getW(), vertical: 12.getH()),
                        child: Text(
                          activite != pageScreens.length-1 ? "Next" : "Get Started",
                          style: TextStyle(
                            fontSize: 16.getW(),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
