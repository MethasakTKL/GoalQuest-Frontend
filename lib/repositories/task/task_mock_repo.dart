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
  }
}