import 'package:flutter/material.dart';
import 'dart:async';
import 'giveup_dialog.dart';
import 'complete_dialog.dart';

class FocusTimerPage extends StatefulWidget {
  final int taskId;
  final int taskDuration; // ตัวแปร duration
  final String taskName; // ตัวแปร task name

  const FocusTimerPage(
      {super.key,
      required this.taskDuration,
      required this.taskName,
      required this.taskId});

  @override
  State<FocusTimerPage> createState() => _FocusTimerPageState();
}

class _FocusTimerPageState extends State<FocusTimerPage> {
  bool isPlaying = false;
  late int totalSeconds;
  late int static_timer;
  late Timer timer;
  Timer? cancelTimer;
  int points = 500;
  bool showGiveUp = false;
  bool isCancelable = true;
  int? initialSeconds;

  @override
  void initState() {
    super.initState();

    totalSeconds = widget.taskDuration * 60;
    static_timer = widget.taskDuration * 60;

    updatePoints();
  }

  @override
  void dispose() {
    if (isPlaying) {
      timer.cancel();
    }
    cancelTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      initialSeconds ??= totalSeconds;
      isCancelable = true;
      showGiveUp = true;

      cancelTimer = Timer(const Duration(seconds: 10), () {
        setState(() {
          isCancelable = false;
        });
      });
    });

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
        showCompleteDialog(context, widget.taskId);
      }
    });
  }

  void resetTimer() {
    setState(() {
      timer.cancel();
      totalSeconds = initialSeconds ?? totalSeconds;
      isPlaying = false;
      showGiveUp = false;
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
      totalSeconds = initialSeconds ?? totalSeconds;
      updatePoints();
      showGiveUp = false;
    });
  }

  void showConfirmationDialog() {
    showGiveUpDialog(context, handleGiveUp);
  }

  void updatePoints() {
    setState(() {
      if (static_timer >= 150 * 60) {
        points = 800;
      } else if (static_timer >= 120 * 60) {
        points = 700;
      } else if (static_timer >= 100 * 60) {
        points = 600;
      } else if (static_timer >= 90 * 60) {
        points = 520;
      } else if (static_timer >= 60 * 60) {
        points = 430;
      } else if (static_timer >= 45 * 60) {
        points = 350;
      } else if (static_timer >= 30 * 60) {
        points = 270;
      } else if (static_timer >= 15 * 60) {
        points = 190;
      } else if (static_timer >= 10 * 60) {
        points = 130;
      } else if (static_timer >= 5 * 60) {
        points = 60;
      } else if (static_timer >= 1 * 60) {
        points = 10;
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
            Text(
              widget.taskName, // แสดงชื่อ task แทนที่ข้อความเดิม
              style: const TextStyle(
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
