import 'package:flutter/material.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RewardPage extends StatelessWidget {
  const RewardPage({super.key});

  void _showRedeemConfirmationDialog(BuildContext context, int rewardIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Redemption'),
          content: Text(
              'Are you sure you want to redeem Reward ${rewardIndex + 1}?'),
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
                // Add the actual redemption logic here
                print('Confirmed: Redeeming Reward ${rewardIndex + 1}');
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
    final rewards = context.select((RewardBloc bloc) => bloc.state.rewards);
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
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Reward",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
              child: ListView.builder(
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  final reward = rewards[index];  //ดึงข้อมูลแต่ละรายการ
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: 100,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    reward.rewardTitle,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
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
                                _showRedeemConfirmationDialog(context, index);
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
