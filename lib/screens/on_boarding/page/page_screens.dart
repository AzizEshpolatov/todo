import 'package:flutter/material.dart';
import 'package:todo_app/utils/appstyle/app_text_style.dart';
import 'package:todo_app/utils/size/app_size.dart';
import '../../routes.dart';
import '../../welcome/welcome_screen.dart';

class PageScreens extends StatelessWidget {
  const PageScreens({
    super.key,
    required this.imgLoc,
    required this.textOne,
    required this.texTwo,
  });

  final String imgLoc;
  final String textOne;
  final String texTwo;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.getW()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60.getH()),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.welcomeScreen);
            },
            child: Text(
              "SKIP",
              style: AppTextStyle.latoRegular.copyWith(
                fontSize: 16.getW(),
                color: Colors.white.withOpacity(.5),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Image.asset(
                  imgLoc,
                  fit: BoxFit.cover,
                  height: 270.getH(),
                ),
                SizedBox(height: 105.getH()),
                Text(
                  textOne,
                  style: TextStyle(
                    fontSize: 32.getW(),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 42.getH()),
                SizedBox(
                  width: width-80.getW(),
                  height: 70,
                  child: Text(
                    texTwo,
                    style: TextStyle(
                      fontSize: 16.getW(),
                      color: Colors.white.withOpacity(0.87),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
