import 'package:flutter/material.dart';

class RedeemHistoryTable extends StatelessWidget {
  final bool isRedeemVisible;
  final List<Map<String, dynamic>> redeemHistory;

  const RedeemHistoryTable({
    super.key,
    required this.isRedeemVisible,
    required this.redeemHistory,
  });

    String truncateReward(String reward) {   // ฟังก์ชันสำหรับตัดข้อความที่ยาวเกินไป
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
                            DataCell(Text(history['date'])),
                            DataCell(Text(truncateReward(history['Name']))),
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
