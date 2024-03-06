import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalTextField extends StatelessWidget {
  const GlobalTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.focusNode,
    required this.valueChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final ValueChanged<String> valueChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: valueChanged,
      focusNode: focusNode,
      controller: controller,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontSize: 12.w,
      ),
      decoration: InputDecoration(
        // border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
            width: 0.r,
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
            width: 1.r,
            color: Colors.red,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 16.w,
        ),
      ),
      keyboardType: TextInputType.text,
    );
  }
}
