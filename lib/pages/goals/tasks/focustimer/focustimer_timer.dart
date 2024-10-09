import 'package:flutter/material.dart';
import 'dart:async';
import 'giveup_dialog.dart';
import 'complete_dialog.dart';

class FocusTimerPage extends StatefulWidget {
  const FocusTimerPage({super.key});

  @override
  State<FocusTimerPage> createState() => _FocusTimerPageState();
}

class _FocusTimerPageState extends State<FocusTimerPage> {
  bool isPlaying = false;
  int totalSeconds = 1 * 60; // เวลาเริ่มต้นในหน่วยวินาที
  int static_timer = 1 * 60;
  late Timer timer;
  late Timer cancelTimer;
  int points = 500;
  bool showGiveUp = false;
  bool isCancelable = true;
  int? initialSeconds; // เก็บค่าเวลาเริ่มต้นในแต่ละรอบ

  @override
  void initState() {
    super.initState();
    updatePoints();
  }

  @override
  void dispose() {
    if (isPlaying) {
      timer.cancel();
    }
    if (cancelTimer.isActive) {
      cancelTimer.cancel();
    }
    super.dispose();
  }

  void startTimer() {
    setState(() {
      initialSeconds ??= totalSeconds;

      isCancelable = true; // รีเซ็ตสถานะการ cancel
      showGiveUp = true; // แสดงปุ่ม give up เมื่อเริ่มจับเวลาใหม่

      // ตั้งเวลาสำหรับให้ Cancel ได้ใน 10 วินาทีแรก
      cancelTimer = Timer(const Duration(seconds: 10), () {
        setState(() {
          isCancelable = false; // เมื่อครบ 10 วินาทีแล้วจะไม่สามารถ Cancel ได้
        });
      });
    });

    // เริ่มต้นการนับเวลา
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (totalSeconds > 0) {
          totalSeconds--;
          updatePoints();
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
      if (totalSeconds == 0) {
        showCompleteDialog(
            context); // เรียก Complete Dialog เมื่อเวลาเป็น 00:00
      }
    });
  }

  void resetTimer() {
    setState(() {
      timer.cancel(); // หยุดการนับเวลา
      totalSeconds =
          initialSeconds ?? totalSeconds; // รีเซ็ตเวลาไปยังค่าเริ่มต้น
      isPlaying = false; // หยุดการเล่น
      showGiveUp = false; // ซ่อนปุ่ม Give Up หลังจากการรีเซ็ต
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

  void handleGiveUp() {
    stopTimer();
    setState(() {
      totalSeconds =
          initialSeconds ?? totalSeconds; // รีเซ็ตเวลาเป็นเวลาเริ่มต้น
      updatePoints();
      showGiveUp = false; // ซ่อนปุ่ม Give Up
    });
  }

  void showConfirmationDialog() {
    showGiveUpDialog(context, handleGiveUp);
  }

  void updatePoints() {
    setState(() {
      if (static_timer >= 120 * 60) {
        points = 500;
      } else if (static_timer >= 90 * 60) {
        points = 400;
      } else if (static_timer >= 60 * 60) {
        points = 300;
      } else if (static_timer >= 45 * 60) {
        points = 200;
      } else if (static_timer >= 30 * 60) {
        points = 100;
      } else if (static_timer >= 1 * 60) {
        points = 50;
      } else {
        points = 0;
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
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.diamond_outlined,
                                  size: 15,
                                  color: Color.fromARGB(255, 101, 135, 64),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '$points Points',
                                  style: const TextStyle(
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
                      color: Color.fromARGB(255, 35, 75, 20),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (showGiveUp)
                    OutlinedButton(
                      onPressed:
                          isCancelable ? resetTimer : showConfirmationDialog,
                      // กด Cancel จะหยุดจับเวลาในช่วง 10 วินาทีแรก, กด Give Up จะแสดง dialog
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
                      child: Text(
                        isCancelable ? 'Cancel' : 'Give Up',
                        style: const TextStyle(
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
