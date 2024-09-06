import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskCard extends StatelessWidget {
  final String taskTitle;
  final String duration;
  final String taskProgress;
  final double progressPercentage;
  final VoidCallback onTap;

  const TaskCard({
    Key? key,
    required this.taskTitle,
    required this.duration,
    required this.taskProgress,
    required this.progressPercentage,
    required this.onTap,
  }) : super(key: key);

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
                        // const SizedBox(
                        //   width: 80,
                        // ),
                        // const Icon(
                        //   Icons.arrow_forward_ios,
                        //   size: 18,
                        // ),
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
                      progressColor: const Color.fromARGB(255, 86, 86, 86),
                    ),
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
