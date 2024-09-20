import 'package:flutter/material.dart';
import 'dart:async';

class FocusTimerPage extends StatefulWidget {
  const FocusTimerPage({super.key});

  @override
  State<FocusTimerPage> createState() => _FocusTimerPageState();
}

class _FocusTimerPageState extends State<FocusTimerPage> {
  bool isPlaying = false;
  int totalSeconds = 1 * 60; // 120 minutes in seconds
  late Timer timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (isPlaying) {
      timer.cancel();
    }
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (totalSeconds > 0) {
          totalSeconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    setState(() {
      timer.cancel();
      isPlaying = false;
    });
  }

  void toggleTimer() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        startTimer();
      } else {
        stopTimer();
      }
    });
  }

  String formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 255, 168),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 213, 255, 168),
        title: Row(
          children: [
            Image.asset(
              'assets/logo_black.png',
              height: 50,
            ),
            const Spacer(),
            const Text(
              'เรียนพื้นฐาน Python',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {},
              iconSize: 30,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: SingleChildScrollView(
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
                    ],
                  ),
                  const SizedBox(height: 50),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 300,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 145, 210, 77),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 7),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 213, 255, 168),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.diamond_outlined,
                                  size: 15,
                                  color: Color.fromARGB(255, 101, 135, 64),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '500 Points',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 101, 135, 64),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            formatTime(totalSeconds),
                            style: const TextStyle(
                              fontFamily: 'Barlow',
                              fontSize: 75,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'MINUTE',
                            style: TextStyle(
                              fontFamily: 'Barlow',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: FloatingActionButton(
                      backgroundColor: const Color.fromARGB(255, 96, 137, 52),
                      onPressed: toggleTimer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isPlaying ? "Tap to Pause" : "Tap to Start",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 78, 111, 42),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 80),
                  OutlinedButton(
                    onPressed: () {
                      // ใส่ logic สำหรับการกดปุ่ม Give Up ที่นี่
                      if (isPlaying) {
                        stopTimer();
                      }
                      setState(() {
                        totalSeconds = 120 * 60; // รีเซ็ตเวลากลับเป็น 120 นาที
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 104, 151, 57),
                        width: 2,
                      ),
                    ),
                    child: const Text(
                      'Give Up',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 78, 111, 42),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
