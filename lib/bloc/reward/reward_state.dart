import 'package:goal_quest/models/models.dart';

sealed class RewardState{
  final List<RewardModel> rewards;
  final String error;
  RewardState({required this.rewards, this.error = ''});
}

const List<RewardModel> emptyRewards = [];

class LodingRewardState extends RewardState{
  LodingRewardState(): super(rewards: emptyRewards);
}

class ReadyRewardState extends RewardState{
  ReadyRewardState({required super.rewards});
}

class ErrorRewardState extends RewardState{
  ErrorRewardState({required super.error}) : super(rewards: emptyRewards);
}

class RewardRedeemedState extends RewardState{
  final int rewardId;
  RewardRedeemedState({required super.rewards, required this.rewardId});
}