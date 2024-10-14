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
  bool isEarnPointVisible = false;
  bool isRedeemVisible = false;

  Future<void> _refreshHistory(BuildContext context) async {
    context.read<EarnedBloc>().add(LoadEarnedEvent());
    context.read<TaskBloc>().add(LoadTaskEvent());
    context.read<HistoryBloc>().add(LoadHistoryEvent());
    context.read<RewardBloc>().add(LoadRewardEvent());
  }

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
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const BottomNavigationPage(initialIndex: 3),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              iconSize: 30,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshHistory(context),
        color: Colors.white,
        backgroundColor: const Color.fromARGB(255, 53, 51, 205),
        child: ListView(
          children: [
            Padding(
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
                    BlocBuilder<EarnedBloc, EarnedState>(
                        builder: (context, earnedState) {
                      return BlocBuilder<TaskBloc, TaskState>(
                          builder: (context, taskState) {
                        if (taskState is LodingTaskState ||
                            earnedState is LoadingEarnedState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (earnedState is ReadyEarnedState &&
                            taskState is ReadyTaskState) {
                          final earned = earnedState.earneds;
                          final tasks = taskState.tasks;

                          // Debugging: print earned and tasks list length
                          debugPrint('Earned length: ${earned.length}');
                          debugPrint('Tasks length: ${tasks.length}');

                          if (earned.isEmpty || tasks.isEmpty) {
                            return isEarnPointVisible
                                ? const Center(
                                    child: Text(
                                      'No data available',
                                    ),
                                  )
                                : const SizedBox.shrink();
                          }

                          // ถ้ามีข้อมูลจะไปแสดงในตาราง EarnPointTable
                          return EarnPointTable(
                            isEarnPointVisible: isEarnPointVisible,
                            earnedPoints: earned,
                            tasks: tasks,
                          );
                        } else if (earnedState is ErrorEarnedState ||
                            taskState is ErrorTaskState) {
                          return isEarnPointVisible
                              ? const Center(
                                  child: Text(
                                    'No point earned.',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : const SizedBox.shrink();
                        } else {
                          return const SizedBox.shrink();
                        }
                      });
                    }),
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
                                return isRedeemVisible
                                    ? const Center(
                                        child: Text(
                                            'No redeem history or rewards available'),
                                      )
                                    : const SizedBox.shrink();
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
          ],
        ),
      ),
    );
  }
}