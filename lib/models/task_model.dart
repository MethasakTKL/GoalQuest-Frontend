import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final int id;
  final String title;
  final String taskType;
  final int? repeatDays;
  final int? duration;
  final int taskCount;
  final bool taskisDone;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? lastAction;
  final DateTime? nextAction;

  TaskModel({
    required this.id,
    required this.title,
    required this.taskType,
    this.taskCount = 0,
    this.taskisDone = false,
    this.repeatDays,
    this.duration,
    required this.startDate,
    required this.endDate,
    this.lastAction, required nextAction,
  }) : nextAction = lastAction != null && repeatDays != null
          ? lastAction.add(Duration(days: repeatDays))
          : repeatDays != null
              ? DateTime.now().add(Duration(days: repeatDays))
              : null;


  @override
  List<Object?> get props => [
        id,
        title,
        taskType,
        repeatDays,
        duration,
        startDate,
        endDate,
        lastAction
      ];
}
