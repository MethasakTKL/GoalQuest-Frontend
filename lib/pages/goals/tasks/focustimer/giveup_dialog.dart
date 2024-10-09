import 'package:flutter/material.dart';

void showGiveUpDialog(BuildContext context, VoidCallback onConfirm) {
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 1),
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
              padding: const EdgeInsets.only(right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด dialog
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Color.fromARGB(255, 2, 2, 2)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด dialog
                      Navigator.of(context).pop(); // กลับไปหน้าก่อนหน้า
                      onConfirm(); // เรียก callback เมื่อยืนยันการยอมแพ้
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
