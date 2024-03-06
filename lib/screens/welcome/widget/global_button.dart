import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../utils/size/app_size.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({
    super.key,
    required this.text,
    required this.color,
    required this.voidCallback,
  });

  final String text;
  final Color color;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return ZoomTapAnimation(
      onTap: voidCallback,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: color,
          border: Border.all(
            width: 1.getW(),
            color: AppColors.c8875FF,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.getH()),
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.getW(),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
