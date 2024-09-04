import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      body: Center(
        child: Column(
          children: [
            const Text(
              'Home',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the start page
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
