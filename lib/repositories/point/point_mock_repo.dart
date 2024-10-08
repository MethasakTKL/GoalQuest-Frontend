import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';

class PointMockRepository extends PointRepository {
  List<PointModel> points = [
    PointModel(
      pointId: 1,
      userId: 1,
      totalPoint: 100,
      lastearnedAt: DateTime.now(),
    ),
    PointModel(
      pointId: 2,
      userId: 3,
      totalPoint: 1000,
      lastearnedAt: DateTime.now(),
    ),
  ];
  @override
  Future<List<PointModel>> loadPoint() async {
    await Future.delayed(const Duration(seconds: 0));
    return points;
  }
}
