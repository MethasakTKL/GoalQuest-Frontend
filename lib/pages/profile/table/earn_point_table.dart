import 'package:flutter/material.dart';
import 'package:goal_quest/models/models.dart';
import 'package:intl/intl.dart';

class EarnPointTable extends StatelessWidget {
  final bool isEarnPointVisible;
  final List<EarnedModel> earnedPoints;
  final List<TaskModel> tasks;

  const EarnPointTable({
    super.key,
    required this.earnedPoints,
    required this.tasks,
    required this.isEarnPointVisible,
  });

  String truncateTask(String taskName) {   // ฟังก์ชันสำหรับตัดข้อความที่ยาวเกินไป
    if (taskName.length > 10) {
      return '${taskName.substring(0, 10)}...';
    }
    return taskName;
  }

  String getTaskTitle(int taskId){
    final task = tasks.firstWhere((task) => task.id == taskId);
    return task.title;
  }

  @override
  Widget build(BuildContext context) {
    return isEarnPointVisible
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SizedBox(
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Task',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Earn',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: earnedPoints
                      .map(
                        (history) => DataRow(
                          cells: [
                            DataCell(Text(DateFormat('dd/MM/yyyy').format(history
                                .earnedDate))),
                            DataCell(Text(truncateTask(getTaskTitle(history.taskId)))),
                            DataCell(Text(history.earnedPoint.toString())),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        : Container();
  }
}
