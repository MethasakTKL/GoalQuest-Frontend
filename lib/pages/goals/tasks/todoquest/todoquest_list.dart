import 'package:flutter/material.dart';
import 'package:goal_quest/pages/goals/tasks/todoquest/todoquest_item.dart'; // import ไฟล์ใหม่

class TodoQuestList extends StatefulWidget {
  const TodoQuestList({super.key});

  @override
  State<TodoQuestList> createState() => _TodoQuestListState();
}

class _TodoQuestListState extends State<TodoQuestList> {
  bool isChecked = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TodoQuestItem(
            isChecked: isChecked,
            title: 'Task_1',
            frequency: 'Every 1 days',
            lastDone: '10 September 2024',
            nextDue: 'Today',
            onChanged: (bool? newValue) {
              setState(() {
                isChecked = newValue!;
              });
            },
          ),
          TodoQuestItem(
            isChecked: isChecked2,
            title: 'Task_2',
            frequency: 'Every 2 days',
            lastDone: '8 September 2024',
            nextDue: '10 September 2024',
            onChanged: (bool? newValue) {
              setState(() {
                isChecked2 = newValue!;
              });
            },
          ),
          TodoQuestItem(
            isChecked: isChecked3,
            title: 'Task_3',
            frequency: 'Every 2 days',
            lastDone: '8 September 2024',
            nextDue: '10 September 2024',
            onChanged: (bool? newValue) {
              setState(() {
                isChecked3 = newValue!;
              });
            },
          ),
          TodoQuestItem(
            isChecked: isChecked4,
            title: 'Task_4',
            frequency: 'Every 2 days',
            lastDone: '8 September 2024',
            nextDue: '10 September 2024',
            onChanged: (bool? newValue) {
              setState(() {
                isChecked4 = newValue!;
              });
            },
          ),
          TodoQuestItem(
            isChecked: isChecked5,
            title: 'Task_5',
            frequency: 'Every 2 days',
            lastDone: '8 September 2024',
            nextDue: '10 September 2024',
            onChanged: (bool? newValue) {
              setState(() {
                isChecked5 = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}
