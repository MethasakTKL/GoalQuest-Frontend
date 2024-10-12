sealed class GoalEvent {}

class LoadGoalEvent extends GoalEvent {}

class AddGoalEvent extends GoalEvent {
  final String goalTitle;
  final String goalDescription;
  AddGoalEvent(this.goalTitle, this.goalDescription);
}

class DeleteGoalEvent extends GoalEvent {
  final int goalId;
  DeleteGoalEvent(this.goalId);
}

class EditGoalEvent extends GoalEvent {
  final int goalId;
  final String updatedTitle;
  final String updatedDescription;

  EditGoalEvent({
    required this.goalId,
    required this.updatedTitle,
    required this.updatedDescription,
  });
}
