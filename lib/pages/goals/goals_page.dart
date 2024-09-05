import 'package:flutter/material.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

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
            const Spacer(), // ใช้ Spacer เพื่อจัดตำแหน่ง
            const Text(
              'Goals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(), // ใช้ Spacer เพื่อจัดตำแหน่ง
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // ทำอะไรบางอย่างเมื่อกดปุ่ม
              },
              iconSize: 30,
            ),
          ],
        ),
        automaticallyImplyLeading: false, // ปิดปุ่ม Back
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const Text("Track your Goals"),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 45, 122, 65), // สีเริ่มต้น
                          Color(0xFF64E57F), // สีสิ้นสุด
                        ],
                        begin: Alignment.topLeft, // เริ่มไล่สีจากมุมบนซ้าย
                        end: Alignment.bottomRight, // ไล่สีไปยังมุมล่างขวา
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
