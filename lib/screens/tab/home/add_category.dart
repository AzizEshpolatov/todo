import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/data_local/local/local_database.dart';
import 'package:todo_app/screens/tab/home/dialogs/data_category.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data_local/models/category/category_model.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  CategoryModels categoryModels = CategoryModels.initialValue;
  int activeIndex = 0;
  int activeIndex1 = 0;
  bool onTap = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70.h),
            Text(
              "Create new category",
              style: TextStyle(
                fontSize: 20.w,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Category name :",
              style: TextStyle(
                fontSize: 16.w,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: controller,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.w,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
                fillColor: const Color(0xFF1D1D1D),
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                hintText: "Family",
                hintStyle: TextStyle(
                  fontSize: 16.w,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Category icon :",
              style: TextStyle(
                fontSize: 16.w,
                color: Colors.white,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    categoryAdd.length - 1,
                    (index) => ZoomTapAnimation(
                      onTap: () {
                        categoryModels = categoryModels.copyWith(
                            iconPath: categoryAdd[index].iconLoc);
                        debugPrint("ICON=> : ${categoryAdd[index].iconLoc}");
                        print("ICON=> : ${categoryAdd[index].iconLoc}");
                        activeIndex1 = index;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 10.h),
                        width: 64.w,
                        height: 64.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: activeIndex1 == index
                              ? Colors.green
                              : AppColors.c363636,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            categoryAdd[index].iconLoc,
                            width: 32.w,
                            height: 32.h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Category color :",
              style: TextStyle(
                fontSize: 16.w,
                color: Colors.white,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    categoryAdd.length,
                    (index) => ZoomTapAnimation(
                      onTap: () {
                        categoryModels = categoryModels.copyWith(
                            color: categoryAdd[index].color);
                        categoryModels =
                            categoryModels.copyWith(name: controller.text);

                        debugPrint("COLOR : ${categoryAdd[index].color}");
                        print("COLOR : ${categoryAdd[index].color.value}");
                        setState(() {
                          activeIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 10.h),
                        width: 45.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: categoryAdd[index].color,
                        ),
                        child: activeIndex == index
                            ? Center(
                                child: SvgPicture.asset(
                                  "assets/icons/correct.svg",
                                  height: 25.h,
                                  color: Colors.black,
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ZoomTapAnimation(
                    onTap: () {
                      onTap = false;
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: onTap == false ? Colors.blue : Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 16.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ZoomTapAnimation(
                    onTap: () {
                      if (categoryModels.canAddTaskToDatabase()) {
                        LocalDatabase.insertCategory(categoryModels);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "SAQLANDI MALUMOTLAR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.w,
                              ),
                            ),
                          ),
                        );
                        print("NAME ${categoryModels.name}");
                      } else {
                        SnackBar(
                          content: Text(
                            "SAQLANMADI MALUMOTLAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.w,
                            ),
                          ),
                        );
                      }
                      onTap = true;
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: onTap == true ? Colors.blue : Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          "Create Category",
                          style: TextStyle(
                            fontSize: 16.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
