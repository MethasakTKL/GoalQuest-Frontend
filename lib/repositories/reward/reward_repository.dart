import 'package:goal_quest/models/models.dart';

abstract class RewardRepository{
  Future<List<RewardModel>> getAllRewards();
  Future<RewardModel> redeemReward({required int rewardId});
}