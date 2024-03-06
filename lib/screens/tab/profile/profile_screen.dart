import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/screens/routes.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            Text(
              "Profile",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 20.w,
                  ),
            ),
            SizedBox(height: 25.h),
            CircleAvatar(
              radius: 43.w,
              child: ClipOval(
                child: Image.asset("assets/images/ps.png", width: 85.w),
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              "Martha Hays",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 20.w,
                  ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.c363636,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 17.h),
                          child: Center(
                            child: Text(
                              "10 Task Level",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontSize: 16.w,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.c363636,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 17.h),
                          child: Center(
                            child: Text(
                              "10 Task done",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontSize: 16.w,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    "Settings",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 16.w,
                        ),
                  ),
                  SizedBox(height: 16.h),
                  ZoomTapAnimation(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.addCategory);
                    },
                    child: SizedBox(
                      child: Row(
                        children: [
                          IconTheme(
                            data: Theme.of(context).iconTheme,
                            child: Icon(
                              Icons.settings,
                              weight: 24.w,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "App Settings",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontSize: 16.w,
                                ),
                          ),
                          const Spacer(),
                          IconTheme(
                            data: Theme.of(context).iconTheme,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              weight: 24.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
