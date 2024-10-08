import 'package:flutter/material.dart';
import 'dart:async';

class FocusTimerPage extends StatefulWidget {
  const FocusTimerPage({super.key});

  @override
  State<FocusTimerPage> createState() => _FocusTimerPageState();
}

class _FocusTimerPageState extends State<FocusTimerPage> {
  bool isPlaying = false;
  int totalSeconds = 120 * 60; // เวลาเริ่มต้นในหน่วยวินาที
  int static_timer = 120 * 60;
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
      // ถ้าเป็นการเริ่มนับครั้งแรก ให้ตั้งค่า initialSeconds
      if (initialSeconds == null) {
        initialSeconds = totalSeconds;
        isCancelable = true;
        showGiveUp = true;

        // ตั้งเวลาสำหรับให้ Cancel ได้ใน 10 วินาทีแรก
        cancelTimer = Timer(const Duration(seconds: 10), () {
          setState(() {
            isCancelable =
                false; // เมื่อครบ 10 วินาทีแล้วจะไม่สามารถ Cancel ได้
            // showGiveUp จะถูกเซ็ตไว้ให้เป็น true ในช่วงนี้
          });
        });
      }
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
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 400, // กำหนดความกว้าง
          height: 200, // กำหนดความสูง

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Confirm your surrender',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.flag_outlined,
                      color: Color.fromARGB(255, 25, 25, 25),
                      size: 30.0,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    Text(
                      'Are you sure you want to give up?',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text('You will lose 30 points.'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                  right: 18.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // ปิดกล่องข้อความ
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Color.fromARGB(255, 2, 2, 2)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // ปิดกล่องข้อความ
                        handleGiveUp(); // เรียกใช้ handleGiveUp เมื่อยืนยัน
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 63, 87, 38),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10), // ขนาดของปุ่ม
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // ขอบมน
                        ),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (showGiveUp)
                    OutlinedButton(
                      onPressed:
                          showConfirmationDialog, // เรียกฟังก์ชันสำหรับแสดง dialog
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
