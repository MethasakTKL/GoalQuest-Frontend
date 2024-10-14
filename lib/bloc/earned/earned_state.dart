import 'package:goal_quest/models/models.dart';

sealed class EarnedState {
  final List<EarnedModel> earneds;
  final String error;
  EarnedState({required this.earneds, this.error = ''});
}

const List<EarnedModel> emptyEarneds = [];

class LoadingEarnedState extends EarnedState {
  LoadingEarnedState() : super(earneds: emptyEarneds);
}

class ReadyEarnedState extends EarnedState {
  ReadyEarnedState({required super.earneds});
}

class ErrorEarnedState extends EarnedState {
  ErrorEarnedState({required super.error}) : super(earneds: emptyEarneds);
}