sealed class TaskEvent {}

class LoadTaskEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final int goalId;
  final String title;
  final String taskType;
  final int? repeatDays;
  final int? duration;
  final DateTime startDate;
  final DateTime endDate;
  AddTaskEvent(
    this.goalId,
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

class ActionTaskEvent extends TaskEvent {
  final int id;
  final DateTime lastAction;
  final int taskCount;
  ActionTaskEvent(this.id, this.lastAction, this.taskCount);
}

class DeleteTaskEvent extends TaskEvent {
  final int id;
  DeleteTaskEvent(this.id);
}

class EditTaskEvent extends TaskEvent {
  final int id;
  final String newTitle;

  EditTaskEvent(this.id, this.newTitle);
}

class CompleteTaskEvent extends TaskEvent{
  final int id;
  CompleteTaskEvent(this.id);
}

class SearchTaskClearEvent extends TaskEvent {}
