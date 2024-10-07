import 'package:equatable/equatable.dart';

class GoalModel extends Equatable{
  final int goalId;
  final String goalTitle;
  final String goalDescription;
  final int goalProgressPercent;


  const GoalModel({
    required this.goalId,
    required this.goalTitle,
    required this.goalDescription,
    this.goalProgressPercent = 0,
   
  });

  @override  List<Object?> get props => [
    goalId,
    goalTitle,
    goalDescription,
    goalProgressPercent,
  ];
}