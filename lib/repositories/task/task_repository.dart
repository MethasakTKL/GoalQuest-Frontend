import 'package:goal_quest/models/models.dart';

abstract class TaskRepository{
  Future<List<TaskModel>> loadTask();
}