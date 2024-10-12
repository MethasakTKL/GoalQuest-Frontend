import 'package:equatable/equatable.dart';

class GoalModel extends Equatable {
  final int goalId;
  final String goalTitle;
  final String goalDescription;
  final double goalProgressPercent;
  final bool isCompleted;

  const GoalModel({
    required this.goalId,
    required this.goalTitle,
    required this.goalDescription,
    this.goalProgressPercent = 0,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [
        goalId,
        goalTitle,
        goalDescription,
        goalProgressPercent,
      ];
}
