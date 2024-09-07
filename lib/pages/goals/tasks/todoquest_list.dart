import 'package:flutter/material.dart';

class TodoQuestList extends StatefulWidget {
  const TodoQuestList({super.key});

  @override
  State<TodoQuestList> createState() => _TodoQuestListState();
}

class _TodoQuestListState extends State<TodoQuestList> {
  bool isChecked = false;
  bool isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked, // ใช้สถานะของ Checkbox
                    onChanged: (bool? newValue) {
                      setState(
                        () {
                          isChecked = newValue!; // อัปเดตสถานะเมื่อกด Checkbox
                        },
                      );
                    },
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
                              const Text(
                                'Title',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 7),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 251, 251, 251),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.diamond_outlined,
                                      size: 15,
                                      color: Color.fromARGB(255, 137, 137, 137),
                                    ),
                                    SizedBox(
                                        width:
                                            5), // เพิ่มช่องว่างระหว่างไอคอนและข้อความ
                                    Text(
                                      'Earn 50 Point',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 137, 137, 137),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Every 1 days',
                            style: TextStyle(fontSize: 13),
                          ),
                          const Text(
                            'Last: -',
                            style: TextStyle(fontSize: 13),
                          ),
                          const Text(
                            'Next: Today',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked2, // ใช้สถานะของ Checkbox
                    onChanged: (bool? newValue) {
                      setState(
                        () {
                          isChecked2 = newValue!; // อัปเดตสถานะเมื่อกด Checkbox
                        },
                      );
                    },
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
                              const Text(
                                'Title',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 7),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 251, 251, 251),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.diamond_outlined,
                                      size: 15,
                                      color: Color.fromARGB(255, 137, 137, 137),
                                    ),
                                    SizedBox(
                                        width:
                                            5), // เพิ่มช่องว่างระหว่างไอคอนและข้อความ
                                    Text(
                                      'Earn 100 Point',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 137, 137, 137),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Every 3 days',
                            style: TextStyle(fontSize: 13),
                          ),
                          const Text(
                            'Last: -',
                            style: TextStyle(fontSize: 13),
                          ),
                          const Text(
                            'Next: 10 Setember 2024',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
