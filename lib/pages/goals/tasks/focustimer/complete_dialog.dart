import 'package:flutter/material.dart';

void showCompleteDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // ไม่ให้ปิด dialog โดยคลิกด้านนอก
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Complete!'),
        content: const Text('You have completed the focus session!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog
              Navigator.of(context).pop(); // กลับไปหน้าก่อนหน้า
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
