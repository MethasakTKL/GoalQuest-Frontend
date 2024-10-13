import 'package:flutter/material.dart';
import '../todoquest/edit_task_dialog.dart';

class FocusTimerItem extends StatelessWidget {
  final String title;
  final String duration;
  final int points;
  final VoidCallback onStart;
  final int taskIndex;

  const FocusTimerItem({
    super.key,
    required this.title,
    required this.duration,
    required this.points,
    required this.onStart,
    required this.taskIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 132,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the start
            children: [
              Row(
                children: [
                  Expanded(
                    // Use Expanded to manage space
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 251, 251, 251),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.diamond_outlined,
                          size: 15,
                          color: Color.fromARGB(255, 137, 137, 137),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '$points Points',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 137, 137, 137),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    duration,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      showEditTaskDialog(context, taskIndex);
                    },
                    icon: const Icon(Icons.more_horiz),
                    tooltip: 'Edit Task', // Accessibility tooltip
                  ),
                  const SizedBox(width: 10), // Spacing for better UI
                  ElevatedButton(
                    onPressed: () {
                      try {
                        onStart(); // Execute onStart and catch potential errors
                      } catch (e) {
                        // Handle errors gracefully (e.g., show a SnackBar)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error starting timer: $e')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 96, 137, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.hourglass_top,
                          size: 19,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Start',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
