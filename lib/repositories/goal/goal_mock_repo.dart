import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';

class GoalMockRepository extends GoalRepository{
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
  Future<List<GoalModel>> loadGoal() async{
    await Future.delayed(const Duration(seconds: 0));
    return goals;
  }

  @override
  Future<GoalModel> addGoal(
      {required String goalTitle,
        required String goalDescription,}) async {
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
}