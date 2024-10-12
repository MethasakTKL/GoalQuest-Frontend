import 'package:flutter/material.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RewardPage extends StatelessWidget {
  const RewardPage({super.key});

  void _showRedeemConfirmationDialog(
      BuildContext context, String rewardTitle, int rewardId, int rewardPoint) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Redemption'),
          content: Text('Are you sure you want to redeem $rewardTitle ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                debugPrint(
                    'Redeeming Reward $rewardTitle with ID: $rewardId'); // ตรวจสอบว่ามี rewardId ถูกต้องหรือไม่
                context.read<RewardBloc>().add(RedeemRewardEvent(
                    rewardId: rewardId)); // ส่ง event พร้อม rewardId

                debugPrint('Confirmed: Redeeming Reward $rewardTitle ');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/logo_black.png',
              height: 50,
            ),
            const Spacer(),
            const Text(
              'Reward',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.refresh, // เพิ่มไอคอนรีเฟรช
                color: Colors.black,
              ),
              onPressed: () {
                // ส่ง event เพื่อโหลดข้อมูลใหม่
                context.read<RewardBloc>().add(LoadRewardEvent());
              },
              iconSize: 23,
            ),
            IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
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
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Center(
              child: Container(
                height: 250,
                width: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF6A00F4), Color(0xFF32C5FF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.savings_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      '1000',
                      style: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'TOTAL POINT',
                      style: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Reward",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              const Text(
                "Refresh",
                style: TextStyle(fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.refresh, // เพิ่มไอคอนรีเฟรช
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // ส่ง event เพื่อโหลดข้อมูลใหม่
                    context.read<RewardBloc>().add(LoadRewardEvent());
                  },
                  iconSize: 23,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<RewardBloc, RewardState>(
                builder: (context, state) {
                  debugPrint("Reward State: $state");

                  if (state is LodingRewardState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ReadyRewardState ||
                      state is RewardRedeemedState) {
                    // ถ้า state เป็น Ready หรือ Redeemed ก็ให้แสดงผล list ของ rewards
                    final rewards = state.rewards;

                    return ListView.builder(
                      itemCount: rewards.length,
                      itemBuilder: (context, index) {
                        final reward = rewards[index]; // ดึงข้อมูลแต่ละรายการ
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          reward.rewardTitle,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 7),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 251, 251, 251),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.redeem,
                                                size: 15,
                                                color: Color.fromARGB(
                                                    255, 137, 137, 137),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                '${reward.rewardPoints} Points',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 137, 137, 137),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          reward.rewardDescription,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (reward.rewardId != null) {
                                        _showRedeemConfirmationDialog(
                                          context,
                                          reward.rewardTitle,
                                          reward.rewardId!,
                                          reward.rewardPoints,
                                        );
                                      } else {
                                        debugPrint("Reward ID is null");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF6A00F4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Redeem',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is ErrorRewardState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: ${state.error}'),
                        ),
                      );

                      // พยายาม Reload อัตโนมัติ
                      context.read<RewardBloc>().add(LoadRewardEvent());
                    });
                    return const Center(
                      child: Text('Failed to load rewards'),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
