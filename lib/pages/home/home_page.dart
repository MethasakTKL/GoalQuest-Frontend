import 'package:flutter/material.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/goals/goals_list.dart';
import 'package:goal_quest/pages/home/routing_panel.dart';

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
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20), // ปรับขอบให้มนเหมือน container
                        child: Image.asset(
                          'assets/slide_1.png',
                          fit: BoxFit.cover, // ขยายรูปให้เต็ม container
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Positioned(
                              top: 10, // กำหนดระยะห่างจากด้านบน
                              left: 10, // กำหนดระยะห่างจากด้านซ้าย
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 7),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 206, 206),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize
                                      .min, // กำหนดขนาดของ Row ให้พอดีกับเนื้อหา
                                  children: [
                                    Icon(
                                      Icons.diamond_outlined,
                                      size: 15,
                                      color: Color.fromARGB(255, 225, 58, 58),
                                    ),
                                    SizedBox(
                                        width:
                                            5), // เพิ่มช่องว่างระหว่างไอคอนและข้อความ
                                    Text(
                                      '500 Points',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 225, 58, 58),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const HomeRoutingPanel(),
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
                const GoalsList(),
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
