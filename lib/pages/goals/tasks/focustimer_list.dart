import 'package:flutter/material.dart';

class FocusTimerList extends StatelessWidget {
  const FocusTimerList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 122,
            decoration: BoxDecoration(
              color: Colors.grey[300], // สีเทาอ่อน
              borderRadius: BorderRadius.circular(10), // ขอบมน
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Body Weight',
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
                            mainAxisSize: MainAxisSize
                                .min, // กำหนดขนาดของ Row ให้พอดีกับเนื้อหา
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
                                '100 Points',
                                style: TextStyle(
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
                    const Row(
                      children: [
                        Text(
                          '30 Minutes',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/focustimer');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 96, 137, 52),
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
                              SizedBox(
                                width: 5,
                              ),
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
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 122,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Balance exercise',
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
                              SizedBox(width: 5),
                              Text(
                                '100 Points',
                                style: TextStyle(
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
                    const Row(
                      children: [
                        Text(
                          '30 Minutes',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/focustimer');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 96, 137, 52),
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
                              SizedBox(
                                width: 5,
                              ),
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
          ),
        ],
      ),
    );
  }
}
