import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';
import '../../../utils/size/app_size.dart';

class RegisterGlobalButton extends StatelessWidget {
  const RegisterGlobalButton({
    super.key,
    required this.text,
    required this.color,
    required this.voidCallback,
    required this.splashColor,
    required this.textColor,
    this.iconLoc,
  });

  final String text;
  final Color color;
  final Color splashColor;
  final Color textColor;
  final VoidCallback voidCallback;
  final String? iconLoc;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(4.r),
        onTap: voidCallback,
        splashColor: splashColor,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconLoc != null
                  ? Padding(
                      padding: EdgeInsets.only(right: 10.getW()),
                      child: SvgPicture.asset(
                        iconLoc!,
                        width: 24.getW(),
                      ),
                    )
                  : const SizedBox(),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.getW(),
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
