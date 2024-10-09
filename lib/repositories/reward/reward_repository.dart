import 'package:goal_quest/models/models.dart';

abstract class RewardRepository{
  Future<List<RewardModel>> getAlllRewards();
}