import 'package:flutter/material.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/pages/goals/tasks/focustimer/focustimer_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FocusTimerList extends StatelessWidget {
  final int goalId;
  const FocusTimerList({super.key, required this.goalId});

  @override
  Widget build(BuildContext context) {
    final int goalId = ModalRoute.of(context)!.settings.arguments as int;
    final tasks = context.select((TaskBloc bloc) => bloc.state.tasks
        .where((task) => task.goalId == goalId && task.taskType == 'FocusTimer')
        .toList());

    return SingleChildScrollView(
      child: Column(
        children: tasks.isNotEmpty
            ? tasks
                .expand((task) => [
                      const SizedBox(height: 10),
                      FocusTimerItem(
                        title: task.title,
                        duration: '${task.duration} Minutes',
                        points: 100,
                        onStart: () {
                          Navigator.pushNamed(context, '/focustimer');
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
}
