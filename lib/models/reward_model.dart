import 'package:equatable/equatable.dart';

class RewardModel extends Equatable {
  final int rewardId;
  final String rewardTitle;
  final String rewardDescription;
  final int rewardPoints;
  
  const RewardModel({
    required this.rewardId,
    required this.rewardTitle,
    required this.rewardDescription,
    required this.rewardPoints,
  });

  @override List<Object?> get props => [
    rewardId,
    rewardTitle,
    rewardDescription,
    rewardPoints,
  ];
}