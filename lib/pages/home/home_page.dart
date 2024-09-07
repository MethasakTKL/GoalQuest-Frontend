import 'package:flutter/material.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/reward/reward_page.dart';
import 'package:goal_quest/pages/goals/goal_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const Text(
              'Home',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const BottomNavigationPage(initialIndex: 3),
                    transitionDuration: const Duration(
                        seconds: 0), // กำหนดเวลาของการเปลี่ยนหน้า
                  ),
                );
              },
              iconSize: 30,
            ),
          ],
        ),
        automaticallyImplyLeading: false, // ปิดปุ่ม Back
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Center(
            child: Column(
              children: [
                const Text("Welcome back, Steven"),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 170,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(156, 255, 160, 8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const BottomNavigationPage(initialIndex: 1),
                            transitionDuration: const Duration(
                                seconds: 0), // กำหนดเวลาของการเปลี่ยนหน้า
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(156, 208, 208, 208),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.flag_circle_rounded,
                                size: 26,
                                color: Color.fromARGB(255, 64, 64, 64),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Goal",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RewardPage()),
                        );
                      },
                      child: Container(
                        width: 120,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(156, 208, 208, 208),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.redeem,
                                size: 26,
                                color: Color.fromARGB(255, 64, 64, 64),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Reward",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/redeem_history');
                      },
                      child: Container(
                        width: 120,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(156, 208, 208, 208),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.history,
                                size: 26,
                                color: Color.fromARGB(255, 64, 64, 64),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "History",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "In Progress",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TaskCard(
                        taskTitle: "เรียนวิถี Backend",
                        duration: "2 Weeks",
                        taskProgress: "1/2 Tasks",
                        progressPercentage: 0.8,
                        onTap: () {
                          Navigator.pushNamed(context, '/tasks');
                        },
                      ),
                      const SizedBox(height: 10),
                      TaskCard(
                        taskTitle: "เรียนรู้ Flutter",
                        duration: "1 Week",
                        taskProgress: "3/5 Tasks",
                        progressPercentage: 0.6,
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      TaskCard(
                        taskTitle: "ลดน้ำหนัก 10 กิโล",
                        duration: "1 Months",
                        taskProgress: "3/10 Tasks",
                        progressPercentage: 0.3,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
