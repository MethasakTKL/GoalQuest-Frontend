import 'package:equatable/equatable.dart';

class EarnedModel extends Equatable {
  final int earnedId;
  final int userId;
  final int taskId;
  final int earnedPoint;
  final DateTime earnedDate;

  const EarnedModel({
    required this.earnedId,
    required this.userId,
    required this.taskId,
    required this.earnedPoint,
    required this.earnedDate,
  });

  factory EarnedModel.fromJson(Map<String, dynamic> json){
    return EarnedModel(
      earnedId: json['earn_id'],
      userId: json['user_id'],
      taskId: json['task_id'],
      earnedPoint: json['points_earned'],
      earnedDate: DateTime.parse(json['earn_date']),
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'earn_id': earnedId,
      'user_id': userId,
      'task_id': taskId,
      'points_earned': earnedPoint,
      'earn_date': earnedDate,
    };
  }

  factory EarnedModel.empty(){
    return EarnedModel(
      earnedId: 0,
      userId: 0,
      taskId: 0,
      earnedPoint: 0,
      earnedDate: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        earnedId,
        userId,
        taskId,
        earnedPoint,
        earnedDate,
  ];
}

