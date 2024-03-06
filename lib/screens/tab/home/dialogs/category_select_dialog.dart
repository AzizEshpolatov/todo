import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/data_local/local/local_database.dart';
import 'package:todo_app/screens/routes.dart';
import 'package:todo_app/utils/app/app.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';
import '../../../../data_local/models/category/category_model.dart';
import '../../../../utils/size/app_size.dart';
showCategorySelectDialog({
  required BuildContext context,
  required ValueChanged<String> categorySelection,
  required String category,
}) async {
  String selectedCategory = category;
  List<CategoryModels> categories = await LocalDatabase.getAllCategory();

  if (!context.mounted) return;
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          width = MediaQuery.of(context).size.width;
          height = MediaQuery.of(context).size.height;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.c363636,
            ),
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 80.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.h),
                Text(
                  "Task Priority",
                  style: TextStyle(
                    color: Colors.white.withOpacity(.87),
                    fontSize: 16.w,
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(height: 2.h, color: Colors.grey),
                SizedBox(height: 15.h),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(categories.length + 1, (index) {
                      if (index == categories.length) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pushNamed(context, RouteNames.addCategory);
                            setState(() {
                              selectedCategory = "ADD";
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 60.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                  color: selectedCategory == 'ADD'
                                      ? Colors.green
                                      : Colors.amber,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Center(
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      selectedCategory == "ADD"
                                          ? Colors.white
                                          : Colors.black,
                                      BlendMode.srcIn,
                                    ),
                                    child: SvgPicture.asset(
                                      AppNeseserry.addCategory,
                                      height: 30.h,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "ADD",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.w,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      CategoryModels categoryModel = categories[index];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = categories[index].name;
                              });
                            },
                            child: Container(
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                color:
                                    selectedCategory == categories[index].name
                                        ? Colors.green
                                        : categoryModel.color,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Center(
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    selectedCategory == categories[index].name
                                        ? Colors.white
                                        : Colors.black,
                                    BlendMode.srcIn,
                                  ),
                                  child: SvgPicture.asset(
                                    categories[index].iconPath,
                                    height: 30.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            categories[index].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.w,
                            ),
                          ),
                        ],
                      );
                    }),
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
                          categorySelection.call(selectedCategory);
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
                )
              ],
            ),
          );
        },
      );
    },
  );
}
