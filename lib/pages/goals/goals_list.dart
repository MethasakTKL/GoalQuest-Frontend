import 'package:flutter/material.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/pages/goals/goal_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalsList extends StatelessWidget {
  const GoalsList({super.key});

  @override
  Widget build(BuildContext context) {
    final goals = context.select((GoalBloc bloc) => bloc.state.goals.toList());
    final tasks = context.select((TaskBloc bloc) => bloc.state.tasks.toList());

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          ...goals.map((goal) {
            final goalTasks =
                tasks.where((task) => task.goalId == goal.goalId).toList();
            // นับจำนวน Task ทั้งหมด
            final totalTasks = goalTasks.length;

            // นับจำนวน Task ที่เสร็จแล้ว
            final completedTasks = goalTasks.where((task) {
              final duration = task.endDate.difference(task.startDate);
              final repeatCount = duration.inDays ~/ (task.repeatDays ?? 1);
              return task.taskCount >= repeatCount;
            }).length;

            // คำนวณ progressPercentage และแปลงเป็น double
            final progressPercentage =
                totalTasks > 0 ? (completedTasks / totalTasks).toDouble() : 0.0;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: GoalCard(
                taskTitle: goal.goalTitle,
                taskProgress: "$completedTasks/$totalTasks Tasks",
                progressPercentage: progressPercentage, // ส่งค่าที่คำนวณแล้ว
                onTap: () {
                  Navigator.pushNamed(context, '/tasks',
                      arguments: goal.goalId);
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
