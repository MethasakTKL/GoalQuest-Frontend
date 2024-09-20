import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';

class TaskMockRepository extends TaskRepository{
  @override
  Future<List<TaskModel>> loadTask() async {
    return [
      TaskModel(
        id: 1,
        title: 'Task 1',
        taskType: 'TodoQuest',
        repeatDays: 1,
        duration: null,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 7)),
        lastAction: null,
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
      ),
    ];
  }
}