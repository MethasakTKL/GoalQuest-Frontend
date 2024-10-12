import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';

class GoalMockRepository extends GoalRepository {
  List<GoalModel> goals = [
    const GoalModel(
      goalId: 1,
      goalTitle: 'ออกกำลังกาย',
      goalDescription: 'สำหรับออกกำลังกาย',
      goalProgressPercent: 0.5,
    ),
    const GoalModel(
      goalId: 2,
      goalTitle: 'อ่านหนังสือ',
      goalDescription: 'สำหรับอ่านหนังสือ',
      goalProgressPercent: 0,
    ),
  ];

  int lastId = 2;

  @override
  Future<List<GoalModel>> loadGoal() async {
    await Future.delayed(const Duration(seconds: 0));
    return goals;
  }

  @override
  Future<GoalModel> addGoal({
    required String goalTitle,
    required String goalDescription,
  }) async {
    await Future.delayed(const Duration(seconds: 0));
    int goalid = lastId + 1;
    lastId++;
    GoalModel newGoal = GoalModel(
      goalId: goalid,
      goalTitle: goalTitle,
      goalDescription: goalDescription,
      goalProgressPercent: 0,
    );
    goals.add(newGoal);
    return newGoal;
  }

  @override
  Future<void> updateGoal({
    required int goalId,
    required String newTitle,
    required String newDescription,
  }) async {
    await Future.delayed(const Duration(seconds: 0));

    GoalModel? existingGoal = goals.firstWhere(
      (goal) => goal.goalId == goalId,
      orElse: () => throw Exception('Goal not found'),
    );

    // สร้าง goal ใหม่พร้อมกับข้อมูลที่แก้ไข
    GoalModel updatedGoal = GoalModel(
      goalId: existingGoal.goalId,
      goalTitle: newTitle,
      goalDescription: newDescription,
      goalProgressPercent: existingGoal.goalProgressPercent,
    );

    // แทนที่ goal ที่มีอยู่ใน list ด้วย goal ที่แก้ไขแล้ว
    goals[goals.indexOf(existingGoal)] = updatedGoal;
  }

  @override
  Future<void> deleteGoal(int goalId) async {
    await Future.delayed(const Duration(seconds: 0));

    // ค้นหา goal ที่ต้องการลบ
    GoalModel? existingGoal = goals.firstWhere(
      (goal) => goal.goalId == goalId,
      orElse: () => throw Exception('Goal not found'),
    );

    // ลบ goal ที่พบ
    goals.remove(existingGoal);
  }
}
