import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GoalCard extends StatelessWidget {
  final String taskTitle;
  final String duration;
  final String taskProgress;
  final double progressPercentage;
  final VoidCallback onTap;

  const GoalCard({
    super.key,
    required this.taskTitle,
    required this.duration,
    required this.taskProgress,
    required this.progressPercentage,
    required this.onTap,
  });

  LinearGradient _getGradientByPercentage(double percentage) {
    if (percentage < 0.4) {
      return const LinearGradient(
        colors: [
          Color.fromARGB(255, 54, 54, 54), // Red
          Color.fromARGB(255, 133, 133, 133), // Dark Orange
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
    } else if (percentage < 0.7) {
      return const LinearGradient(
        colors: [
          Color.fromARGB(255, 227, 142, 38), // Dark Orange
          Color.fromARGB(255, 255, 207, 73), // Yellow
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
    } else {
      return const LinearGradient(
        colors: [
          Color(0xFF006400), // Dark Green
          Color(0xFF90EE90), // Light Green
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          color: const Color.fromARGB(156, 208, 208, 208),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          taskTitle,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.hourglass_top,
                                size: 13,
                                color: Colors.black54,
                              ),
                              Text(
                                duration,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.hourglass_top,
                                size: 13,
                                color: Colors.black54,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                taskProgress,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    LinearPercentIndicator(
                      width: 350,
                      lineHeight: 30.0,
                      percent: progressPercentage,
                      center: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "${(progressPercentage * 100).toStringAsFixed(0)}%",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      barRadius: const Radius.circular(20),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      linearGradient:
                          _getGradientByPercentage(progressPercentage),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
