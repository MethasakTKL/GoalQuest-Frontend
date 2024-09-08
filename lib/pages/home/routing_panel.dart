import 'package:flutter/material.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/reward/reward_page.dart';

class HomeRoutingPanel extends StatelessWidget {
  const HomeRoutingPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: _buildRoutingButton(
            context,
            icon: Icons.flag_circle_rounded,
            label: "Goal",
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const BottomNavigationPage(initialIndex: 1),
                  transitionDuration: const Duration(seconds: 0),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: _buildRoutingButton(
            context,
            icon: Icons.redeem,
            label: "Reward",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RewardPage()),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: _buildRoutingButton(
            context,
            icon: Icons.sort,
            label: "Ranking",
            onTap: () {
              Navigator.pushNamed(context, '/redeem_history');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRoutingButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromARGB(156, 208, 208, 208),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 26,
                color: const Color.fromARGB(255, 64, 64, 64),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
