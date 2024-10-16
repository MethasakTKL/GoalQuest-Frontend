import 'package:flutter/material.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/pages/goals/tasks/focustimer/focustimer_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './focustimer_timer.dart';

class FocusTimerList extends StatelessWidget {
  final int goalId;

  const FocusTimerList({super.key, required this.goalId});

  @override
  Widget build(BuildContext context) {
    final int goalId = ModalRoute.of(context)!.settings.arguments as int;
    final tasks = context.select((TaskBloc bloc) => bloc.state.tasks
        .where((task) => task.goalId == goalId && task.taskType == 'FocusTimer')
        .toList());

    // เรียงลำดับ tasks ตามคะแนนจากน้อยไปมาก
    tasks.sort((a, b) {
      // First, sort by completion status
      if (a.taskisDone != b.taskisDone) {
        return a.taskisDone ? 1 : -1; // Completed tasks go to the bottom
      }
      // If both tasks have the same completion status, sort by points (duration)
      return calculatePoints(a.duration ?? 0)
          .compareTo(calculatePoints(b.duration ?? 0));
    });

    return SingleChildScrollView(
      child: Column(
        children: tasks.isNotEmpty
            ? tasks
                .expand((task) => [
                      const SizedBox(height: 10),
                      FocusTimerItem(
                        taskCompleted: task.taskisDone,
                        taskIndex: task.id,
                        title: task.title,
                        duration: '${task.duration ?? 0} Min',
                        points: calculatePoints(
                            task.duration ?? 0), // คำนวณคะแนนจากระยะเวลา
                        onStart: () {
                          // Navigate to FocusTimerPage with taskDuration and taskName
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FocusTimerPage(
                                taskId: task.id,
                                taskDuration: task.duration ?? 0,
                                taskName: task.title, // ส่ง taskName ไปด้วย
                              ),
                            ),
                          );
                        },
                      ),
                    ])
                .toList()
            : [
                const SizedBox(height: 20),
                const Text(
                  'No FocusTimer',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
      ),
    );
  }

  // ฟังก์ชันสำหรับคำนวณคะแนนจาก duration
  int calculatePoints(int duration) {
    int points = 0;

    if (duration >= 150) {
      points = 800;
    } else if (duration >= 120) {
      points = 700;
    } else if (duration >= 100) {
      points = 600;
    } else if (duration >= 90) {
      points = 520;
    } else if (duration >= 60) {
      points = 430;
    } else if (duration >= 45) {
      points = 350;
    } else if (duration >= 30) {
      points = 270;
    } else if (duration >= 15) {
      points = 190;
    } else if (duration >= 10) {
      points = 130;
    } else if (duration >= 5) {
      points = 60;
    } else if (duration >= 1) {
      points = 10;
    }

    return points;
  }
}
