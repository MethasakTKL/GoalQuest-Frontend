import 'package:flutter/material.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/reward/reward_page.dart';
import 'package:goal_quest/mockup/user_models_list.dart';

class HomeWidgetPanel extends StatelessWidget {
  const HomeWidgetPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final currentuser = usersList[0];

    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 213, 69, 69),
              borderRadius: BorderRadius.circular(20), // Add rounded corners
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      '4',
                      style: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 55, // Larger size for points
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'GOALS',
                    style: TextStyle(
                      fontFamily: 'Barlow',
                      fontSize: 20, // Adjusted size for smaller text
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 141, 66, 245), // สีฟ้าจางๆ
                  Color(0xFF0D47A1), // สีฟ้าเข้ม
                ],
              ),
              borderRadius: BorderRadius.circular(20), // Add rounded corners
            ),
            child: Stack(
              alignment: Alignment.center, // Align the text in the center
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 45),
                  child: Text(
                    'TOTAL POINT',
                    style: TextStyle(
                      fontFamily: 'Barlow',
                      fontSize: 12, // Adjusted size for smaller text
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 233, 233, 233),
                    ),
                  ),
                ),
                Text(
                  '${currentuser.point}',
                  style: const TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 45, // Larger size for points
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
