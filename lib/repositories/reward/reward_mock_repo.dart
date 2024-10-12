import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';

class RewardMockRepository extends RewardRepository{
  List<RewardModel> rewards = [
    // const RewardModel(
    //   rewardId: 1,
    //   rewardTitle: 'Test1',
    //   rewardDescription: 'Test1',
    //   rewardPoints: 100,
    // ),
    // const RewardModel(
    //   rewardId: 2,
    //   rewardTitle: 'Test2',
    //   rewardDescription: 'Test2',
    //   rewardPoints: 200,
    // )
  ];

  @override
  Future<List<RewardModel>> getAllRewards() async{
    await Future.delayed(const Duration(seconds: 0));
    return rewards;
  }

  @override
  Future<RewardModel> redeemReward({required int rewardId}) async{
    final reward = rewards.firstWhere((reward) => reward.rewardId == rewardId);
    return reward;
  }
  

}