import 'package:flutter/material.dart';
import 'start_page.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'create_account_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartPage(),
        '/login': (context) => const LoginPage(),
        '/create_account': (context) => const CreateAccountPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
