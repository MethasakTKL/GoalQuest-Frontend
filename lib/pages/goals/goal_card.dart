import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GoalCard extends StatelessWidget {
  final String taskTitle;
  final String taskProgress;
  final double progressPercentage;
  final VoidCallback onTap;
  final VoidCallback onDelete; // ฟังก์ชันสำหรับลบ
  final VoidCallback onEdit; // ฟังก์ชันสำหรับแก้ไข

  const GoalCard({
    super.key,
    required this.taskTitle,
    required this.taskProgress,
    required this.progressPercentage,
    required this.onTap,
    required this.onDelete, // เพิ่มฟังก์ชันลบใน constructor
    required this.onEdit, // เพิ่มฟังก์ชันแก้ไขใน constructor
  });

  LinearGradient _getGradientByPercentage(double percentage) {
    if (percentage < 0.7) {
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
          child: Stack(
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
                        Expanded(
                          child: Text(
                            taskTitle,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
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
                    ),
                  ],
                ),
              ),
              Positioned(
                // ตั้งตำแหน่งของ PopupMenuButton
                top: 10,
                right: 10,
                child: PopupMenuButton(
                  icon: const Icon(Icons.more_horiz_outlined),
                  color: Colors.white,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 97, 97, 97),
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Edit',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 97, 97, 97),
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Delete',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'delete') {
                      onDelete(); // เรียกใช้ฟังก์ชันลบเมื่อเลือก Delete
                    } else if (value == 'edit') {
                      onEdit(); // เรียกใช้ฟังก์ชันแก้ไขเมื่อเลือก Edit
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
