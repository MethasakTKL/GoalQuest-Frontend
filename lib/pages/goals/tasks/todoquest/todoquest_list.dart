import 'package:flutter/material.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/pages/goals/tasks/todoquest/todoquest_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodoQuestList extends StatefulWidget {
  final int goalId;

  const TodoQuestList({super.key, required this.goalId});

  @override
  State<TodoQuestList> createState() => _TodoQuestListState();
}

class _TodoQuestListState extends State<TodoQuestList> {
  bool isCompletVisible = false;
  Map<int, bool> isCheckedMap =
      {}; // ใช้ map เพื่อจัดการค่า isChecked สำหรับแต่ละ task

  void toggleCheckBox(bool? newValue, int taskId) {
    setState(() {
      // สลับค่าของ isChecked ใน Map
      isCheckedMap[taskId] = newValue ?? false;
      debugPrint('Task $taskId checked state: ${isCheckedMap[taskId]}');

      if (isCheckedMap[taskId]!) {
        // เมื่อกดให้ Checkbox เป็น true
        debugPrint("Task $taskId completed, increment task count");
      } else {
        // เมื่อกดให้ Checkbox เป็น false
        debugPrint("Task $taskId unchecked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int goalId = ModalRoute.of(context)!.settings.arguments as int;
    final tasks = context.select((TaskBloc bloc) => bloc.state.tasks
        .where((task) => task.goalId == goalId && task.taskType == 'TodoQuest')
        .toList()); // เช็คว่า Task type เป็น TodoQuest ไหม
    final today = DateTime.now();

    final todayTasks = tasks.where((task) {
      if (task.nextAction == null) return false;
      // กรอง task ที่มี nextAction ตรงกับวันที่ปัจจุบัน
      final nextActionDate = task.nextAction!;
      final isTodayTask = nextActionDate.year == today.year &&
          nextActionDate.month == today.month &&
          nextActionDate.day == today.day;

      final duration = task.endDate?.difference(task.startDate);
      final repeatCount = duration!.inDays ~/ task.repeatDays!;
      return isTodayTask &&
          task.taskCount < repeatCount; // ต้องอยู่ในวันนี้และยังทำไม่ครบ
    }).toList();

    final nextTasks = tasks.where((task) {
      // ตรวจสอบว่ามันไม่ได้อยู่ใน todayTasks และ task นั้นยังไม่เสร็จ
      if (todayTasks.contains(task)) return false;
      final duration = task.endDate?.difference(task.startDate);
      final repeatCount = duration!.inDays ~/ task.repeatDays!;
      return task.taskCount <
          repeatCount; // taskCount ยังไม่ครบตาม repeatCount แปลว่ายังไม่เสร็จ
    }).toList();

    final completeTasks = tasks.where((task) {
      // คำนวณ repeatCount จากระยะเวลา (duration) ระหว่าง startDate และ endDate
      final duration = task.endDate?.difference(task.startDate);
      final repeatCount = duration!.inDays ~/
          task.repeatDays!; // จำนวนครั้งที่ต้องทำตาม repeatDays
      // ตรวจสอบว่า taskCount ถึง repeatCount หรือไม่
      return task.taskCount >= repeatCount;
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (todayTasks.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    'Today',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 63, 148, 69),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // ปิดการเลื่อนใน ListView
                  itemCount: todayTasks.length,
                  itemBuilder: (context, index) {
                    final task = todayTasks[index];
                    final isChecked = isCheckedMap[task.id] ?? false;
                    // Debug print task ID
                    debugPrint(
                        'Rendering TodoQuestItem with task ID: ${task.id}');
                    return TodoQuestItem(
                      key: ValueKey(task.id),
                      taskId: task.id,
                      cardColor: const Color.fromARGB(255, 173, 217, 98),
                      isChecked: isChecked,
                      title: task.title,
                      frequency: 'Every ${task.repeatDays} days',
                      lastDone: task.lastAction != null
                          ? DateFormat('d MMMM yyyy').format(task.lastAction!)
                          : 'Not started',
                      nextDue: task.nextAction != null
                          ? DateFormat('d MMMM yyyy').format(task.nextAction!)
                          : '-',
                      repeatDays: task.repeatDays ?? 1,
                      startDate: task.startDate,
                      taskCount: task.taskCount,
                      endDate: task.endDate!,
                      onChanged: (bool? newValue) {
                        if (newValue != null) {
                          toggleCheckBox(newValue, task.id);
                          context.read<TaskBloc>().add(ActionTaskEvent(
                              task.id, DateTime.now(), task.taskCount));
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          if (nextTasks.isNotEmpty)
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (nextTasks.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // ปิดการเลื่อนใน ListView
              itemCount: nextTasks.length,
              itemBuilder: (context, index) {
                final task = nextTasks[index];
                final isChecked = isCheckedMap[task.id] ?? false;
                // Debug print task ID
                debugPrint('Rendering TodoQuestItem with task ID: ${task.id}');
                return TodoQuestItem(
                  key: ValueKey(task.id),
                  taskId: task.id,
                  cardColor: Colors.grey[300]!,
                  isChecked: isChecked,
                  title: task.title,
                  frequency: 'Every ${task.repeatDays} days',
                  lastDone: task.lastAction != null
                      ? DateFormat('d MMMM yyyy').format(task.lastAction!)
                      : 'Not started',
                  nextDue: task.nextAction != null
                      ? DateFormat('d MMMM yyyy').format(task.nextAction!)
                      : '-',
                  repeatDays: task.repeatDays ?? 1,
                  startDate: task.startDate,
                  endDate: task.endDate!,
                  taskCount: task.taskCount,
                  onChanged: (bool? newValue) {
                    toggleCheckBox(newValue, task.id);
                    context.read<TaskBloc>().add(ActionTaskEvent(
                        task.id, DateTime.now(), task.taskCount));
                  },
                );
              },
            ),
          if (nextTasks.isEmpty && todayTasks.isEmpty)
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                'No TodoQuest',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          if (completeTasks.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                children: [
                  const Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isCompletVisible = !isCompletVisible;
                        debugPrint('isCompletVisible: $isCompletVisible');
                      });
                    },
                    icon: Icon(isCompletVisible
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right),
                    iconSize: 26.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          if (isCompletVisible && completeTasks.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // ปิดการเลื่อนใน ListView
              itemCount: completeTasks.length,
              itemBuilder: (context, index) {
                final task = completeTasks[index];
                final isChecked = isCheckedMap[task.id] ?? false;
                // Debug print task ID
                debugPrint('Rendering TodoQuestItem with task ID: ${task.id}');
                return TodoQuestItem(
                  key: ValueKey(task.id),
                  taskId: task.id,
                  cardColor: Colors.grey[300]!,
                  isChecked: isChecked,
                  title: task.title,
                  frequency: 'Every ${task.repeatDays} days',
                  lastDone: task.lastAction != null
                      ? DateFormat('d MMMM yyyy').format(task.lastAction!)
                      : 'Not started',
                  nextDue: task.nextAction != null
                      ? DateFormat('d MMMM yyyy').format(task.nextAction!)
                      : '-',
                  repeatDays: task.repeatDays ?? 1,
                  startDate: task.startDate,
                  endDate: task.endDate!,
                  taskCount: task.taskCount,
                  onChanged: (bool? newValue) {
                    toggleCheckBox(newValue, task.id);
                    context.read<TaskBloc>().add(ActionTaskEvent(
                        task.id, DateTime.now(), task.taskCount));
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
