import 'package:flutter/material.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/reward/reward_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/tasks');
                  },
                  child: Container(
                    width: double.infinity,
                    height: 130,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(156, 208, 208, 208),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "จะเป็น Backend Dev ให้ได้",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.hourglass_top,
                                            size: 13,
                                            color: Colors.black54,
                                          ),
                                          Text(
                                            "2 Weeks",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.hourglass_top,
                                              size: 13, color: Colors.black54),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            "1/2 Tasks",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                LinearPercentIndicator(
                                  width: 350,
                                  lineHeight: 30.0,
                                  percent: 0.5,
                                  center: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "50%",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  barRadius: const Radius.circular(20),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  progressColor: const Color.fromARGB(
                                      255,
                                      86,
                                      86,
                                      86), // ตั้งเป็นสีขาว เพื่อให้ ShaderMask ทำงาน
                                ),
                              ],
                            ),
                          )
                        ],
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
