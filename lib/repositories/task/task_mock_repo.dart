import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';

class TaskMockRepository extends TaskRepository {
  List<TaskModel> tasks = [
    TaskModel(
      id: 1,
      title: 'Task 1',
      taskType: 'TodoQuest',
      repeatDays: 1,
      taskCount: 10,
      duration: null,
      startDate: DateTime(2024, 9, 10),
      endDate: DateTime.now().add(const Duration(days: 7)),
      lastAction: null,
      nextAction: DateTime.now(),
    ),
    TaskModel(
      id: 2,
      title: 'Task 2',
      taskType: 'FocusTimer',
      repeatDays: null,
      taskCount: 0,
      duration: 30,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 7)),
      lastAction: null,
      nextAction: null,
    ),
    TaskModel(
      id: 3,
      title: 'Task 3',
      taskType: 'TodoQuest',
      repeatDays: 4,
      taskCount: 0,
      duration: null,
      startDate: DateTime(2024, 9, 10),
      endDate: DateTime.now().add(const Duration(days: 7)),
      lastAction: DateTime(2024, 9, 10),
      nextAction: DateTime(2024, 9, 14),
    ),
    TaskModel(
      id: 4,
      title: 'Task 4',
      taskType: 'FocusTimer',
      repeatDays: null,
      taskCount: 0,
      duration: 100,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 7)),
      lastAction: null,
      nextAction: null,
    ),
  ];

  int lastId = 5;

  @override
  Future<List<TaskModel>> loadTask() async {
    await Future.delayed(const Duration(seconds: 0));
    return tasks;
  }

  @override
  Future<List<TaskModel>> searchTask(String key) async {
    await Future.delayed(const Duration(seconds: 0));
    return tasks.where((task) => task.title.contains(key)).toList();
  }

  @override
  Future<TaskModel> addTask(
      {required String title,
      required String taskType,
      required int? repeatDays,
      required int? duration,
      required DateTime startDate,
      required DateTime endDate}) async {
    await Future.delayed(const Duration(seconds: 0));
    int id = lastId + 1;
    lastId++;
    TaskModel newTask = TaskModel(
        id: id,
        title: title,
        taskType: taskType,
        repeatDays: repeatDays,
        duration: duration,
        startDate: startDate,
        endDate: endDate,
        lastAction: null,
        nextAction: startDate);
    tasks.add(newTask);
    return newTask;
  }

  @override
  Future<void> actionTask(
      {required int id,
      required DateTime lastAction,
      required int taskCount}) async {
    await Future.delayed(const Duration(seconds: 0));
    final index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      final task = tasks[index];
      DateTime? nextAction = task.nextAction;

      // ตรวจสอบว่า task ทำในวันเดียวกันแล้วหรือไม่
      bool isSameDay = task.lastAction != null &&
          task.lastAction!.year == lastAction.year &&
          task.lastAction!.month == lastAction.month &&
          task.lastAction!.day == lastAction.day;

      // ถ้าไม่ใช่วันเดียวกัน ให้คำนวณ nextAction
      if (!isSameDay && task.repeatDays != null) {
        nextAction = lastAction.add(Duration(days: task.repeatDays!));
      }

      // ถ้ามี repeatDays ให้คำนวณวันที่ถัดไป
      if (task.repeatDays != null) {
        nextAction = lastAction.add(Duration(days: task.repeatDays!));
      }

      tasks[index] = TaskModel(
        id: id,
        title: task.title,
        taskType: task.taskType,
        repeatDays: task.repeatDays,
        duration: task.duration,
        startDate: task.startDate,
        endDate: task.endDate,
        lastAction: lastAction,
        nextAction: nextAction,
        taskCount: task.taskCount + 1, // เพิ่ม taskCount เมื่อทำ action
      );
    }
  }
}
