import 'package:goal_quest/models/models.dart';

sealed class GoalState{
  final List<GoalModel> goals;
  final String error;
  GoalState({required this.goals, this.error = ''});
}

const List<GoalModel> emptyGoals = [];
class LodingGoalState extends GoalState{
  LodingGoalState(): super(goals: emptyGoals);
}
class ReadyGoalState extends GoalState{
  ReadyGoalState({required super.goals});
}
class ErrorGoalState extends GoalState {
  ErrorGoalState({required super.error}) : super(goals: emptyGoals);
}