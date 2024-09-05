import 'package:flutter/material.dart';

class RedeemHistoryPage extends StatefulWidget {
  const RedeemHistoryPage({super.key});

  @override
  State<RedeemHistoryPage> createState() => _RedeemHistoryPageState();
}

class _RedeemHistoryPageState extends State<RedeemHistoryPage> {
  final List<Map<String, dynamic>> earnPointHistory = const [
    {'date': '02/09/2024', 'taskName': 'Task Title', 'point': 200},
    {'date': '20/08/2024', 'taskName': 'Task Title', 'point': 300},
    {'date': '17/07/2024', 'taskName': 'Task Title', 'point': 400},
    {'date': '17/07/2024', 'taskName': 'Task Title', 'point': 200},
    {'date': '17/07/2024', 'taskName': 'Task Title', 'point': 200},
    {'date': '17/07/2024', 'taskName': 'Task Title', 'point': 200},
    {'date': '17/07/2024', 'taskName': 'Task Title', 'point': 200},
    {'date': '17/07/2024', 'taskName': 'Task Title', 'point': 200},
  ];

  final List<Map<String, dynamic>> redeemHistory = const [
    {'date': '04/09/2024', 'Name': 'Godji', 'point': 1000},
    {'date': '13/08/2024', 'Name': 'Frogie', 'point': 2500},
    {'date': '12/07/2024', 'Name': 'Fire Cat', 'point': 1500},
    {'date': '10/07/2024', 'Name': 'Godji', 'point': 1000},
    {'date': '5/07/2024', 'Name': 'Frogie', 'point': 2500},
    {'date': '1/07/2024', 'Name': 'Fire Cat', 'point': 1500},
    {'date': '30/06/2024', 'Name': 'Frogie', 'point': 2500},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Row(
          children: [
            Image.asset(
              'assets/logo_black.png',
              height: 50,
            ),
            const Spacer(), // ใช้ Spacer เพื่อจัดตำแหน่ง
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // ทำอะไรบางอย่างเมื่อกดปุ่ม
              },
              iconSize: 30,
            ),
          ],
        ),
        automaticallyImplyLeading: false, // ปิดปุ่ม Back
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 26,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.history,
                      size: 26.0,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'History',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Row(
                    children: [
                      const Text(
                        'Earn Point History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 26.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: 300,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Date',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Task',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Earn',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: earnPointHistory
                            .map(
                              (history) => DataRow(
                                cells: [
                                  DataCell(Text(history['date'])),
                                  DataCell(Text(history['taskName'])),
                                  DataCell(Text(history['point'].toString())),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Row(
                    children: [
                      const Text(
                        'Redeem History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 26.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: 300,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Date',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Reward',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Spent',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: redeemHistory
                            .map(
                              (history) => DataRow(
                                cells: [
                                  DataCell(Text(history['date'])),
                                  DataCell(Text(history['Name'])),
                                  DataCell(Text(history['point'].toString())),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
