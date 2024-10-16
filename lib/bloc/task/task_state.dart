import 'package:goal_quest/models/models.dart';

sealed class TaskState{
  final List<TaskModel> tasks;
  final String error;
  TaskState({required this.tasks, this.error = ''});
}

const List<TaskModel> emptyTasks = [];
class LodingTaskState extends TaskState{
  LodingTaskState(): super(tasks: emptyTasks);
}

class ReadyTaskState extends TaskState{
  ReadyTaskState({required super.tasks});
}

class SearchTaskState extends TaskState{
  SearchTaskState({required super.tasks});
}

class ErrorTaskState extends TaskState {
  ErrorTaskState({required super.error}) : super(tasks: emptyTasks);
}