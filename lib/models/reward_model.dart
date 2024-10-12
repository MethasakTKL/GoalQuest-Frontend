import 'package:equatable/equatable.dart';

class RewardModel extends Equatable {
  final int? rewardId;
  final String rewardTitle;
  final String rewardDescription;
  final int rewardPoints;
  final DateTime rewardUpdateAt;
  final DateTime rewardCreatedAt;


  const RewardModel({
    required this.rewardId,
    required this.rewardTitle,
    required this.rewardDescription,
    required this.rewardPoints,
    required this.rewardUpdateAt,
    required this.rewardCreatedAt,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      rewardId: json['reward_id'] != null ? json['reward_id'] as int : null,
      rewardTitle: json['title'],
      rewardDescription: json['description'],
      rewardPoints: json['points_required'],
      rewardUpdateAt: DateTime.parse(json['updated_at']),
      rewardCreatedAt: DateTime.parse(json['created_at']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'reward__id': rewardId,
      'title': rewardTitle,
      'description': rewardDescription,
      'points_required': rewardPoints,
      'updated_at': rewardUpdateAt.toIso8601String(),
      'created_at': rewardCreatedAt.toIso8601String(),
    };
  }

  factory RewardModel.empty() {
    return RewardModel(
      rewardId: 0,
      rewardTitle: '',
      rewardDescription: '',
      rewardPoints: 0,
      rewardUpdateAt: DateTime.now(),
      rewardCreatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        rewardId,
        rewardTitle,
        rewardDescription,
        rewardPoints,
        rewardUpdateAt,
        rewardCreatedAt,
      ];
}


class RewardModelList extends Equatable{
  final List<RewardModel> rewards;

  const RewardModelList({required this.rewards});

  factory RewardModelList.fromJson(Map<String, dynamic> json){
    List<RewardModel> rewards = [];
    for(var reward in json['rewards']){
      rewards.add(RewardModel.fromJson(reward));
    }
    return RewardModelList(rewards: rewards);
  }

  Map<String, dynamic> toJson(){
    return {
      'rewards': rewards.map((reward) => reward.toJson()).toList(),
    };
  }
  
  @override
  List<Object?> get props => [rewards];
}