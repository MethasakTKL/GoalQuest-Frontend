import 'package:flutter/material.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/goals/goals_list.dart';
import 'package:goal_quest/pages/home/routing_panel.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              iconSize: 30,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Center(
            child: Column(
              children: [
                const Text("Welcome back, Steven"),
                const SizedBox(height: 10),
                // เริ่ม Stack สำหรับ CarouselSlider และคะแนน 500 Points
                Stack(
                  children: [
                    // CarouselSlider
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), // ทำขอบโค้ง
                      ),
                      clipBehavior: Clip.antiAlias, // ให้คลิปภาพตามขอบที่โค้ง
                      child: CarouselSlider(
                        items: [
                          Image.asset(
                            'assets/slide_1.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Image.asset(
                            'assets/slide_2.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Image.asset(
                            'assets/slide_3.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ],
                        options: CarouselOptions(
                          height: 170,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          autoPlayInterval: const Duration(seconds: 10),
                          viewportFraction: 1.0,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 32, 32, 32),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.diamond_outlined,
                              size: 15,
                              color: Color.fromARGB(255, 222, 222, 222),
                            ),
                            SizedBox(
                                width:
                                    5), // เพิ่มช่องว่างระหว่างไอคอนและข้อความ
                            Text(
                              '1250 Points',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 233, 233, 233),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const HomeRoutingPanel(),
                const SizedBox(height: 20),
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
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
