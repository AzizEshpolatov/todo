import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/utils/app/app.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';

showPrioritySelectDialog({
  required BuildContext context,
  required ValueChanged<int> priority,
  required int p,
}) {
  int pr = p;
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 120.h),
            color: AppColors.c363636,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Text(
                  "Task Priority",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.w,
                  ),
                ),
                SizedBox(height: 10.h),
                const Divider(height: 2, color: Colors.grey),
                SizedBox(height: 22.h),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: List.generate(
                      10,
                      (index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  pr = index + 1;
                                });
                              },
                              child: Container(
                                width: 60.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.r),
                                  color: pr == (index + 1)
                                      ? AppColors.c8875FF
                                      : Colors.black,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(AppNeseserry.flag,
                                          height: 22.h),
                                      Text(
                                        (index + 1).toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.87),
                            fontSize: 16.w,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          priority.call(pr);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.87),
                            fontSize: 16.w,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
