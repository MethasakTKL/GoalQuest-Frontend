import 'package:flutter/material.dart';
import 'package:goal_quest/pages/goals/goal_card.dart';

class GoalsList extends StatelessWidget {
  const GoalsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        GoalCard(
          taskTitle: "ลดน้ำหนัก 10 กิโล",
          duration: "2 Weeks",
          taskProgress: "3/4 Tasks",
          progressPercentage: 0.75,
          onTap: () {
            Navigator.pushNamed(context, '/tasks');
          },
        ),
        const SizedBox(height: 10),
        GoalCard(
          taskTitle: "เรียนรู้ Flutter",
          duration: "1 Week",
          taskProgress: "3/5 Tasks",
          progressPercentage: 0.6,
          onTap: () {},
        ),
        const SizedBox(height: 10),
        GoalCard(
          taskTitle: "อ่าน Sapients",
          duration: "2 Months",
          taskProgress: "4/10 Tasks",
          progressPercentage: 0.4,
          onTap: () {},
        ),
        const SizedBox(height: 10),
        GoalCard(
          taskTitle: "ลดน้ำหนัก 10 กิโล",
          duration: "1 Months",
          taskProgress: "3/10 Tasks",
          progressPercentage: 0.3,
          onTap: () {},
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
