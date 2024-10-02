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
    this.lastAction,
    required nextAction,
  }) : nextAction = nextAction ??
            _calculateNextAction(lastAction, repeatDays, startDate);

  // ฟังก์ชันคำนวณ nextAction
  static DateTime? _calculateNextAction(
      DateTime? lastAction, int? repeatDays, DateTime startDate) {
    if (repeatDays == null) return null;

    // ถ้ามี lastAction ให้คำนวณจาก lastAction
    if (lastAction != null) {
      return lastAction.add(Duration(days: repeatDays));
    }

    // ถ้าไม่มี lastAction ให้ใช้ startDate + repeatDays เป็น nextAction
    return startDate.add(Duration(days: repeatDays));
  }

  @override
  List<Object?> get props => [
        id,
        title,
        taskType,
        taskCount,
        taskisDone,
        repeatDays,
        duration,
        startDate,
        endDate,
        lastAction
      ];
}
