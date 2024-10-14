import 'package:flutter/material.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:goal_quest/pages/goals/goals_list.dart';
import 'package:goal_quest/pages/goals/new_goal_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  Future<void> _refreshGoals(BuildContext context) async {
    context.read<GoalBloc>().add(LoadGoalEvent());
  }

  @override
  Widget build(BuildContext context) {
    final goals = context.select((GoalBloc bloc) => bloc.state.goals.toList());
    final completedGoals = goals.where((goal) => goal.isCompleted).length;
    final inProgressGoals = goals.where((goal) => !goal.isCompleted).length;

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
            const Spacer(),
            const Text(
              'Goals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const BottomNavigationPage(initialIndex: 3),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              iconSize: 30,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshGoals(context),
        color: Colors.white,
        backgroundColor: const Color.fromARGB(255, 53, 51, 205),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Column(
                children: [
                  const Text("Track your Goals"),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 108, 187, 75),
                          Color.fromARGB(255, 58, 90, 47),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/goal_image.png',
                            height: 110,
                          ),
                          const SizedBox(width: 0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  SizedBox(height: 60),
                                  Text(
                                    "Goal Achievement",
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.hourglass_bottom,
                                    size: 15,
                                    color:
                                        Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "Completed",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    completedGoals.toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Goals",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.hourglass_top,
                                    size: 15,
                                    color:
                                        Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "In Progress",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    inProgressGoals.toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Goals",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              LinearPercentIndicator(
                                width: 230.0,
                                lineHeight: 30.0,
                                percent: (completedGoals + inProgressGoals >
                                        0)
                                    ? completedGoals /
                                        (completedGoals + inProgressGoals)
                                    : 0.0,
                                center: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                        "${((completedGoals + inProgressGoals > 0) ? (completedGoals / (completedGoals + inProgressGoals) * 100).toStringAsFixed(0) : '0')}%",
                                        style:
                                            const TextStyle(color: Colors.white)),
                                  ),
                                ),
                                barRadius: const Radius.circular(20),
                                backgroundColor: const Color.fromARGB(
                                    255, 255, 255, 255),
                                progressColor:
                                    const Color.fromARGB(255, 30, 30, 30),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        "In Progress",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Text(
                        'New Goal',
                        style: TextStyle(fontSize: 14),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const NewGoalDialog();
                            },
                          );
                        },
                        iconSize: 40,
                      ),
                    ],
                  ),
                  const GoalsList(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
        
      ),
    );
  }
}