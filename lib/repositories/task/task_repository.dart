import 'package:goal_quest/models/models.dart';

abstract class TaskRepository{
  Future<List<TaskModel>> loadTask();
  // Future<List<TaskModel>> searchTask(String key);
  Future<void> giveUpTask({required int id});
  Future<void> addTask({
    required int goalId,
    required String title,
    required String taskType,
    required int repeatDays,
    required int duration,
    required DateTime startDate,
    required DateTime endDate,});
  Future<void> deleteTask({required int id});
  Future<void> updateTask({
    required int id,
    required String newTitle,
  });
  Future<TaskModel> getTaskId({required int id});

  Future<void> completeTask({
    required int id,
  });

  Future<void> clickTask({
    required int id,
    required DateTime lastAction,
  });
}
