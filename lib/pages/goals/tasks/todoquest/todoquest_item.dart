import 'package:flutter/material.dart';

class TodoQuestItem extends StatelessWidget {
  final bool isChecked;
  final String title;
  final String frequency;
  final String lastDone;
  final String nextDue;
  final ValueChanged<bool?>? onChanged;

  const TodoQuestItem({
    super.key,
    required this.isChecked,
    required this.title,
    required this.frequency,
    required this.lastDone,
    required this.nextDue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onChanged,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      frequency,
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      'Last: $lastDone',
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      'Next: $nextDue',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
