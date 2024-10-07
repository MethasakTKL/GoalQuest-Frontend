import 'package:goal_quest/models/models.dart';

abstract class GoalRepository {
 Future<List<GoalModel>> loadGoal();
 Future<void> addGoal({
  required String goalTitle,
  required String goalDescription,
  });
}