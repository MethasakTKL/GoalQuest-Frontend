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
    await Future.delayed(const Duration(seconds: 0));
    tasks.sort((a,b) => a.startDate.compareTo(b.startDate));
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

  @override
  Future<void> actionTask({required int id, required DateTime lastAction}) async{
    await Future.delayed(const Duration(seconds: 0));
    final index = tasks.indexWhere((task) => task.id == id);
    tasks[index] = TaskModel(id: id, title: tasks[index].title, taskType: tasks[index].taskType, repeatDays: tasks[index].repeatDays, duration: tasks[index].duration, startDate: tasks[index].startDate, endDate:  tasks[index].endDate, lastAction: lastAction, nextAction:  tasks[index].nextAction);
  }
}
