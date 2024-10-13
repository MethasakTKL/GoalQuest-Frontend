import 'package:goal_quest/models/models.dart';

abstract class GoalRepository {
  Future<List<GoalModel>> loadGoal();
  Future<void> addGoal({
    required String goalTitle,
    required String goalDescription,
  });
  Future<GoalModel> getGoalId({required int goalId});
  Future<void> deleteGoal({
    required int goalId});

  Future<void> updateGoal({
    required int goalId,
    required String newTitle,
    required String newDescription,
  });
}
