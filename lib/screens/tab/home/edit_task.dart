import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data_local/local/local_database.dart';
import '../../../data_local/models/category/category_model.dart';
import '../../../data_local/models/task/tack_model.dart';
import 'dialogs/category_select_dialog.dart';
import 'dialogs/proportiy_select.dart';

class EditTask extends StatefulWidget {
  const EditTask({
    super.key,
    required this.taskModel,
    required this.idTask,
  });

  final int idTask;
  final TaskModel taskModel;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  _init() async {
    // List<CategoryModels> categories = await LocalDatabase.getAllCategory();
    setState(() {});
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController1 = TextEditingController();
    TextEditingController textFieldController2 = TextEditingController();
    String category = "work";
    int priority = 1;

    TaskModel taskModel = TaskModel.initialValue;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Task",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: AppColors.c363636,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Edit Title",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.w,
                  ),
                ),
                SizedBox(height: 10.h),
                ZoomTapAnimation(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height - 400,
                          margin: EdgeInsets.symmetric(
                            vertical: 200.h,
                            horizontal: 15.w,
                          ),
                          color: AppColors.c363636,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20.h),
                              Text(
                                "Edit Task Title",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.w,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Divider(height: 2.h, color: Colors.black),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: SizedBox(
                                  height: 40.h,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: TextField(
                                      controller: textFieldController1,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          borderSide: BorderSide(
                                            width: 1.r,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          borderSide: BorderSide(
                                            width: 1.r,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "Malumotlar saqlansinmi?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.w,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              ZoomTapAnimation(
                                onTap: () {
                                  LocalDatabase.updateTaskTitle(
                                    newTitle: textFieldController1.text,
                                    taskId: widget.idTask,
                                  );
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: Colors.blue,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Saqlash",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.grey,
                    ),
                    child: Text(
                      widget.taskModel.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Edit Description",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.w,
                  ),
                ),
                SizedBox(height: 10.h),
                ZoomTapAnimation(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height - 400,
                          margin: EdgeInsets.symmetric(
                            vertical: 200.h,
                            horizontal: 15.w,
                          ),
                          color: AppColors.c363636,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20.h),
                              Text(
                                "Edit Task Description",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.w,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Divider(height: 2.h, color: Colors.black),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: SizedBox(
                                  height: 40.h,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: TextField(
                                      controller: textFieldController2,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          borderSide: BorderSide(
                                            width: 1.r,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          borderSide: BorderSide(
                                            width: 1.r,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "Malumotlar saqlansinmi?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.w,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              ZoomTapAnimation(
                                onTap: () {
                                  LocalDatabase.updateTaskDescription(
                                    newDescription: textFieldController1.text,
                                    taskId: widget.idTask,
                                  );
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: Colors.blue,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Saqlash",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.grey),
                    child: Text(
                      widget.taskModel.description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              "Edit Category",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.w,
              ),
            ),
            SizedBox(height: 10.h),
            ZoomTapAnimation(
              onTap: () {
                showCategorySelectDialog(
                  context: context,
                  categorySelection: (selectedCategory) {
                    setState(() {
                      category = selectedCategory;
                      taskModel =
                          taskModel.copyWith(category: selectedCategory);
                    });
                  },
                  category: category,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.grey,
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Center(
                  child: Text(
                    widget.taskModel.category,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.w,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Edit Priority",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.w,
              ),
            ),
            SizedBox(height: 10.h),
            ZoomTapAnimation(
              onTap: () {
                showPrioritySelectDialog(
                  p: taskModel.priority,
                  context: context,
                  priority: (p) {
                    setState(() {
                      priority = p;
                      taskModel = taskModel.copyWith(priority: p);
                    });
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.grey,
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Center(
                  child: Text(
                    widget.taskModel.priority.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.w,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            ZoomTapAnimation(
              onTap: () {
                setState(() {});
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Text(
                    "Malumotlarni saqlash",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.w,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
