import 'package:goal_quest/models/models.dart';

abstract class PointRepository {
  Future<List<PointModel>> loadPoint();
}
