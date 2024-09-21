sealed class TaskEvent {}

class LoadTaskEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;
  final String taskType;
  final int? repeatDays;
  final int? duration;
  final DateTime startDate;
  final DateTime endDate;
  AddTaskEvent(
    this.title,
    this.taskType,
    this.repeatDays,
    this.duration,
    this.startDate,
    this.endDate,
  );
}

class SearchTaskEvent extends TaskEvent {
  final String key;
  SearchTaskEvent(this.key);
}

class SearchTaskClearEvent extends TaskEvent {}
