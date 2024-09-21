import 'package:flutter/material.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/pages/goals/tasks/todoquest/todoquest_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodoQuestList extends StatefulWidget {
  const TodoQuestList({super.key});

  @override
  State<TodoQuestList> createState() => _TodoQuestListState();
}

class _TodoQuestListState extends State<TodoQuestList> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final tasks = context.select((TaskBloc bloc) => bloc.state.tasks
        .where((task) => task.taskType == 'TodoQuest')
        .toList()); //เช็คว่า Tasktype เป็น TodoQuest ไหม

    return SingleChildScrollView(
      child: Column(
        children: tasks.map((task) {
          return TodoQuestItem(
            isChecked: isChecked,
            title: task.title,
            frequency: 'Every ${task.repeatDays} days',
            lastDone: task.lastAction != null
                ? DateFormat('d MMMM yyyy').format(task.lastAction!)
                : 'Not started',
            nextDue: task.nextAction != null 
            ? DateFormat('d MMMM yyyy').format(task.nextAction!)
            : '-',
            onChanged: (bool? newValue) {
              setState(() {
                isChecked = newValue!;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
