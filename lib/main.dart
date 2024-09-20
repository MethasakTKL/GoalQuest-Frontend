import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/profile/change_password_page.dart';
import 'package:goal_quest/pages/profile/edit_profile_page.dart';
import 'package:goal_quest/pages/profile/history_page.dart';
import 'package:goal_quest/pages/goals/tasks/focustimer/focustimer_timer.dart';
import 'package:goal_quest/pages/goals/tasks/tasks_page.dart';
import 'package:goal_quest/repositories/repositories.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (context){
            final bloc = TaskBloc(TaskMockRepository());
            bloc.add(LoadTaskEvent());
            return bloc;
          },
        ),
      ],
      child: MaterialApp(
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
          '/tasks': (context) => const TasksPage(),
        },
      ),
    );
  }
}
