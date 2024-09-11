import 'package:flutter/material.dart';
import 'package:goal_quest/pages/goals/goals_page.dart';
import 'package:goal_quest/pages/home/home_page.dart';
import 'package:goal_quest/pages/profile/profile_page.dart';
import 'package:goal_quest/pages/ranking/ranking_page.dart';

class BottomNavigationPage extends StatefulWidget {
  final int initialIndex;

  const BottomNavigationPage({super.key, this.initialIndex = 0});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  late int _pageIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    const HomePage(),
    const GoalsPage(),
    const RankingPage(),
    const ProfilePage(),
  ];

  void changePage(int index) {
    setState(() {
      _pageIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        physics:
            const NeverScrollableScrollPhysics(), // ป้องกันการสไลด์ด้วยนิ้ว
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
            icon: Icon(Icons.stars),
            label: 'Ranking',
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
