import 'package:goal_quest/models/models.dart';

abstract class EarnedRepository {
  Future<List<EarnedModel>> loadEarned();
}