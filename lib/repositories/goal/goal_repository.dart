import 'package:goal_quest/models/models.dart';

abstract class GoalRepository {
  Future<List<GoalModel>> loadGoal();
  Future<void> addGoal({
    required String goalTitle,
    required String goalDescription,
  });
  Future<void> deleteGoal(int goalId) async {
    // โค้ดสำหรับลบ goal จากฐานข้อมูล
  }

  Future<void> updateGoal({
    required int goalId,
    required String newTitle,
    required String newDescription,
  }) async {
    // โค้ดสำหรับแก้ไข goal ในฐานข้อมูล
  }
}
