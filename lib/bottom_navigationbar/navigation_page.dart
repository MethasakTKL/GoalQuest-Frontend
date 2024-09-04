import 'package:flutter/material.dart';
import 'package:goal_quest/pages/goals/goals_page.dart';
import 'package:goal_quest/pages/home/home_page.dart';
import 'package:goal_quest/pages/profile/profile_page.dart';
import 'package:goal_quest/pages/store/store_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const GoalsPage(),
    const StorePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _pages.elementAt(_pageIndex),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Align(
              alignment: const Alignment(0.0, 1.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                child: Container(
                  color: const Color.fromARGB(255, 19, 19, 19),
                  child: BottomNavigationBar(
                    selectedItemColor: Colors.orange,
                    unselectedItemColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 19, 19, 19),
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    currentIndex: _pageIndex,
                    onTap:(int index) {
                      setState(() {
                        _pageIndex = index;
                      });
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.flag),
                        label: 'Goals',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.store),
                        label: 'Store',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                    ]
                  ),
                )
              )),
        )
      ],
    ));
  }
}
