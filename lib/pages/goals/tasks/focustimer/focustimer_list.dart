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
    if (duration >= 120) {
      points = 500;
    } else if (duration >= 90) {
      points = 400;
    } else if (duration >= 60) {
      points = 300;
    } else if (duration >= 45) {
      points = 200;
    } else if (duration >= 30) {
      points = 100;
    } else if (duration >= 1) {
      points = 50;
    }
    return points;
  }
}
