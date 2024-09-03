import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        automaticallyImplyLeading: false, // ปิดปุ่ม Back
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to the start page
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
