import 'package:equatable/equatable.dart';

class TaskModel extends Equatable{
  final int id;
  final String title;
  final String taskType;
  final int? repeatDays;
  final int? duration;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? lastAction;

  const TaskModel({
    required this.id,
    required this.title,
    required this.taskType,
    required this.repeatDays,
    required this.duration,
    required this.startDate,
    required this.endDate,
    required this.lastAction,
  });

  @override
  List<Object?> get props => [id, title, taskType, repeatDays, duration, startDate, endDate, lastAction];
}