import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        automaticallyImplyLeading: false, // ปิดปุ่ม Back
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to the start page
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
