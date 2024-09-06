import 'package:flutter/material.dart';

class FocusTimerList extends StatelessWidget {
  const FocusTimerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
                          'Learn Python',
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
                                '500 Points',
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
                          '120 Minutes',
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
                              borderRadius: BorderRadius.circular(
                                  30), // ปรับมุมปุ่มให้มนเพียงเล็กน้อย
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
