import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:progress_pal/ui/pages/canceled_task_page.dart';
import 'package:progress_pal/ui/pages/completed_task_page.dart';
import 'package:progress_pal/ui/pages/inprogress_task_page.dart';
import 'package:progress_pal/ui/pages/new_task_page.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';

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
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: Container(
        color: myColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
          child: GNav(
            tabBackgroundColor:
                Color.fromARGB(255, 228, 231, 238).withOpacity(0.1),
            backgroundColor: myColor,
            color: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            activeColor: Colors.white,
            // currentIndex: _currentPageIndex,
            // unselectedItemColor: Colors.grey,
            // showUnselectedLabels: true,
            // selectedItemColor: Color.fromRGBO(181,54,62, 1),
            onTabChange: (int index) {
              _currentPageIndex = index;
              if (mounted) {
                setState(() {});
              }
            },
            gap: 8,
            tabs: const [
              GButton(icon: FontAwesomeIcons.list, text: "New Task"),
              GButton(icon: FontAwesomeIcons.listCheck, text: "Completed"),
              GButton(icon: FontAwesomeIcons.ban, text: "Canceled"),
              GButton(icon: FontAwesomeIcons.barsProgress, text: "In Progress"),
            ],
          ),
        ),
      ),
    );
  }
}
  