sealed class RewardEvent {}

class LoadRewardEvent extends RewardEvent {}

class RedeemRewardEvent extends RewardEvent{
  final int rewardId;
  RedeemRewardEvent({required this.rewardId});
}