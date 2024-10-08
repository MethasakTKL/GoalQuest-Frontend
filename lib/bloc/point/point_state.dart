import 'package:goal_quest/models/models.dart';

sealed class PointState {
  final List<PointModel> points;
  final String error;
  PointState({required this.points, this.error = ''});
}

const List<PointModel> emptyPoints = [];

class LodingPointState extends PointState {
  LodingPointState() : super(points: emptyPoints);
}

class ReadyPointState extends PointState {
  ReadyPointState({required super.points});
}

class ErrorPointState extends PointState {
  ErrorPointState({required super.error}) : super(points: emptyPoints);
}
