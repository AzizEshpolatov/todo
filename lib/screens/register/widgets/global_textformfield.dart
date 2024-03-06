import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/utils/size/app_size.dart';

class RegisterGlobalTextFormField extends StatelessWidget {
  const RegisterGlobalTextFormField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.textInputType, required this.obscureText,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.getW(),
            color: Colors.white.withOpacity(.87),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.getH()),
        SizedBox(
          height: 50.getH(),
          child: TextFormField(
            controller: controller,
            keyboardType: textInputType,
            obscureText: obscureText,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(
                  width: 1.getW(),
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(
                  width: 1.getW(),
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(
                  width: 1.getW(),
                  color: Colors.red,
                ),
              ),
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 14.getW()),
              filled: true,
              fillColor: const Color(0xFF1D1D1D),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 16.getW(),
                color: const Color(0xFF535353),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your user name.";
              } else if (value.contains('@')) {
                return 'Please don\'t use the @ char.';
              }
              return null;
            },
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
