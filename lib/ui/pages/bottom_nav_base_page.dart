import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_pal/ui/pages/canceled_task_page.dart';
import 'package:progress_pal/ui/pages/completed_task_page.dart';
import 'package:progress_pal/ui/pages/inprogress_task_page.dart';
import 'package:progress_pal/ui/pages/new_task_page.dart';

class BottomNavBasePage extends StatefulWidget {
  const BottomNavBasePage({super.key});

  @override
  State<BottomNavBasePage> createState() => _BottomNavBasePageState();
}

class _BottomNavBasePageState extends State<BottomNavBasePage> {
  int _currentPageIndex = 0;
  final List<Widget> _pages = [
    const NewTaskPage(),
    const CompletedTaskPage(),
    const CanceledTaskPage(),
    const InProgressTaskPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedItemColor: Colors.green,
          onTap: (int index) {
            _currentPageIndex = index;
            if (mounted) {
              setState(() {});
            }
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.list), label: "New Task"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.listCheck), label: "Complete"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.ban), label: "Cancel"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.barsProgress),
                label: "In Progress"),
          ]),
    );
  }
}
