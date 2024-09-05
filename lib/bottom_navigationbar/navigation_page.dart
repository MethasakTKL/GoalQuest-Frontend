import 'package:flutter/material.dart';
import 'package:goal_quest/pages/goals/goals_page.dart';
import 'package:goal_quest/pages/home/home_page.dart';
import 'package:goal_quest/pages/profile/profile_page.dart';
import 'package:goal_quest/pages/collection/collection_page.dart';

class BottomNavigationPage extends StatefulWidget {
  final int initialIndex;

  const BottomNavigationPage({super.key, this.initialIndex = 0});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _pageIndex = 0;  // กำหนดค่าเริ่มต้นโดยตรง

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.initialIndex;  // กำหนดค่าเริ่มต้นใน initState
  }

  final List<Widget> _pages = [
    const HomePage(),
    const GoalsPage(),
    const StorePage(),
    const ProfilePage(),
  ];

  void changePage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(  //IndexedStack เป็น Widget ที่ช่วยในการจัดการการแสดงผลของ Widget ย่อยหลายๆ ตัว โดยจะแสดงเพียงหนึ่ง Widget ในแต่ละครั้งตาม index ที่กำหนด  
        index: _pageIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: const Color.fromARGB(255, 250, 172, 57),
        unselectedItemColor: Colors.white.withOpacity(0.4),
        backgroundColor: const Color.fromARGB(255, 25, 25, 31),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _pageIndex,
        iconSize: 30,
        onTap: changePage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag_circle_outlined),
            label: 'Goals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Collection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}