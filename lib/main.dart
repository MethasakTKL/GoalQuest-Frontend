import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/profile/change_password_page.dart';
import 'package:goal_quest/pages/profile/edit_profile_page.dart';
import 'package:goal_quest/pages/profile/history_page.dart';
import 'package:goal_quest/pages/goals/tasks/focustimer/focustimer_timer.dart';
import 'package:goal_quest/pages/goals/tasks/tasks_page.dart';
import 'package:goal_quest/pages/profile/profile_page.dart';
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
          create: (context) {
            final bloc = TaskBloc(TaskRepoFromDb());
            bloc.add(LoadTaskEvent());
            return bloc;
          },
        ),
        BlocProvider<UserBloc>(
          create: (context) {
            final bloc = UserBloc(UserRepoFromDb());
            bloc.add(GetAllUsersEvent());
            return bloc;
          },
        ),
        BlocProvider<GoalBloc>(
          create: (context) {
            final bloc = GoalBloc(GoalRepoFromDb());
            bloc.add(LoadGoalEvent());
            return bloc;
          },
        ),
        BlocProvider<PointBloc>(
          create: (context) {
            final bloc = PointBloc(PointRepoFromDb());
            bloc.add(LoadAllPointsEvent());
            return bloc;
          },
        ),
        BlocProvider<HistoryBloc>(
          create: (context) {
            final bloc = HistoryBloc(HistoryRepoFromDb());
            bloc.add(LoadHistoryEvent());
            return bloc;
          },
        ),
        BlocProvider<EarnedBloc>(
          create: (context) {
            final bloc = EarnedBloc(EarnedRepoFromDb());
            bloc.add(LoadEarnedEvent());
            return bloc;
          },
        ),
        BlocProvider<RewardBloc>(
          create: (context) {
            final historyBloc =
                context.read<HistoryBloc>(); // อ่าน HistoryBloc จาก context
            final rewardBloc = RewardBloc(RewardRepoFromDb(),
                historyBloc); // ส่ง HistoryBloc เข้า RewardBloc
            rewardBloc.add(LoadRewardEvent()); // โหลด reward เมื่อเริ่มต้น
            return rewardBloc;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/start',
        routes: {
          '/start': (context) => const StartPage(),
          '/login': (context) => LoginPage(),
          '/create_account': (context) => const CreateAccountPage(),
          '/home': (context) => const HomePage(),
          '/bottom_navigation': (context) => const BottomNavigationPage(),
          '/edit_profile': (context) => const EditProfilePage(),
          '/changee_password': (context) => const ChangePasswordPage(),
          '/redeem_history': (context) => const RedeemHistoryPage(),
          '/focustimer': (context) {
            return const FocusTimerPage(
              taskId: 0,
              taskDuration: 0,
              taskName: "name",
            );
          },
          '/tasks': (context) => const TasksPage(),
          '/profilepage': (context) => const ProfilePage(),
        },
      ),
    );
  }
}
