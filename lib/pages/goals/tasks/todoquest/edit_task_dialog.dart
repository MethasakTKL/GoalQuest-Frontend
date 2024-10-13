import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';

Future<void> showEditTaskDialog(BuildContext context, int taskId) async {
  final TextEditingController goalTitleController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        contentPadding:
            const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Edit Task'),
            IconButton(
              icon: const Icon(Icons.delete_sweep), // ใช้ไอคอนถังขยะ
              color:
                  const Color.fromARGB(255, 196, 82, 75), // เปลี่ยนสีเป็นสีแดง
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog
                showDeleteConfirmationDialog(
                    context, taskId); // แสดง Dialog ยืนยันการลบ
              },
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('What would you like to do with this task?'),
            const SizedBox(height: 10),
            TextField(
              controller: goalTitleController,
              decoration: const InputDecoration(
                labelText: 'Task Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Close the dialog without any action
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color.fromARGB(221, 44, 44, 44)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 208, 162, 88),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              String updatedGoalTitle =
                  goalTitleController.text; // Get the updated title
              if (updatedGoalTitle.isNotEmpty) {
                // Perform your edit logic here, e.g., updating the task name
                context
                    .read<TaskBloc>()
                    .add(EditTaskEvent(taskId, updatedGoalTitle));
              }
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              'Edit',
              style: TextStyle(color: Color.fromARGB(221, 255, 255, 255)),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> showDeleteConfirmationDialog(
    BuildContext context, int taskId) async {
  final tasks = context.read<TaskBloc>().state.tasks.toList();

  // Debug task list and ID
  debugPrint("Total tasks: ${tasks.length}");
  debugPrint("Task ID: $taskId");

  final selectedTask = tasks.firstWhere((task) => task.id == taskId);

  debugPrint("Selected task ID: ${selectedTask.id}");

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              debugPrint("Deleting task with ID: ${selectedTask.id}");
              context.read<TaskBloc>().add(DeleteTaskEvent(selectedTask.id));
              Navigator.of(context).pop(); // Close the confirmation dialog

              // เรียก LoadTaskEvent เพื่อรีเฟรชรายการ tasks
              context.read<TaskBloc>().add(LoadTaskEvent());
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Color.fromARGB(221, 44, 44, 44)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 208, 154, 67),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog without deleting
            },
            child: const Text(
              'No',
              style: TextStyle(color: Color.fromARGB(221, 255, 255, 255)),
            ),
          ),
        ],
      );
    },
  );
}
