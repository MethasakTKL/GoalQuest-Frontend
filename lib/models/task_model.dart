import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String taskType;
  final int taskPoints;
  final int? repeatDays;
  final int? duration;
  final int taskCount;
  final bool taskisDone;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime? lastAction;
  final DateTime? nextAction;
  final int goalId;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.taskType,
    required this.taskPoints,
    this.taskCount = 0,
    required this.taskisDone,
    this.repeatDays,
    this.duration,
    required this.startDate,
     this.endDate,
    this.lastAction,
    required nextAction,
    required this.goalId,
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

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['task_id'],
      title: json['title'],
      description: json['description'],
      taskType: json['task_type'],
      taskPoints: json['task_point'],
      repeatDays: json['repeat_day'],
      duration: json['task_duration'],
      taskCount: json['task_count'],
      taskisDone: json['is_completed'],
      startDate: DateTime.parse(json['start_date']),
      endDate: json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
      lastAction: json['last_action'] != null
          ? DateTime.parse(json['last_action'])
          : null,
      nextAction: json['next_action'] != null
          ? DateTime.parse(json['next_action'])
          : null,
      goalId: json['goal_id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'task_id': id,
      'title': title,
      'description': description,
      'task_type': taskType,
      'task_point': taskPoints,
      'repeat_day': repeatDays,
      'task_duration': duration,
      'task_count': taskCount,
      'is_completed': taskisDone,
      'start_date': startDate.toIso8601String(),
      'due_date': endDate?.toIso8601String(),
      'last_action': lastAction?.toIso8601String(),
      'next_action': nextAction?.toIso8601String(),
      'goal_id': goalId,
    };
  }

  factory TaskModel.empty() {
    return TaskModel(
      id: 0,
      title: '',
      description: '',
      taskType: '',
      taskPoints: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      goalId: 0,
      nextAction: null,
      repeatDays: 0,
      duration: 0,
      taskCount: 0,
      taskisDone: false,
      lastAction: null,
    );
  }
  @override
  List<Object?> get props => [
        id,
        title,
        description,
        taskType,
        taskPoints,
        goalId,
        taskCount,
        taskisDone,
        repeatDays,
        duration,
        startDate,
        endDate,
        lastAction
      ];
}

class TaskModelList extends Equatable {
  final List<TaskModel> tasks;

  const TaskModelList({required this.tasks});

  factory TaskModelList.fromJson(List<dynamic> json) {
    List<TaskModel> tasks = [];
    for (var taskJson in json) {
      tasks.add(TaskModel.fromJson(taskJson));
    }
    return TaskModelList(tasks: tasks);
  }

  Map<String, dynamic> toJson() {
    return {
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [tasks];
}
