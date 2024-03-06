import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data_local/local/local_database.dart';
import '../../../data_local/models/task/tack_model.dart';
import '../home/edit_task.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  TaskModel taskModel = TaskModel.initialValue;
  List<TaskModel> tasks = [];
  List<TaskModel> tasksForTargetDate = [];
  late DateTime _selectedDate;

  _init() async {
    tasks = await LocalDatabase.getAllTasks();
    setState(() {});
  }

  @override
  void initState() {
    _selectedDate = DateTime.now();
    _init();
    _getData();
    _selectDate(context);
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  _getData() async {
    DateTime targetDate = _selectedDate; // 2024-03-06 sana
    List<TaskModel> tasks = await LocalDatabase.getTasksByDate(targetDate);
    setState(() {
      tasksForTargetDate = tasks;
    });
  }

  DateTime _selectedDay = DateTime.now();
  bool active = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Calendar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.w,
          ),
        ),
        backgroundColor: AppColors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          WeeklyDatePicker(
            backgroundColor: AppColors.c363636,
            selectedDigitBackgroundColor: Colors.blue,
            weekdayTextColor: Colors.white,
            weeknumberColor: Colors.white,
            enableWeeknumberText: false,
            digitsColor: Colors.white,
            selectedDay: _selectedDay,
            changeDay: (value) {
              setState(() {
                _selectedDay = value;
              });
            },
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              children: [
                Expanded(
                  child: ZoomTapAnimation(
                    onTap: () {
                      active = false;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color:
                            active == false ? Colors.blue : AppColors.c363636,
                      ),
                      child: Center(
                        child: Text(
                          "Today",
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
                      active = true;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: active == true ? Colors.blue : AppColors.c363636,
                      ),
                      child: Center(
                        child: Text(
                          "Completed",
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
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView(
              children: [
                active == true
                    ? Column(
                        children: [
                          ...List.generate(
                            tasks.length,
                            (index) {
                              return Container(
                                width: MediaQuery.of(context).size.width - 20,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 15.w),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: AppColors.c363636,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 160.w,
                                            child: Text(
                                              tasks[index].title,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          ZoomTapAnimation(
                                            onTap: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return EditTask(
                                                      idTask: tasks[index].id!,
                                                      taskModel: tasks[index],
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: const Icon(
                                                Icons.edit_calendar,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10.w),
                                          ZoomTapAnimation(
                                            onTap: () async {
                                              await LocalDatabase.deleteTask(
                                                tasks[index].id!,
                                              );
                                              _init();
                                              setState(() {});
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: Colors.red,
                                          value: tasks[index].isSelected,
                                          side: MaterialStateBorderSide
                                              .resolveWith(
                                            (states) => const BorderSide(
                                              width: 1.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              tasks[index].isSelected = value!;
                                            });
                                          },
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          (tasks[index]
                                              .deadline
                                              .toString()
                                              .substring(0, 10)),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: const Color(0xFFAFAFAF),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.h),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                          child: Text(
                                            tasks[index].category,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          ...List.generate(
                            tasksForTargetDate.length,
                            (index) {
                              return Container(
                                width: MediaQuery.of(context).size.width - 20,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 15.w),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: AppColors.c363636,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 160.w,
                                            child: Text(
                                              tasksForTargetDate[index].title,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          ZoomTapAnimation(
                                            onTap: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return EditTask(
                                                      idTask:
                                                          tasksForTargetDate[
                                                                  index]
                                                              .id!,
                                                      taskModel:
                                                          tasksForTargetDate[
                                                              index],
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: const Icon(
                                                Icons.edit_calendar,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10.w),
                                          ZoomTapAnimation(
                                            onTap: () async {
                                              await LocalDatabase.deleteTask(
                                                tasksForTargetDate[index].id!,
                                              );
                                              _init();
                                              setState(() {});
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: Colors.red,
                                          value: tasksForTargetDate[index]
                                              .isSelected,
                                          side: MaterialStateBorderSide
                                              .resolveWith(
                                            (states) => const BorderSide(
                                              width: 1.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              tasksForTargetDate[index]
                                                  .isSelected = value!;
                                            });
                                          },
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          (tasksForTargetDate[index]
                                              .deadline
                                              .toString()
                                              .substring(0, 10)),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: const Color(0xFFAFAFAF),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.h),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                          child: Text(
                                            tasksForTargetDate[index].category,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
