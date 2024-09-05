import 'package:flutter/material.dart';

class RedeemHistoryPage extends StatelessWidget {
  const RedeemHistoryPage({super.key});

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
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // ทำอะไรบางอย่างเมื่อกดปุ่ม
              },
              iconSize: 30,
            ),
          ],
        ),
        automaticallyImplyLeading: false, // ปิดปุ่ม Back
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                    const Icon(Icons.history, size: 26.0, color: Colors.black,),
                    const SizedBox(width: 10),
                    const Text(
                      'History',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,0,0),
                  child: Row(
                    children: [
                      const Text(
                        'Earn Point History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 26.0 ,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,0,0),
                  child: Row(
                    children: [
                      const Text(
                        'Redeem History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 26.0 ,
                        color: Colors.black,
                      ),
                    ],
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
