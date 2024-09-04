import 'package:flutter/material.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo_black.png',
          height: 70,
        ),
        automaticallyImplyLeading: false, // ปิดปุ่ม Back
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
            },
            iconSize: 30,
          ),
        ]
      ),
      body: const Center(
        child: Column(
          children: [
            Text(
              'Goals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            ),
          ],
        ),
      ),
    );
  }
}