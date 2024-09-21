import 'package:goal_quest/models/models.dart';

abstract class TaskRepository{
  Future<List<TaskModel>> loadTask();
  Future<List<TaskModel>> searchTask(String key);
  Future<void> addTask({
    required String title,
    required String taskType,
    required int repeatDays,
    required int duration,
    required DateTime startDate,
    required DateTime endDate,});
}
