import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';

void showCompleteDialog(BuildContext context, int taskId) {
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
              context.read<TaskBloc>().add(CompleteTaskEvent(taskId));
              context.read<PointBloc>().add(LoadAllPointsEvent());
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
