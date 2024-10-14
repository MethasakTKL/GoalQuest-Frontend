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

class ClickTaskEvent extends TaskEvent {
  final int id;
  final DateTime lastAction;
  
  ClickTaskEvent(this.id, this.lastAction);
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

class GiveUpTaskEvent extends TaskEvent {
  final int id;
  GiveUpTaskEvent(this.id);
}

class SearchTaskClearEvent extends TaskEvent {}
