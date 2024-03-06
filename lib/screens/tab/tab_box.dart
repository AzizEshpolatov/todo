import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/screens/tab/profile/profile_screen.dart';
import 'package:todo_app/utils/app/app.dart';
import 'package:todo_app/utils/size/app_size.dart';
import '../../data_local/local/local_database.dart';
import 'calendar/calendar_screen.dart';
import 'home/dialogs/tack_title_dialog.dart';
import 'home/home_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [
    const HomeScreen(),
    const CalendarScreen(),
    const ProfileScreen(),
  ];

  StreamController<bool> streamController = StreamController<bool>();

  int activeIndex = 0;
  bool isSelected = false;

  selected() async {
    isSelected = await AdaptiveTheme.getThemeMode() == AdaptiveThemeMode.dark;
    setState(() {});
  }

  @override
  void initState() {
    selected();
    _init();
    super.initState();
  }

  Future<void> _init() async {
    screens = [
      HomeScreen(stream: streamController.stream.asBroadcastStream()),
      const CalendarScreen(),
      const ProfileScreen(),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: screens[activeIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF363636),
        unselectedItemColor: Colors.white,
        fixedColor: Colors.white24,
        currentIndex: activeIndex,
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppNeseserry.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppNeseserry.calendar),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppNeseserry.person),
            label: "Profile",
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          isSelected =
              await AdaptiveTheme.getThemeMode() == AdaptiveThemeMode.dark;

          if (!context.mounted) return;
          showTaskTitleDialog(
            isTheme: isSelected,
            context: context,
            taskModelChanged: (task) async {
              await LocalDatabase.insertTask(task);
              streamController.add(true);
            },
          );
        },
        child: SvgPicture.asset(AppNeseserry.add),
      ),
    );
  }
}
