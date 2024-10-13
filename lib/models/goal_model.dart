import 'package:equatable/equatable.dart';

class GoalModel extends Equatable {
  final int goalId;
  final int userId;
  final String goalTitle;
  final String goalDescription;
  final double goalProgressPercent;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isCompleted;

  const GoalModel(
      {required this.goalId,
      required this.userId,
      required this.goalTitle,
      required this.goalDescription,
      required this.goalProgressPercent,
      required this.startDate,
      required this.endDate,
      required this.createdAt,
      required this.updatedAt,
      required this.isCompleted});

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
        goalId: json['goal_id'],
        userId: json['user_id'],
        goalTitle: json['title'],
        goalDescription: json['description'],
        goalProgressPercent: json['progress_percentage'],
        startDate: DateTime.parse(json['start_date']),
        endDate: DateTime.parse(json['end_date']),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        isCompleted: json['is_complete']);
  }
  Map<String, dynamic> toJson() {
    return {
      'goal_id': goalId,
      'user_id': userId,
      'title': goalTitle,
      'description': goalDescription,
      'progress_percentage': goalProgressPercent,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_complete': isCompleted
    };
  }

  factory GoalModel.empty() {
    return GoalModel(
        goalId: 0,
        userId: 0,
        goalTitle: '',
        goalDescription: '',
        goalProgressPercent: 0,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isCompleted: false);
  }
  @override
  List<Object?> get props => [
        goalId,
        userId,
        goalTitle,
        goalDescription,
        goalProgressPercent,
        startDate,
        endDate,
        createdAt,
        updatedAt,
        isCompleted,
      ];
}

class GoalModelList extends Equatable {
  final List<GoalModel> goals;

  const GoalModelList({required this.goals});

  factory GoalModelList.fromJson(List<dynamic> json) {
    List<GoalModel> goals = [];
    for (var goal in json) {
      goals.add(GoalModel.fromJson(goal));
    }
    return GoalModelList(goals: goals);
  }

  Map<String, dynamic> toJson() {
    return {
      'goals': goals.map((goal) => goal.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        goals,
      ];
}
