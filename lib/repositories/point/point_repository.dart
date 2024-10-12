import 'package:goal_quest/models/models.dart';

abstract class PointRepository {
  Future<PointModel> getCurrentUserPoint();
  Future<List<PointModel>> getAllPoints();
}
