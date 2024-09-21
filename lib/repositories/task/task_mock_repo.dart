import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';

class TaskMockRepository extends TaskRepository {
  List<TaskModel> tasks = [
    TaskModel(
      id: 1,
      title: 'Task 1',
      taskType: 'TodoQuest',
      repeatDays: 5,
      duration: null,
      startDate: DateTime(2024, 9, 10),
      endDate: DateTime.now().add(const Duration(days: 7)),
      lastAction: null,
      nextAction: null,
    ),
    TaskModel(
      id: 2,
      title: 'Task 2',
      taskType: 'FocusTimer',
      repeatDays: null,
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
      duration: 100,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 7)),
      lastAction: null,
      nextAction: null,
    ),
  ];

  int lastId = 4;

  @override
  Future<List<TaskModel>> loadTask() async {
    await Future.delayed(const Duration(seconds: 1));
    return tasks;
  }

  @override
  Future<TaskModel> addTask(
      {required String title,
      required String taskType,
      required int? repeatDays,
      required int? duration,
      required DateTime startDate,
      required DateTime endDate}) async {
    await Future.delayed(const Duration(seconds: 1));
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
        nextAction: null);
    tasks.add(newTask);
    return newTask;
  }
}
