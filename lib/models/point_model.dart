import 'package:equatable/equatable.dart';

class PointModel extends Equatable {
  final int pointId;
  final int userId;
  final int totalPoint;
  final DateTime lastearnedAt;

  const PointModel({
    required this.pointId,
    required this.userId,
    required this.totalPoint,
    required this.lastearnedAt,
  });

  @override
  List<Object?> get props => [
        pointId,
        userId,
        totalPoint,
        lastearnedAt,
      ];
}
