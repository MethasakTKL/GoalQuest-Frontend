import 'package:equatable/equatable.dart';

class PointModel extends Equatable {
  final int? pointId;
  final int userId;
  final int totalPoint;
  final DateTime lastearnedAt;

  const PointModel({
    required this.pointId,
    required this.userId,
    required this.totalPoint,
    required this.lastearnedAt,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
      pointId: json['point_id'] != null ? json['point_id'] as int : null,
      userId: json['user_id'] as int,
      totalPoint: json['total_point'] as int,
      lastearnedAt: DateTime.parse(json['last_earned_at'] as String),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'point_id': pointId,
      'user_id': userId,
      'total_point': totalPoint,
      'last_earned_at': lastearnedAt.toIso8601String(),
    };
  }

  factory PointModel.empty() {
    return PointModel(
      pointId: 0,
      userId: 0,
      totalPoint: 0,
      lastearnedAt: DateTime.now(),
    );
  }
  @override
  List<Object?> get props => [
        pointId,
        userId,
        totalPoint,
        lastearnedAt,
      ];
}

class PointModelList extends Equatable{
  final List<PointModel> points;

  const PointModelList({
    required this.points,
  });

  factory PointModelList.fromJson(Map<String, dynamic> json){
    List<PointModel> points = [];
    for(var point in json['points']){
      points.add(PointModel.fromJson(point));
    }
    return PointModelList(
      points: points,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'points': points.map((point) => point.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        points,
      ];
}
