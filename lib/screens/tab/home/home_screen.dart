import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/screens/tab/home/edit_task.dart';
import 'package:todo_app/utils/appcolors/app_colors.dart';
import '../../../data_local/local/local_database.dart';
import '../../../data_local/models/task/tack_model.dart';
import '../../../utils/app/app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.stream});

  final Stream? stream;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskModel taskModel = TaskModel.initialValue;
  List<TaskModel> tasks = [];
  bool isSelected = true; // 1

  _init() async {
    tasks = await LocalDatabase.getAllTasks();
    setState(() {});
  }

  selected() async {
    isSelected = await AdaptiveTheme.getThemeMode() == AdaptiveThemeMode.dark;
    setState(() {});
  }

  _searchQuery(String q) async {
    tasks = await LocalDatabase.searchTasks(q);
    setState(() {});
  }

  DateTime? dateTime;
  TimeOfDay? timeOfDay;

  @override
  void initState() {
    selected();
    if (widget.stream != null) {
      widget.stream!.listen((event) {
        _init(); //3
      });
    }
    super.initState();
  }

  bool showValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 57.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Switch(
                    value: isSelected,
                    onChanged: (v) {
                      if (v) {
                        AdaptiveTheme.of(context).setDark();
                      } else {
                        AdaptiveTheme.of(context).setLight();
                      }
                      isSelected = v;
                    },
                    activeTrackColor: isSelected ? Colors.blue : Colors.grey,
                    inactiveTrackColor: isSelected
                        ? Colors.blue.withOpacity(0.5)
                        : Colors.grey.withOpacity(0.5),
                    activeColor: isSelected ? Colors.white : Colors.black,
                    inactiveThumbColor:
                        isSelected ? Colors.white : Colors.black,
                  ),
                  Text(
                    "Index",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  CircleAvatar(
                    radius: 21.r,
                    child: Image.asset(AppNeseserry.person1),
                  ),
                ],
              ),
              tasks.isEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 75.h),
                          SizedBox(
                            height: 270.h,
                            child: Image.asset(AppNeseserry.homeImg),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "What do you want to do today?",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Tap + to add your tasks",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(height: 10.h),
                        TextField(
                          onChanged: _searchQuery,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ...List.generate(
                          tasks.length,
                          (index) {
                            return Container(
                              width: MediaQuery.of(context).size.width - 20,
                              margin: EdgeInsets.symmetric(vertical: 5.h),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 160.w,
                                          child: Text(
                                            tasks[index].title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () async {
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
                                          style: Theme.of(context)
                                              .iconButtonTheme
                                              .style,
                                          icon: const Icon(Icons.edit_calendar,
                                              color: Colors.green),
                                        ),
                                        SizedBox(width: 10.w),
                                        IconButton(
                                          onPressed: () async {
                                            await LocalDatabase.deleteTask(
                                              tasks[index].id!,
                                            );
                                            _init();
                                            setState(() {});
                                          },
                                          style: Theme.of(context)
                                              .iconButtonTheme
                                              .style,
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: Colors.red,
                                        value: tasks[index].isSelected,
                                        side:
                                            MaterialStateBorderSide.resolveWith(
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      const Spacer(),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                        child: Text(
                                          tasks[index].category,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
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
      ),
    );
  }
}
