import 'package:flutter/material.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/profile/table/earn_point_table.dart';
import 'package:goal_quest/pages/profile/table/redeem_history_table.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedeemHistoryPage extends StatefulWidget {
  const RedeemHistoryPage({super.key});

  @override
  State<RedeemHistoryPage> createState() => _RedeemHistoryPageState();
}

class _RedeemHistoryPageState extends State<RedeemHistoryPage> {
  final List<Map<String, dynamic>> earnPointHistory = const [
    {'date': '02/09/2024', 'taskName': 'adadadasdadadadadad', 'point': 200},
    {'date': '20/08/2024', 'taskName': 'Task Title', 'point': 300},
    {'date': '17/07/2024', 'taskName': 'Task Title', 'point': 400},
    {'date': '17/07/2024', 'taskName': 'Task Title', 'point': 200},
    {'date': '17/07/2024', 'taskName': 'Task Title', 'point': 200},
    {'date': '17/07/2024', 'taskName': 'Task Title', 'point': 200},
    {'date': '17/07/2024', 'taskName': 'Task Title', 'point': 200},
    {'date': '17/07/2024', 'taskName': 'Task Title', 'point': 200},
  ];

  bool isEarnPointVisible = true;

  bool isRedeemVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Row(
          children: [
            Image.asset(
              'assets/logo_black.png',
              height: 50,
            ),
            const Spacer(), // ใช้ Spacer เพื่อจัดตำแหน่ง
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const BottomNavigationPage(initialIndex: 3),
                    transitionDuration: const Duration(
                        seconds: 0), // กำหนดเวลาของการเปลี่ยนหน้า
                  ),
                );
              },
              iconSize: 30,
            ),
          ],
        ),
        automaticallyImplyLeading: false, // ปิดปุ่ม Back
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 26,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'History',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Row(
                    children: [
                      const Text(
                        'Earn Point',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isEarnPointVisible = !isEarnPointVisible;
                          });
                        },
                        icon: Icon(isEarnPointVisible
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right),
                        iconSize: 26.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                EarnPointTable(
                    isEarnPointVisible: isEarnPointVisible,
                    earnPointHistory: earnPointHistory),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Row(
                    children: [
                      const Text(
                        'Redeem',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isRedeemVisible = !isRedeemVisible;
                          });
                        },
                        icon: Icon(isRedeemVisible
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right),
                        iconSize: 26.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                BlocBuilder<HistoryBloc, HistoryState>(
                  builder: (context, historyState) {
                    return BlocBuilder<RewardBloc, RewardState>(
                      builder: (context, rewardState) {
                        if (historyState is LoadingHistoryState ||
                            rewardState is LodingRewardState) {
                          
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (historyState is ReadyHistoryState &&
                            (rewardState is ReadyRewardState ||
                                rewardState is RewardRedeemedState)) {
                         
                          final redeemHistory = historyState.histories;
                          final rewards = rewardState.rewards;

                          if (redeemHistory.isEmpty || rewards.isEmpty) {
                            return const Center(
                              child: Text(
                                  'No redeem history or rewards available'),
                            );
                          }

                          return RedeemHistoryTable(
                            isRedeemVisible: isRedeemVisible,
                            redeemHistory: redeemHistory,
                            rewards: rewards,
                          );
                        } else if (historyState is ErrorHistoryState ||
                            rewardState is ErrorRewardState) {
                          return isRedeemVisible
                              ? const Center(
                                  child: Text(
                                    'No history of reward redemption.',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : const SizedBox.shrink();
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
