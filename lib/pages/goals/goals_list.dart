import 'package:flutter/material.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/pages/goals/goal_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/pages/goals/edit_goal_dialog.dart';

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
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: const Text(
                            'Are you sure you want to delete this goal?'),
                        backgroundColor: Colors.white,
                        actions: [
                          TextButton(
                            onPressed: () {
                              // ปิด dialog
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 60, 60, 60)),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // ลบเป้าหมาย (ทำการลบที่นี่)
                              // หลังจากนั้นปิด dialog
                              Navigator.of(context).pop();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 149, 47, 47),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },

                onEdit: () {
                  // สมมุติว่าคุณมีข้อมูลของเป้าหมายที่ต้องการแก้ไข
                  String goalTitle = "Current Goal Title"; // เปลี่ยนเป็นค่าจริง
                  String goalDescription =
                      "Current Goal Description"; // เปลี่ยนเป็นค่าจริง
                  int goalId = 1; // เปลี่ยนเป็น ID ของเป้าหมายที่ต้องการแก้ไข

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return EditGoalDialog(
                        initialTitle: goalTitle,
                        initialDescription: goalDescription,
                        goalId: goalId,
                      );
                    },
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
