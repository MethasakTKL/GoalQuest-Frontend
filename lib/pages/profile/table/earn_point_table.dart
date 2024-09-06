import 'package:flutter/material.dart';

class EarnPointTable extends StatelessWidget {
  final bool isEarnPointVisible;
  final List<Map<String, dynamic>> earnPointHistory;

  const EarnPointTable({
    super.key,
    required this.isEarnPointVisible,
    required this.earnPointHistory,
  });

  String truncateTask(String taskName) {   // ฟังก์ชันสำหรับตัดข้อความที่ยาวเกินไป
    if (taskName.length > 10) {
      return '${taskName.substring(0, 10)}...';
    }
    return taskName;
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
                  rows: earnPointHistory
                      .map(
                        (history) => DataRow(
                          cells: [
                            DataCell(Text(history['date'])),
                            DataCell(Text(truncateTask(history['taskName']))),
                            DataCell(Text(history['point'].toString())),
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
