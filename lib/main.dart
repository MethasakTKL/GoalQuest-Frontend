import 'package:flutter/material.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/profile/change_password_page.dart';
import 'package:goal_quest/pages/profile/edit_profile_page.dart';
import 'package:goal_quest/pages/profile/redeem_history_page.dart';
import 'package:goal_quest/pages/goals/focus_timer.dart';

import 'pages/auth/start_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/home/home_page.dart';
import 'pages/auth/create_account_page.dart';

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
        '/bottom_navigation': (context) => const BottomNavigationPage(),
        '/edit_profile': (context) => const EditProfilePage(),
        '/changee_password': (context) => const ChangePasswordPage(),
        '/redeem_history': (context) => const RedeemHistoryPage(),
        '/focustimer': (context) => const FocusTimerPage(),
      },
    );
  }
}
