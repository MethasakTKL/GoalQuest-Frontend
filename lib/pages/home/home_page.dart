import 'package:flutter/material.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/History/history_page.dart';
import 'package:goal_quest/pages/reward/reward_page.dart';

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
                          MaterialPageRoute(
                            builder: (context) => const BottomNavigationPage(
                              initialIndex: 1,
                            ),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RewardPage()
                          ),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HistoryPage()
                          ),
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
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(156, 208, 208, 208),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                      child: Row(
                        children: [],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(156, 208, 208, 208),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                      child: Row(
                        children: [],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(156, 208, 208, 208),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                      child: Row(
                        children: [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
