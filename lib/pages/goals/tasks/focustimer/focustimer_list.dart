import 'package:flutter/material.dart';
import 'package:goal_quest/pages/goals/tasks/focustimer/focustimer_item.dart'; // import ไฟล์ใหม่

class FocusTimerList extends StatelessWidget {
  const FocusTimerList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          FocusTimerItem(
            title: 'Body Weight',
            duration: '30 Minutes',
            points: 100,
            onStart: () {
              Navigator.pushNamed(context, '/focustimer');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FocusTimerItem(
            title: 'Balance exercise',
            duration: '30 Minutes',
            points: 100,
            onStart: () {
              Navigator.pushNamed(context, '/focustimer');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FocusTimerItem(
            title: 'Balance exercise',
            duration: '30 Minutes',
            points: 100,
            onStart: () {
              Navigator.pushNamed(context, '/focustimer');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FocusTimerItem(
            title: 'Balance exercise',
            duration: '30 Minutes',
            points: 100,
            onStart: () {
              Navigator.pushNamed(context, '/focustimer');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FocusTimerItem(
            title: 'Balance exercise',
            duration: '30 Minutes',
            points: 100,
            onStart: () {
              Navigator.pushNamed(context, '/focustimer');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FocusTimerItem(
            title: 'Balance exercise',
            duration: '30 Minutes',
            points: 100,
            onStart: () {
              Navigator.pushNamed(context, '/focustimer');
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
