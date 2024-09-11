import 'package:flutter/material.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/mockup/user_models_list.dart';
import 'package:goal_quest/pages/goals/goals_list.dart';
import 'package:goal_quest/pages/home/routing_panel.dart';
import 'package:goal_quest/pages/home/widget_panel.dart';

import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentuser = usersList[0];
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome back, ${currentuser.first_name}"),
                  ],
                ),
                const SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CarouselSlider(
                        items: [
                          'assets/slide_1.png',
                          'assets/slide_2.png',
                        ]
                            .map((item) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: AssetImage(item),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          autoPlayInterval: const Duration(seconds: 10),
                          viewportFraction: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const HomeWidgetPanel(),
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
