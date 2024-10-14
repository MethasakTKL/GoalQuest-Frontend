import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'edit_task_dialog.dart';

class TodoQuestItem extends StatelessWidget {
  final bool isChecked;
  final String title;
  final String frequency;
  final String lastDone;
  final String nextDue;
  final int repeatDays;
  final DateTime startDate;
  final DateTime endDate;
  final int taskCount;
  final Color cardColor;
  final ValueChanged<bool?>? onChanged;
  final int taskId;
  final bool isReadOnly;
  final bool isCompleteTask;  // ตัวแปรใหม่เพื่อบอกว่าเป็น Task ที่อยู่ใน Completed หรือไม่

  const TodoQuestItem({
    super.key,
    required this.isChecked,
    required this.title,
    required this.frequency,
    required this.lastDone,
    required this.nextDue,
    required this.repeatDays,
    required this.cardColor,
    required this.startDate,
    required this.endDate,
    required this.taskCount,
    this.onChanged,
    required this.taskId,
    required this.isReadOnly,
    required this.isCompleteTask,  // รับค่าเพื่อบอกว่าสถานะคือ Completed หรือไม่
  });

  @override
  Widget build(BuildContext context) {
    Duration difference = endDate.difference(startDate);
    int totalDays = difference.inDays;
    int repeatCount = totalDays ~/ repeatDays;

    bool isComplete = taskCount >= repeatCount;
    final DateFormat dateFormat = DateFormat('d MMMM yyyy');
    final DateTime nextDueDate = dateFormat.parse(nextDue);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: isComplete || DateTime.now().isBefore(nextDueDate) || isReadOnly
                  ? null  // ถ้าเป็น Completed หรือ ReadOnly จะไม่ให้กด
                  : () {
                      if (onChanged != null) {
                        onChanged!(!isChecked);
                      }
                    },
              child: Icon(
                isChecked ? Icons.check_circle : Icons.circle_outlined,
                color: isChecked ? Colors.green : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text('$taskCount/${repeatCount.toString()}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )),
                            if (isComplete) ...[
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.black,
                                size: 18,
                              ),
                            ]
                          ],
                        ),
                        Text(
                          frequency,
                          style: const TextStyle(fontSize: 13),
                        ),
                        Text(
                          'Last: $lastDone',
                          style: const TextStyle(fontSize: 13),
                        ),
                        Text(
                          'Next: $nextDue',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: isCompleteTask
                          ? null // ถ้าเป็น Completed จะไม่ให้กดปุ่มนี้
                          : () {
                              showEditTaskDialog(context, taskId);
                            },
                      icon: const Icon(Icons.more_horiz),
                      tooltip: 'Edit Task', // เพิ่ม tooltip เพื่อบอกการทำงาน
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}