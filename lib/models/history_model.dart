import 'package:equatable/equatable.dart';

class HistoryModel extends Equatable {
  final int historyId;
  final int userId;
  final int rewardId;
  final int pointsSpent;
  final DateTime redeemedDate;

  const HistoryModel({
    required this.historyId,
    required this.userId,
    required this.rewardId,
    required this.pointsSpent,
    required this.redeemedDate,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      historyId: json['history_id'],
      userId: json['user_id'],
      rewardId: json['reward_id'],
      pointsSpent: json['points_spent'],
      redeemedDate: DateTime.parse(json['redeemed_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'history_id': historyId,
      'user_id': userId,
      'reward_id': rewardId,
      'points_spent': pointsSpent,
      'redeemed_date': redeemedDate,
    };
  }

  factory HistoryModel.empty(){
    return HistoryModel(
      historyId: 0,
      userId: 0,
      rewardId: 0,
      pointsSpent: 0,
      redeemedDate: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        historyId,
        userId,
        rewardId,
        pointsSpent,
        redeemedDate,
      ];
}
