import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/utils/size/app_size.dart';
import '../../../utils/app/app.dart';

class RegisterGlobalPageButton extends StatelessWidget {
  const RegisterGlobalPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Material(
      borderRadius: BorderRadius.circular(100),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        splashColor: Colors.white24,
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3.getH()),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          width: 24.getW(),
          child:
          Center(child: SvgPicture.asset(AppNeseserry.arrowBack)),
        ),
      ),
    );
  }
}
