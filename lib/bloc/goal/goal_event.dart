sealed class GoalEvent {}

class LoadGoalEvent extends GoalEvent {}

class AddGoalEvent extends GoalEvent {
  final String goalTitle;
  final String goalDescription;
  AddGoalEvent(this.goalTitle, this.goalDescription);
}
