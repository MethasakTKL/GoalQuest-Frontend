import 'package:flutter/material.dart';
import 'package:goal_quest/models/models.dart';
import 'package:intl/intl.dart';

class RedeemHistoryTable extends StatelessWidget {
  final bool isRedeemVisible;
  final List<HistoryModel> redeemHistory;
  final List<RewardModel> rewards;
  

  const RedeemHistoryTable({
    super.key,
    required this.isRedeemVisible,
    required this.redeemHistory,
    required this.rewards,
  });

  String truncateReward(String reward) {
    // ฟังก์ชันสำหรับตัดข้อความที่ยาวเกินไป
    if (reward.length > 10) {
      return '${reward.substring(0, 10)}...';
    }
    return reward;
  }

  String getRewardTitle(int rewardId){
    final reward = rewards.firstWhere((reward) => reward.rewardId == rewardId);
    return reward.rewardTitle;
  }

  @override
  Widget build(BuildContext context) {
    List<HistoryModel> sortedRedeemHistory = List.from(redeemHistory);
    sortedRedeemHistory.sort((a, b) => b.redeemedDate.compareTo(a.redeemedDate));
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
                  rows: sortedRedeemHistory
                      .map(
                        (history) =>  DataRow(
                          cells: [
                            DataCell(Text(DateFormat('dd/MM/yyyy').format(history
                                .redeemedDate))), // จัดรูปแบบวันที่เป็น "วัน/เดือน/ปี"
                            DataCell(Text(truncateReward(getRewardTitle(history.rewardId)))), // แสดงชื่อประวัติการใช้งาน
                            DataCell(Text(history.pointsSpent.toString())),
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
