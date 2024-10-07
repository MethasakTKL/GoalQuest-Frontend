import 'package:flutter/material.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/pages/goals/goal_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalsList extends StatelessWidget {
  const GoalsList({super.key});

  @override
  Widget build(BuildContext context) {
    final goals = context.select((GoalBloc bloc) => bloc.state.goals.toList());
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          ...goals.map((goal) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: GoalCard(
                taskTitle: goal.goalTitle,
                taskProgress: "1/5 Tasks",
                progressPercentage: goal.goalProgressPercent,
                onTap: () {
                  Navigator.pushNamed(context, '/tasks',
                      arguments: goal.goalId);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
