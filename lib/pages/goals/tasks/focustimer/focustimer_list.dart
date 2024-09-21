import 'package:flutter/material.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/pages/goals/tasks/focustimer/focustimer_item.dart'; // import ไฟล์ใหม่
import 'package:flutter_bloc/flutter_bloc.dart';

class FocusTimerList extends StatelessWidget {
  const FocusTimerList({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.select((TaskBloc bloc) => bloc.state.tasks
        .where((task) => task.taskType == 'FocusTimer')
        .toList()); //เช็คว่า Tasktype เป็น FocusTimer ไหม
    return SingleChildScrollView(
      child: Column(
        children: 
        tasks.map((task) {
          return FocusTimerItem(
            title: task.title,
            duration: '${task.duration} Minutes',
            points: 100,
            onStart: () {
              Navigator.pushNamed(context, '/focustimer');
            },
          );
        }).toList(),
      ),
    );
  }
}