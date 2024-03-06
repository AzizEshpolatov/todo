import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/data_local/models/task/tack_model.dart';
import 'package:todo_app/screens/tab/home/dialogs/category_select_dialog.dart';
import 'package:todo_app/screens/tab/home/dialogs/proportiy_select.dart';
import 'package:todo_app/utils/app/app.dart';
import 'package:todo_app/utils/size/app_size.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../widgets/global_textfield.dart';

showTaskTitleDialog({
  required bool isTheme,
  required BuildContext context,
  required ValueChanged<TaskModel> taskModelChanged,
}) {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  TaskModel taskModel = TaskModel.initialValue;

  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  int priority = 1;
  String category = "work";

  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(16.r),
        topLeft: Radius.circular(16.r),
      ),
    ),
    backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.r),
                  topLeft: Radius.circular(16.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.h),
                    Text(
                      "Add Task",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 20.w,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    GlobalTextField(
                      valueChanged: (v) {
                        setState(() {
                          taskModel = taskModel.copyWith(title: v);
                          debugPrint("CONTROLLER1 => $v");
                        });
                      },
                      hintText: "Do math homework",
                      focusNode: focusNode2,
                      controller: controller1,
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      "Add Description",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 20.w,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    GlobalTextField(
                      valueChanged: (v) {
                        setState(() {
                          taskModel = taskModel.copyWith(description: v);
                          debugPrint("CONTROLLER2 => $v");
                        });
                      },
                      hintText: "Description",
                      focusNode: focusNode1,
                      controller: controller,
                    ),
                    SizedBox(height: 35.h),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            dateTime = await showDatePicker(
                              cancelText: "Cancel",
                              confirmText: "Select",
                              barrierDismissible: false,
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030),
                              currentDate: DateTime.now(),
                            );
                            if (dateTime != null) {
                              setState(() {
                                taskModel =
                                    taskModel.copyWith(deadline: dateTime!);
                              });
                            }
                            focusNode1.unfocus();
                            focusNode2.unfocus();
                          },
                          child: SvgPicture.asset(
                            AppNeseserry.time,
                            width: 22.w,
                            colorFilter: ColorFilter.mode(
                              isTheme ? Colors.white : Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(width: 32.getW()),
                        GestureDetector(
                          onTap: () async {
                            timeOfDay = await showTimePicker(
                              context: context,
                              initialEntryMode: TimePickerEntryMode.input,
                              initialTime: const TimeOfDay(hour: 8, minute: 0),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );
                            if (timeOfDay != null) {
                              setState(() {
                                taskModel = taskModel.copyWith(
                                    deadline: DateTime(
                                  dateTime!.year,
                                  dateTime!.month,
                                  dateTime!.day,
                                  timeOfDay!.hour,
                                  timeOfDay!.minute,
                                ));
                              });
                            }
                            focusNode1.unfocus();
                            focusNode2.unfocus();
                          },
                          child: IconTheme(
                            data: Theme.of(context).iconTheme,
                            child: Icon(
                              Icons.timelapse_outlined,
                              size: 22.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 32.getW()),
                        GestureDetector(
                          onTap: () {
                            showCategorySelectDialog(
                              context: context,
                              categorySelection: (selectedCategory) {
                                setState(() {
                                  category = selectedCategory;
                                  taskModel = taskModel.copyWith(
                                      category: selectedCategory);
                                });
                              },
                              category: category,
                            );
                          },
                          child: SvgPicture.asset(
                            AppNeseserry.xc,
                            width: 22.w,
                            colorFilter: ColorFilter.mode(
                              isTheme ? Colors.white : Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(width: 32.getW()),
                        GestureDetector(
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
                            focusNode1.unfocus();
                            focusNode2.unfocus();
                          },
                          child: SvgPicture.asset(
                            AppNeseserry.flag,
                            width: 22.w,
                            colorFilter: ColorFilter.mode(
                              isTheme ? Colors.white : Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const Spacer(),
                        ZoomTapAnimation(
                          onTap: () {
                            focusNode1.unfocus();
                            if (taskModel.canAddTaskToDatabase()) {
                              debugPrint("SUCCESS");
                              taskModelChanged(taskModel);
                              setState(() {});
                              Navigator.pop(context);
                            } else {
                              debugPrint("ERROR");
                            }
                          },
                          child: SvgPicture.asset(
                            AppNeseserry.send,
                            width: 22.w,
                            colorFilter: ColorFilter.mode(
                              isTheme ? Colors.white : Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.getH()),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
