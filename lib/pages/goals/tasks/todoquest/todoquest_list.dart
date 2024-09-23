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

  void restCheckBox(){
    setState(() {
      isChecked = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final tasks = context.select((TaskBloc bloc) => bloc.state.tasks
        .where((task) => task.taskType == 'TodoQuest')
        .toList()); //เช็คว่า Tasktype เป็น TodoQuest ไหม
    final today = DateTime.now();
    final todayTasks = tasks.where((task) {
      if (task.nextAction == null) return false;
      final nextActionDate = task.nextAction!;
      return nextActionDate.year == today.year &&
          nextActionDate.month == today.month &&
          nextActionDate.day == today.day;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (todayTasks.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 63, 148, 69),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: todayTasks
                        .map((task) => TodoQuestItem(
                              cardColor:
                                  const Color.fromARGB(255, 173, 217, 98),
                              isChecked: task.lastAction != null &&
                                  task.lastAction!.isAfter(DateTime.now()
                                      .subtract(Duration(
                                          days: task.repeatDays ?? 1))),
                              title: task.title,
                              frequency: 'Every ${task.repeatDays} days',
                              lastDone: task.lastAction != null
                                  ? DateFormat('d MMMM yyyy')
                                      .format(task.lastAction!)
                                  : 'Not started',
                              nextDue: task.nextAction != null
                                  ? DateFormat('d MMMM yyyy')
                                      .format(task.nextAction!)
                                  : '-',
                              repeatDays: task.repeatDays ?? 1,
                              startDate: task.startDate,
                              taskCount: task.taskCount,
                              endDate: task.endDate,
                              onChanged: (bool? newValue) {
                                if (newValue != null) {
                                  context.read<TaskBloc>().add(
                                      ActionTaskEvent(task.id, DateTime.now(), task.taskCount));
                                }
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            'Next',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: tasks
                  .map((task) => TodoQuestItem(
                        cardColor: Colors.grey[300]!,
                        isChecked: task.lastAction != null &&
                            task.lastAction!.isAfter(DateTime.now().subtract(
                                Duration(days: task.repeatDays ?? 1))),
                        title: task.title,
                        frequency: 'Every ${task.repeatDays} days',
                        lastDone: task.lastAction != null
                            ? DateFormat('d MMMM yyyy').format(task.lastAction!)
                            : 'Not started',
                        nextDue: task.nextAction != null
                            ? DateFormat('d MMMM yyyy').format(task.nextAction!)
                            : '-',
                        repeatDays: task.repeatDays ?? 1,
                        startDate: task.startDate,
                        endDate: task.endDate,
                        taskCount: task.taskCount,
                        onChanged: (bool? newValue) {
                          if (newValue == true) {
                            context
                                .read<TaskBloc>()
                                .add(ActionTaskEvent(task.id, DateTime.now(), task.taskCount));
                          }
                        },
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
