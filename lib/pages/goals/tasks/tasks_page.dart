import 'package:flutter/material.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/goals/tasks/focus_timer_list.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // จำนวนแท็บ
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: Row(
            children: [
              Image.asset(
                'assets/logo_black.png',
                height: 50,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigationPage(
                        initialIndex: 3,
                      ),
                    ),
                  );
                },
                iconSize: 30,
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 26,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Goal Title 1',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'New Task',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle),
                          onPressed: () {},
                          iconSize: 40,
                        ),
                      ],
                    ),
                    const SizedBox(height: 0),
                    const TabBar(
                      labelColor: Colors.black,
                      indicatorColor: Color.fromARGB(255, 95, 148, 80),
                      tabs: [
                        Tab(text: 'TodoQuest'),
                        Tab(text: 'FocusTimer'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 400,
                      child: TabBarView(
                        children: [
                          // เนื้อหาในแท็บ Todoquest
                          Center(
                            child: Text(
                              'Todoquest Content',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          // เรียกใช้งาน FocusTimerList ที่นำเข้ามา
                          FocusTimerList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
