import 'package:flutter/material.dart';
import 'package:goal_quest/models/history_model.dart';
import 'package:intl/intl.dart';

class RedeemHistoryTable extends StatelessWidget {
  final bool isRedeemVisible;
  final List<HistoryModel> redeemHistory;

  const RedeemHistoryTable({
    super.key,
    required this.isRedeemVisible,
    required this.redeemHistory,
  });

  String truncateReward(String reward) {
    // ฟังก์ชันสำหรับตัดข้อความที่ยาวเกินไป
    if (reward.length > 10) {
      return '${reward.substring(0, 10)}...';
    }
    return reward;
  }

  @override
  Widget build(BuildContext context) {
    return isRedeemVisible
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
                        'Reward',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Spent',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: redeemHistory
                      .map(
                        (history) => DataRow(
                          cells: [
                            DataCell(Text(DateFormat('dd/MM/yyyy').format(history
                                .historyDate))), // จัดรูปแบบวันที่เป็น "วัน/เดือน/ปี"
                            DataCell(Text(truncateReward(history
                                .historyTitle))), // แสดงชื่อประวัติการใช้งาน
                            DataCell(Text(history.historyPoint.toString())),
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
